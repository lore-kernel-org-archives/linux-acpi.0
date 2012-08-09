From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Kernel stops at "PM: Preparing system for mem sleep", never makes it to "Freezing user space processes ... "
Date: Thu, 9 Aug 2012 11:41:58 +0200
Message-ID: <201208091141.58586.rjw@sisk.pl>
References: <CACfp4335KJQ8Zjj0TJNj65Va9K-t_iEHLEGEi8QuWyQj5dVT0g@mail.gmail.com> <201208090033.52380.rjw@sisk.pl> <CACfp433snentBjXMaoLLnemD82-xRCZge9aCCRd1Ao=7yhG=RQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:50284 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755798Ab2HIJgE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Aug 2012 05:36:04 -0400
In-Reply-To: <CACfp433snentBjXMaoLLnemD82-xRCZge9aCCRd1Ao=7yhG=RQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Athlion <athlion@gmail.com>
Cc: linux-pm@vger.kernel.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

On Thursday, August 09, 2012, Athlion wrote:
> Thanks for the swift reply!
> 
> If I choose processors, I get (among other normal things) this:

What happens if you choose "core"?

> [  305.156134] suspend debug: Waiting for 5 seconds.
> [  310.149418] Enabling non-boot CPUs ...
> [  310.152933] Booting Node 0 Processor 1 APIC 0x1
> [  310.163948] Disabled fast string operations
> [  310.166366] ACPI Exception: AE_BAD_PARAMETER, Returned by Handler
> for [EmbeddedControl] (20120320/evregion-501)
> [  310.166369] ACPI Error: Method parse/execution failed
> [\_SB_.PCI0.LPC_.EC__.LPMD] (Node ffff88011824dc58), AE_BAD_PARAMETER
> (20120320/psparse-536)
> [  310.166374] ACPI Error: Method parse/execution failed
> [\_PR_.CPU0._PPC] (Node ffff88011827d118), AE_BAD_PARAMETER
> (20120320/psparse-536)
> [  310.166377] ACPI Error: Method parse/execution failed
> [\_PR_.CPU1._PPC] (Node ffff88011827d938), AE_BAD_PARAMETER
> (20120320/psparse-536)
> [  310.166382] ACPI Exception: AE_BAD_PARAMETER, Evaluating _PPC
> (20120320/processor_perflib-140)
> [  310.166393] CPU1 is up
> [  310.166455] Booting Node 0 Processor 2 APIC 0x2
> [  310.177563] Disabled fast string operations
> [  310.180057] ACPI Exception: AE_BAD_PARAMETER, Returned by Handler
> for [EmbeddedControl] (20120320/evregion-501)
> [  310.180061] ACPI Error: Method parse/execution failed
> [\_SB_.PCI0.LPC_.EC__.LPMD] (Node ffff88011824dc58), AE_BAD_PARAMETER
> (20120320/psparse-536)
> [  310.180066] ACPI Error: Method parse/execution failed
> [\_PR_.CPU0._PPC] (Node ffff88011827d118), AE_BAD_PARAMETER
> (20120320/psparse-536)
> [  310.180069] ACPI Error: Method parse/execution failed
> [\_PR_.CPU2._PPC] (Node ffff88011827daf0), AE_BAD_PARAMETER
> (20120320/psparse-536)
> [  310.180074] ACPI Exception: AE_BAD_PARAMETER, Evaluating _PPC
> (20120320/processor_perflib-140)
> [  310.180116] CPU2 is up
> [  310.180350] Booting Node 0 Processor 3 APIC 0x3
> [  310.191357] Disabled fast string operations
> [  310.193805] ACPI Exception: AE_BAD_PARAMETER, Returned by Handler
> for [EmbeddedControl] (20120320/evregion-501)
> [  310.193809] ACPI Error: Method parse/execution failed
> [\_SB_.PCI0.LPC_.EC__.LPMD] (Node ffff88011824dc58), AE_BAD_PARAMETER
> (20120320/psparse-536)
> [  310.193814] ACPI Error: Method parse/execution failed
> [\_PR_.CPU0._PPC] (Node ffff88011827d118), AE_BAD_PARAMETER
> (20120320/psparse-536)
> [  310.193817] ACPI Error: Method parse/execution failed
> [\_PR_.CPU3._PPC] (Node ffff88011827da50), AE_BAD_PARAMETER
> (20120320/psparse-536)
> [  310.193821] ACPI Exception: AE_BAD_PARAMETER, Evaluating _PPC
> (20120320/processor_perflib-140)
> [  310.193863] CPU3 is up
> [  310.196882] ACPI: Waking up from system sleep state S3
> [  310.444627] i915 0000:00:02.0: power state changed by ACPI to D0
> 
> I do not get these ACPI Error and ACPI Exceptions in a normal run. Is
> this normal?

No, it is not.

> Does it indicate a problem?

A small one.  It indicates that P-states as defined in the BIOS aren't
usable to the ACPI cpufreq driver.  There also seems to be a problem with
the handling of the embedded controller, which may be more serious.

> The dmesg of the pm-suspend after i have
> # echo "processors" > /sys/power/pm_test
> can be found here: https://dl.dropbox.com/u/63420/processors.txt
> 
> The dmesg of a full pm-suspend run is here
> https://dl.dropbox.com/u/63420/full.txt

That seems to be a clean suspend/resume cycle.  What's the problem, then?

Rafael
