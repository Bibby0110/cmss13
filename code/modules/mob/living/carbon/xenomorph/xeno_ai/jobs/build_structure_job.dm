/datum/ai_job/build_structure
	name = "Building Structure"
	var/turf/target_turf
	var/datum/resin_construction/structure_type

/datum/ai_job/build_structure/perform_job()
	if(!worker)
		return AI_JOB_FAILED

	if(get_dist(target_turf, get_turf(worker)) <= 1)
		state = start_building()
		return state

	if(state == AI_JOB_INPROGRESS)
		path_to_target()
		return AI_JOB_INPROGRESS

	path_to_job = AStar(get_turf(worker), target_turf, /turf/proc/AdjacentTurfs, /turf/proc/Distance)

	if(!length(path_to_job))
		return AI_JOB_FAILED

	state = AI_JOB_INPROGRESS
	return AI_JOB_INPROGRESS


/datum/ai_job/build_structure/proc/start_building()
	worker.selected_resin = structure_type
	var/datum/action/xeno_action/action = worker.automated_actions["BUILD"]
	action = new action()
	action.give_to(worker) //todo: don't remake the actions every time
	if(action.use_ability_wrapper(target_turf, list()))
		action.remove_from(worker)
		return AI_JOB_COMPLETE
	else
		action.remove_from(worker)
		return AI_JOB_FAILED

/datum/ai_job/build_structure/proc/path_to_target()
	var/turf/next = path_to_job[1]
	if(get_turf(worker) == next)
		path_to_job -= next
		next = path_to_job[1]

	walk_to(worker, next, 0, worker.movement_delay())
