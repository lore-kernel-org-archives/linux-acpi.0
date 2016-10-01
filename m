From: Nilay Vaish <nilayvaish@gmail.com>
Subject: Re: [PATCH v5 1/9] sched: Extend scheduler's asym packing
Date: Sat, 1 Oct 2016 11:38:04 -0500
Message-ID: <CACbG30-L_U=iES=+VNGSbOTsT_q3_Nvu_XVqSh6SGdua6n+ejQ@mail.gmail.com>
References: <1475322326-160112-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1475322326-160112-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1475322326-160112-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de, x86 <x86@kernel.org>, linux-pm@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, peterz@infradead.org, tim.c.chen@linux.intel.com, jolsa@redhat.com
List-Id: linux-acpi@vger.kernel.org

On 1 October 2016 at 06:45, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index e86c4a5..08135ca 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6237,7 +6237,25 @@ static void init_sched_groups_capacity(int cpu, struct sched_domain *sd)
>         WARN_ON(!sg);
>
>         do {
> +               int cpu, max_cpu = -1, prev_cpu = -1;
> +
>                 sg->group_weight = cpumask_weight(sched_group_cpus(sg));
> +
> +               if (!(sd->flags & SD_ASYM_PACKING))
> +                       goto next;
> +
> +               for_each_cpu(cpu, sched_group_cpus(sg)) {
> +                       if (prev_cpu < 0) {
> +                               prev_cpu = cpu;
> +                               max_cpu = cpu;

It seems that you can drop prev_cpu and put the check on max_cpu instead.

--
Nilay
