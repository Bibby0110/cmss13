/datum/xenomorph_ai_controller
	var/PriorityQueue/jobs = new /PriorityQueue(/proc/JobPriorityCompare)

/datum/xenomorph_ai_controller/proc/get_job()
	return jobs.Dequeue()

/datum/xenomorph_ai_controller/proc/add_job(datum/ai_job/job)
	jobs.Enqueue(job)

/proc/JobPriorityCompare(datum/ai_job/a, datum/ai_job/b)
	return a.priority - b.priority
