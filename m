From: Bruno Ducrot <ducrot@poupinou.org>
Subject: Re: [PATCH] allow the highest frequency if bios think so.
Date: Tue, 21 Nov 2006 17:35:14 +0100
Message-ID: <20061121163514.GM4945@poupinou.org>
References: <EB12A50964762B4D8111D55B764A8454E76E62@scsmsx413.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from poup.poupinou.org ([195.101.94.96]:32282 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP id S1031156AbWKUQfe
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Nov 2006 11:35:34 -0500
Content-Disposition: inline
In-Reply-To: <EB12A50964762B4D8111D55B764A8454E76E62@scsmsx413.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: davej@redhat.com, cpufreq@lists.linux.org.uk, linux-acpi@vger.kernel.org

On Tue, Nov 21, 2006 at 07:08:57AM -0800, Pallipadi, Venkatesh wrote:
> Hmmm Great find.....
> A perfect example of the bug that was quietly hiding
> under our noses all these years....

Indeed.  I'm actually still surprised why I haven't found it in the
past.

> 
> >>  	if (ppc > pr->performance->state_count)
> >
> >BTW I'm wondering if this check should be :
> >	if (ppc >= pr->performance->state_count)
> >>  		goto out;
> >
> 
> Yes. I think this should change to >= as well.
> Otherwise indexing states with this ppc can go out of bounds.
> 

Updated.

Correct bound checking from the value returned from _PPC method.

Signed-off-by: Bruno Ducrot <ducrot@poupinou.org>

--- linux-2.6.19-rc6/drivers/acpi/processor_perflib.c	2006/11/21 10:18:39	1.1
+++ linux-2.6.19-rc6/drivers/acpi/processor_perflib.c	2006/11/21 16:28:04
@@ -83,10 +83,8 @@ static int acpi_processor_ppc_notifier(s
 		goto out;
 
 	ppc = (unsigned int)pr->performance_platform_limit;
-	if (!ppc)
-		goto out;
 
-	if (ppc > pr->performance->state_count)
+	if (ppc >= pr->performance->state_count)
 		goto out;
 
 	cpufreq_verify_within_limits(policy, 0,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
