From: Nathan Lynch <ntl-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC 5/6]clean cpu state after hotremove CPU
Date: Mon, 4 Apr 2005 00:28:44 -0500
Message-ID: <20050404052844.GB3611@otto>
References: <1112580367.4194.344.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1112580367.4194.344.camel-U5EdaLXB8smDugQYiPIPGdh3ngVCH38I@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Zwane Mwaikambo <zwane-T6AQWPvKiI1fDP7aoN8Z5Q@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Apr 04, 2005 at 10:07:02AM +0800, Li Shaohua wrote:
> Clean up all CPU states including its runqueue and idle thread, 
> so we can use boot time code without any changes.
> Note this makes /sys/devices/system/cpu/cpux/online unworkable.

In what sense does it make the online attribute unworkable?


> diff -puN kernel/exit.c~cpu_state_clean kernel/exit.c
> --- linux-2.6.11/kernel/exit.c~cpu_state_clean	2005-03-31 10:50:27.000000000 +0800
> +++ linux-2.6.11-root/kernel/exit.c	2005-03-31 10:50:27.000000000 +0800
> @@ -845,6 +845,65 @@ fastcall NORET_TYPE void do_exit(long co
>  	for (;;) ;
>  }
>  
> +#ifdef CONFIG_STR_SMP
> +void do_exit_idle(void)
> +{
> +	struct task_struct *tsk = current;
> +	int group_dead;
> +
> +	BUG_ON(tsk->pid);
> +	BUG_ON(tsk->mm);
> +
> +	if (tsk->io_context)
> +		exit_io_context();
> +	tsk->flags |= PF_EXITING;
> + 	tsk->it_virt_expires = cputime_zero;
> + 	tsk->it_prof_expires = cputime_zero;
> +	tsk->it_sched_expires = 0;
> +
> +	acct_update_integrals(tsk);
> +	update_mem_hiwater(tsk);
> +	group_dead = atomic_dec_and_test(&tsk->signal->live);
> +	if (group_dead) {
> + 		del_timer_sync(&tsk->signal->real_timer);
> +		acct_process(-1);
> +	}
> +	exit_mm(tsk);
> +
> +	exit_sem(tsk);
> +	__exit_files(tsk);
> +	__exit_fs(tsk);
> +	exit_namespace(tsk);
> +	exit_thread();
> +	exit_keys(tsk);
> +
> +	if (group_dead && tsk->signal->leader)
> +		disassociate_ctty(1);
> +
> +	module_put(tsk->thread_info->exec_domain->module);
> +	if (tsk->binfmt)
> +		module_put(tsk->binfmt->module);
> +
> +	tsk->exit_code = -1;
> +	tsk->exit_state = EXIT_DEAD;
> +
> +	/* in release_task */
> +	atomic_dec(&tsk->user->processes);
> +	write_lock_irq(&tasklist_lock);
> +	__exit_signal(tsk);
> +	__exit_sighand(tsk);
> +	write_unlock_irq(&tasklist_lock);
> +	release_thread(tsk);
> +	put_task_struct(tsk);
> +
> +	tsk->flags |= PF_DEAD;
> +#ifdef CONFIG_NUMA
> +	mpol_free(tsk->mempolicy);
> +	tsk->mempolicy = NULL;
> +#endif
> +}
> +#endif

I don't understand why this is needed at all.  It looks like a fair
amount of code from do_exit is being duplicated here.  We've been
doing cpu removal on ppc64 logical partitions for a while and never
needed to do anything like this.  Maybe idle_task_exit would suffice?


> diff -puN kernel/sched.c~cpu_state_clean kernel/sched.c
> --- linux-2.6.11/kernel/sched.c~cpu_state_clean	2005-03-31 10:50:27.000000000 +0800
> +++ linux-2.6.11-root/kernel/sched.c	2005-04-04 09:06:40.362357104 +0800
> @@ -4028,6 +4028,58 @@ void __devinit init_idle(task_t *idle, i
>  }
>  
>  /*
> + * Initial dummy domain for early boot and for hotplug cpu. Being static,
> + * it is initialized to zero, so all balancing flags are cleared which is
> + * what we want.
> + */
> +static struct sched_domain sched_domain_dummy;
> +
> +#ifdef CONFIG_STR_SMP
> +static void __devinit exit_idle(int cpu)
> +{
> +	runqueue_t *rq = cpu_rq(cpu);
> +	struct task_struct *p = rq->idle;
> +	int j, k;
> +	prio_array_t *array;
> +
> +	/* init runqueue */
> +	spin_lock_init(&rq->lock);
> +	rq->active = rq->arrays;
> +	rq->expired = rq->arrays + 1;
> +	rq->best_expired_prio = MAX_PRIO;
> +
> +	rq->prev_mm = NULL;
> +	rq->curr = rq->idle = NULL;
> +	rq->expired_timestamp = 0;
> +
> +	rq->sd = &sched_domain_dummy;
> +	rq->cpu_load = 0;
> +	rq->active_balance = 0;
> +	rq->push_cpu = 0;
> +	rq->migration_thread = NULL;
> +	INIT_LIST_HEAD(&rq->migration_queue);
> +	atomic_set(&rq->nr_iowait, 0);
> +
> +	for (j = 0; j < 2; j++) {
> +		array = rq->arrays + j;
> +		for (k = 0; k < MAX_PRIO; k++) {
> +			INIT_LIST_HEAD(array->queue + k);
> +			__clear_bit(k, array->bitmap);
> +		}
> +		// delimiter for bitsearch
> +		__set_bit(MAX_PRIO, array->bitmap);
> +	}
> +	/* Destroy IDLE thread.
> +	 * it's safe now, the CPU is in busy loop
> +	 */
> +	if (p->active_mm)
> +		mmdrop(p->active_mm);
> +	p->active_mm = NULL;
> +	put_task_struct(p);
> +}
> +#endif
> +
> +/*
>   * In a system that switches off the HZ timer nohz_cpu_mask
>   * indicates which cpus entered this state. This is used
>   * in the rcu update to wait only for active cpus. For system
> @@ -4432,6 +4484,9 @@ static int migration_call(struct notifie
>  			complete(&req->done);
>  		}
>  		spin_unlock_irq(&rq->lock);
> +#ifdef CONFIG_STR_SMP
> +		exit_idle(cpu);
> +#endif

I don't understand the need for this, either.  The existing cpu
hotplug notifier in the scheduler takes care of initializing the sched
domains and groups appropriately for online/offline events; why do you
need to touch the runqueue structures?


Nathan


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
