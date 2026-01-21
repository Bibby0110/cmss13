#define AI_JOB_NOTBEGUN 0
#define AI_JOB_INPROGRESS 1
#define AI_JOB_FAILED 2
#define AI_JOB_COMPLETE 3

/datum/ai_job
	var/name = "base job, should never be used"
	var/mob/living/carbon/xenomorph/lesser_drone/ai/worker
	var/list/path_to_job
	var/state = AI_JOB_NOTBEGUN
	var/priority = 1

/datum/ai_job/proc/perform_job()
	return AI_JOB_FAILED
