From: "Song, Youquan" <youquan.song@intel.com>
Subject: RE: MSR Len Brown Sept 12, 2012
Date: Thu, 13 Sep 2012 04:59:21 +0000
Message-ID: <70A3B115BE79814398B8E4E7C4AE18EE1164BE@SHSMSX101.ccr.corp.intel.com>
References: <1A7043D5F58CCB44A599DFD55ED4C94828CD99A4@FMSMSX108.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:38848 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753170Ab2IME7b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Sep 2012 00:59:31 -0400
In-Reply-To: <1A7043D5F58CCB44A599DFD55ED4C94828CD99A4@FMSMSX108.amr.corp.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>, "Schlobohm, Bruce" <bruce.schlobohm@intel.com>
Cc: SSD-OTC ALL <ssd-otc.all@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Song, Youquan" <youquan.song@intel.com>

>cpuidle BOF had Scheduler people (PeterZ) stating that the Scheduler should do the idle prediction logic and it makes no sense to duplicate it in cpuidle governor.
>This is a very promising prospect.

When tasking moved to CPU running, it will wake up CPU from C-states, it is reasonable for scheduler to prediction. However, interrupt coming also wake up CPU from C-states, how can schedule predict it?  Interrupt is not task, so it is out of scheduler scope.
So I do not think it is duplicated in cpuidle even though possible idle prediction in scheduler for task. In addition, scheduler is not agile for cpuidle prediction because scheduler granularity is at milli-seconds level (HZ) while C-state entry/exit is at micro-seconds level.  What's more, scheduler is too big/heavy to do fully prediction for cpuidle, it will scarify scheduler performance. 

I think that the doable things scheduler at it are there: 1. when task is generated, scheduler do not put it to idlest scheduler_domain/schedule_group, it in according current task assignment and power saving(/performance) policy to predict which is the best target scheduler_domain/schedule_group which will benefit package C-state/Core C-state entry in recent future.  2. when load balance also can do the same prediction.  If nobody deny, I will quickly write sample code for testing.


Thanks & Regards, 
Song, Youquan 
Intel SSG/SSD/OTC 
MOB: 13681289076 
TEL: 010-85711549 
INET: 8-571-1549 
LOC: GTC/BJ 18W025


-----Original Message-----
From: Brown, Len 
Sent: Thursday, September 13, 2012 1:28 AM
To: Schlobohm, Bruce
Cc: SSD-OTC ALL; linux-acpi@vger.kernel.org
Subject: MSR Len Brown Sept 12, 2012

> Presented "ACPI 5.0 in Linux" at Linux Plumber's Conference:

http://www.linuxplumbersconf.org/2012/wp-content/uploads/2012/09/LPC2012-ACPI5.pdf

There was some hallway discussion about ACPI for ARM, but none in the forum.  Notably, Grant Likely, the Linaro developer responsible for ACPI/ARM, was stuck in the UK.

OTC has a reactive stance on ACPI/ARM.  We maintain Linux/ACPI, and will thus accept patches from the Linux community if they want Linux to support ACPI/ARM.  As yet, we've received no such patches or RFCs.

I do see a lot of activity from Linaro on cpuidle, and very high interest in thermals and cpufreq.

> Participated in Linux Kernel Summit, LPC, took some photos:

https://picasaweb.google.com/106626681355613318425/2012SanDiego

Linus valued Rafael's regression tracking summary e-mail.
Rafael doesn't do this anymore.  Volunteers are burnt out on it and SuSE no longer pays Rafael to do it.

Linus doesn't use bugzilla because it is poor for initial sightings.
More information is usually needed before an issue can be worked.
Further, many submitters produce low signal/noise and an intelligent maintainer must work with them to get the needed info.

Unfortunately, the community tends to translate this into "Linus thinks bugzilla is bad, so we should ignore it."

Google stated that their useful testing is done with "internal applications", and that "available benchmarks tend to be out of date"

Fengguang's automated build & test setup is well regarded.

cpuidle BOF had Scheduler people (PeterZ) stating that the Scheduler should do the idle prediction logic and it makes no sense to duplicate it in cpuidle governor.
This is a very promising prospect.

My raw KS and LPC notes are attached, for those interested.

> 2-week vacation at Philmont Scout Ranch in New Mexico:

https://picasaweb.google.com/BSA157/Philmont2012#5784140983380897058

All survived.  Only one minor physical injury (I broke a toe).

