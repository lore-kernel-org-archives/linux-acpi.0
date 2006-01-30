From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Subject: Re: debugging 600E
Date: Mon, 30 Jan 2006 04:15:25 +0000
Message-ID: <E1F3QRq-0001e5-00@skye.ra.phy.cam.ac.uk>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005D9812B@hdsmsx401.amr.corp.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:57323 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751237AbWA3EP2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Jan 2006 23:15:28 -0500
In-Reply-To: Your message of "Thu, 26 Jan 2006 13:16:27 EST."
             <F7DC2337C7631D4386A2DF6E8FB22B3005D9812B@hdsmsx401.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, linux-acpi@vger.kernel.org

>From <http://bugzilla.kernel.org/show_bug.cgi?id=5966>

> Looking at the Thinkpad web site, there is a newer BIOS for the
> 600E.  I've got INET28WW (1.08), and INET36WW (1.16) is available.

Just a word of warning about the 600X bios dates, which might apply to
the 600E as well.  On the 600X, the latest BIOS claims to be from
1999, but that date is almost surely wrong.  The readme/changelog with
the BIOS update diskette is dated Sept 20, 2001 and contains this note
about the 1.01 update:

 - (Fix) If Windows 98 Second Edition is installed as APM mode and
         an updated BIOS is installed with a BIOS date 12/02/99 or 
         later, Windows 98SE will change the mode from APM to ACPI 
         whenever a New hardware profile is created.  So this BIOS 
         set the date to 11-30-99. 

Probably they've marked all the dates as 11-30-99 in order to keep
working around this W98SE misfeature.  My guess is that BIOS 1.11 is
really from Sept 2001.

Also, I noticed that you need a working battery in order to update the
BIOS.  I have a spare 600X battery, which should work in the 600E and
I would lend you.  It is brand new, IBM/Lenovo, and I just opened the
box to verify that it works.

Unfortunately, the laptop doesn't even recognize the battery (even
after a reboot).  'acpi' stalls for 5-10 seconds, and the dmesg has
many of these lines

     osl-0854 [545] os_wait_semaphore     : Failed to acquire
        semaphore[e3fce660|1|0], AE_TIME
     osl-0854 [545] os_wait_semaphore     : Failed to acquire
        semaphore[e3fce660|1|100], AE_TIME

and then it reports charge information only for battery 2 (the extra
battery that replaces the CD/DVD slot).

If this is a software (ACPI) problem, let me know and I'll try tests
here.  If it's a hardware problem with the battery, I'll send it back
for a replacement.  But if you think the battery would work in your
600E anyway, I'll send it to you.

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
