From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Subject: Re: debugging 600E
Date: Wed, 01 Feb 2006 12:58:07 +0000
Message-ID: <E1F4HYl-00061y-00@skye.ra.phy.cam.ac.uk>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005E22331@hdsmsx401.amr.corp.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:57070 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932398AbWBAM6J (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 1 Feb 2006 07:58:09 -0500
In-Reply-To: Your message of "Mon, 30 Jan 2006 17:55:07 EST."
             <F7DC2337C7631D4386A2DF6E8FB22B3005E22331@hdsmsx401.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, linux-acpi@vger.kernel.org

>>     osl-0854 [545] os_wait_semaphore     : Failed to acquire
>>        semaphore[e3fce660|1|100], AE_TIME

> Probably an EC issue.  Do you still see this with the latest
> ACPI patch or mm tree (which includes EC interrupt mode).

I just tried 2.6.16-rc1 + acpi-release-20060113-2.6.16-rc1.diff.  That
gets rid of the os_wait_semaphore messages, but acpi still hangs for
about 10 seconds and then reports information only for battery 2.

As a side benefit, 2.6.16-rc1 + acpi-release-20060113-2.6.16-rc1.diff
fixed the general problem of "os_wait_semaphore : Failed to acquire
semaphore" messages.  See my report at
<http://bugzilla.kernel.org/show_bug.cgi?id=5008> and the C program
that could reliably generate them again.  [Bug #5008 was eventually
marked 'closed', but that's after the discussion diverged to a related
topic: why 'acpi' was so slow, and that problem did improve with
2.6.15.]

I tried the C program with 2.6.15 and it immediately generated many
os_wait_semaphore messages.  I rebooted into the
2.6.16-rc1+acpi-20060113 and the C program didn't generate any
messages.

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
