From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] cpufreq: ondemand: update frequency when limits are relaxed
Date: Fri, 7 Sep 2012 22:48:55 +0200
Message-ID: <201209072248.55384.rjw@sisk.pl>
References: <F22FC3EF73EF0942A7CD99A3AC5E4E1F380AF6B7BF@HQMAIL04.nvidia.com> <201209062340.33610.rjw@sisk.pl> <201209071013.56871.trenn@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <201209071013.56871.trenn@suse.de>
Sender: cpufreq-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Michal Pecio <mpecio@nvidia.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Friday, September 07, 2012, Thomas Renninger wrote:
> On Thursday, September 06, 2012 11:40:33 PM Rafael J. Wysocki wrote:
> > On Friday, August 31, 2012, Michal Pecio wrote:
> > > From: Michal Pecio <mpecio@nvidia.com>
> > > 
> > > Reevaluate CPU load and update frequency immediately whenever limits 
> > > are changed. Currently ondemand doesn't do so when limits are relaxed,
> > > wasting power on CPUs with relatively low sampling rate.
> > > Also, update the prev_cpu_* variables on frequency transitions. Their
> > > old values aren't valid anymore because the governor assumes constant
> > > frequency during entire sampling period.
> > > 
> > > Signed-off-by: Michal Pecio <mpecio@nvidia.com>
> > 
> > Well, this makes sense to me.
> > 
> > Thomas, what do you think?
> Looks fine to me as well.
> But the same should be done in the conservative driver as well then.
> Could you  send another, separate patch doing the same in 
> cpufreq_conservative.c.

Do you mean something like the appended patch?

Rafael


---
 drivers/cpufreq/cpufreq_conservative.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

Index: linux/drivers/cpufreq/cpufreq_conservative.c
===================================================================
--- linux.orig/drivers/cpufreq/cpufreq_conservative.c
+++ linux/drivers/cpufreq/cpufreq_conservative.c
@@ -576,14 +576,7 @@ static int cpufreq_governor_dbs(struct c
 
 	case CPUFREQ_GOV_LIMITS:
 		mutex_lock(&this_dbs_info->timer_mutex);
-		if (policy->max < this_dbs_info->cur_policy->cur)
-			__cpufreq_driver_target(
-					this_dbs_info->cur_policy,
-					policy->max, CPUFREQ_RELATION_H);
-		else if (policy->min > this_dbs_info->cur_policy->cur)
-			__cpufreq_driver_target(
-					this_dbs_info->cur_policy,
-					policy->min, CPUFREQ_RELATION_L);
+		dbs_check_cpu(this_dbs_info);
 		mutex_unlock(&this_dbs_info->timer_mutex);
 
 		break;
