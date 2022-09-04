//inverse of /datum/artifact_effect/cold, the two effects split up for neatness' sake
/datum/artifact_effect/heat
	name = "heat"
	var/target_temp

/datum/artifact_effect/heat/New()
	..()
	effect = pick(EFFECT_TOUCH, EFFECT_AURA)
	effect_type = pick(EFFECT_ORGANIC, EFFECT_BLUESPACE, EFFECT_SYNTH)
	target_temp = rand(300, 600)

/datum/artifact_effect/heat/DoEffectTouch(mob/user)
	if(holder)
		if (istype(user))
			to_chat(user, "<span class='warning'>You feel a wave of heat travel up your spine!</span>")
		var/datum/gas_mixture/env = holder.loc.return_air()
		if(env)
			env.temperature += rand(5,50)

/datum/artifact_effect/heat/DoEffectAura()
	if(holder)
		var/datum/gas_mixture/env = holder.loc.return_air()
		if(env && env.temperature < target_temp)
			env.temperature += pick(0, 0, 1)

/datum/artifact_effect/heat/destroyed_effect()
	. = ..()

	for (var/turf/T in trange(5, get_turf(holder)))
		var/datum/gas_mixture/env = T.return_air()
		if (env)
			env.temperature += 10
