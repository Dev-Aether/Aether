#define GRIP_ATTACHMENT 1
#define SIGHTS_ATTACHMENT 2
#define BARREL_ATTACHMENT 3
#define MUZZLE_ATTACHMENT 4
#define STOCK_ATTACHMENT 5

/obj/item/attachable
	icon = 'icons/obj/guns/gun_attachments.dmi'
	icon_state = "grip"
	w_class = ITEM_SIZE_SMALL
	var/attach_icon = null //Attachment icon.
	var/pixel_shift_x = 16 //16 is centered. Negative values offset the sprite left. Positive values offset the sprite right.
	var/pixel_shift_y = 16 //16 is centered. Negative values offset the sprite down. Positive values offset the sprite up.
	var/slot = null //"muzzle", "rail", "under", "stock", "special"
	var/flags_attach_features = ATTACH_REMOVABLE
	var/light_mod = null

	var/accuracy_modifier = 0 //This number is added to your base accuracy
	var/acc_power_mod = 0 //This will add to our acc_power
	var/aim_slowdown_mod = 0 //Adds slowdown to the weapon when aiming
	var/screen_shake_mod = 0 //Reduces the screenshake of the weapon
	var/bulk_mod = 0 // Reduces or increases accuracy while moving

/obj/item/attachable/proc/Attach(var/obj/item/gun/G, mob/user)
	if(!istype(G)) return

	if(G.attachments[slot])
		var/obj/item/attachable/A = G.attachments[slot]
		A.Detach(G, user)

	if(flags_attach_features && ATTACH_ACTIVATION)
		verbs += /obj/item/attachable/proc/activate_attachable

	if(ishuman(loc))
		var/mob/living/carbon/human/M = src.loc
		M.drop_item(src)
	forceMove(G)
	G.attachments[slot] = src
	G.recalculate_attachment_bonuses()
	G.slowdown_per_slot[slot_l_hand] += aim_slowdown_mod
	G.slowdown_per_slot[slot_r_hand] += aim_slowdown_mod

/obj/item/attachable/proc/Detach(var/obj/item/gun/G, mob/user)
	if(!istype(G)) return //Guns only
	G.attachments[slot] = null
	G.recalculate_attachment_bonuses()
	if(flags_attach_features && ATTACH_ACTIVATION)
		activate_attachment(G, null, TRUE)

	forceMove(get_turf(G))
	user.put_in_hands(src)
	G.update_attachables()
	G.slowdown_per_slot[slot_l_hand] -= aim_slowdown_mod
	G.slowdown_per_slot[slot_r_hand] -= aim_slowdown_mod

/obj/item/gun/proc/update_attachables() //Debug. You generally don't need to use this.
	overlays.Cut()
	if(attachable_offset)
		for(var/slot in attachments)
			var/obj/item/attachable/R = attachments[slot]
			if(!R) continue
			update_attachment_overlays(R, R.slot)

/obj/item/gun/proc/update_attachable(attachable)
	if(attachable_offset && attachments[attachable])
		update_attachment_overlays(attachments[attachable], attachable)

/obj/item/gun/proc/update_attachment_overlays(var/obj/item/attachable/A, slot)
	var/image/I = attachable_overlays[slot]
	overlays -= I
	qdel(I)
	if(A) //Only updates if the attachment exists for that slot.
		var/item_icon = A.icon_state
		if(A.attach_icon)
			item_icon = A.attach_icon
		I = image(A.icon,src, item_icon)
		I.pixel_x = attachable_offset["[slot]_x"] - A.pixel_shift_x
		I.pixel_y = attachable_offset["[slot]_y"] - A.pixel_shift_y
		attachable_overlays[slot] = I
		overlays += I
	else attachable_overlays[slot] = null

/obj/item/gun/proc/can_attach_to_gun(mob/user, obj/item/attachable/attachment)
	if(attachable_allowed && !(attachment.type in attachable_allowed) )
		to_chat(user, SPAN_WARNING("[attachment] doesn't fit on [src]!"))
		return 0

	if(attachments[attachment.slot])
		var/obj/item/attachable/R = attachments[attachment.slot]
		if(R && !(R.flags_attach_features & ATTACH_REMOVABLE))
			to_chat(user, SPAN_WARNING("The attachment on [src]'s [attachment.slot] cannot be removed!"))
			return 0
	//To prevent floodlight guns
	if(attachment.light_mod)
		for(var/slot in attachments)
			var/obj/item/attachable/R = attachments[slot]
			if(!R)
				continue
			if(R.light_mod)
				to_chat(user, SPAN_WARNING("You already have a light source attachment on [src]."))
				return 0
	return 1

/obj/item/gun/proc/attach_to_gun(mob/user, obj/item/attachable/attachment)
	if(!can_attach_to_gun(user, attachment))
		return

	user.visible_message(SPAN_NOTICE("[user] begins attaching [attachment] to [src]."),
	SPAN_NOTICE("You begin attaching [attachment] to [src]."), null, 4)
	if(do_after(user, 20))
		if(attachment && attachment.loc)
			user.visible_message(SPAN_NOTICE("[user] attaches [attachment] to [src]."),
			SPAN_NOTICE("You attach [attachment] to [src]."), null, 4)
			user.drop_from_inventory(attachment)
			attachment.Attach(src, user)
			update_attachable(attachment.slot)
			//playsound(user, [SOUND PENDING], 25)

/obj/item/gun/proc/recalculate_attachment_bonuses()

	accuracy = initial(accuracy)
	screen_shake = initial(screen_shake)
	bulk = initial(bulk)

	for(var/slot in attachments)
		var/obj/item/attachable/R = attachments[slot]
		if(!R) continue
		accuracy += R.accuracy_modifier
		screen_shake -= R.screen_shake_mod
		bulk += R.bulk_mod

/obj/item/attachable/verticalgrip
	name = "vertical grip"
	desc = "A vertical foregrip that offers less loss of accuracy while moving."
	icon_state = "vgrip"
	attach_icon = "vgrip_a"
	slot = "under"
	bulk_mod = -1
	aim_slowdown_mod = -5

/obj/item/attachable/angledgrip
	name = "angled grip"
	desc = "A angled foregrip that faster movement speed while firing."
	icon_state = "agrip"
	attach_icon = "agrip_a"
	slot = "under"
	bulk_mod = -2

/obj/item/attachable/holosight
	name = "holosight"
	desc = "A digital sight that quickly acquires targetting data for the user."
	icon_state = "holosight"
	attach_icon = "holosight_a"
	slot = "rail"
	accuracy_modifier = 3

/obj/item/attachable/unremoveable_stock
	name = "stock"
	desc = "You shouldn't see this."
	icon_state = "tp19stock"
	attach_icon = "tp19stock_a"
	flags_attach_features = null
	slot = "stock"

/obj/item/attachable/proc/activate_attachable(mob/living/user, obj/item/gun/G)
	set name = "Toggle-Attachment"
	set category = "Object"
	set src in usr
	activate_attachment(G, user)

/obj/item/attachable/proc/activate_attachment(atom/target, mob/user)
	return
