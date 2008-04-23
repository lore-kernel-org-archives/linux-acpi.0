From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: ACPI on HP Pavilion dv2765tx, c-states problems
Date: Wed, 23 Apr 2008 22:00:06 +0400
Message-ID: <480F7926.1090406@gmail.com>
References: <funj2g$obi$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hs-out-0708.google.com ([64.233.178.246]:26492 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756502AbYDWSAH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Apr 2008 14:00:07 -0400
Received: by hs-out-0708.google.com with SMTP id 4so1698056hsl.5
        for <linux-acpi@vger.kernel.org>; Wed, 23 Apr 2008 11:00:05 -0700 (PDT)
In-Reply-To: <funj2g$obi$1@ger.gmane.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Michael Sotnikov <astar@tut.by>
Cc: linux-acpi@vger.kernel.org

Michael Sotnikov wrote:
> Hi,
>
> I hope, that I'm writing to the correct group. I've tried to find the
> reason behind my problem, but didn't manage to.
>
> The problem:
> Can't start acpi_cpufreq ("No such device"), but p4_cpuclock driver
> works well. In this case there is no c-state management (cpu is always
> in C0).
>
It might be that support for EST (enhanced speed-step) is disabled in BIOS.
In this case BIOS does not export PDC/PPC methods and acpi_cpufreq does 
not load.

Please check if your BIOS has EST  enabled.
If yes and you still can not load acpi_cpufreq, please provide acpidump 
output and /proc/cpuinfo.
> I've decompiled dsdt - only some warnings about methods related to pci.
> Checked _OSI() - nothing special.
>
> There are errors in dmesg, related to cpu's info (truncated):
> -----
> [ 17.045653] ACPI Warning (tbutils-0217): Incorrect checksum in table 
> [SSDT] -  E6, should be 38 [20070126]
> ....
> [ 19.458760] ACPI Error (psargs-0355): [TS0T] Namespace lookup failure,
> AE_NOT_FOUND
> [ 19.458765] ACPI Error (psparse-0537): Method parse/execution failed
> [\_PR_.CPU0._PDC] (Node f7c51b88), AE_NOT_FOUND
> [ 19.459076] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
> [ 19.459278] ACPI: SSDT 7FED09A4, 00C8 (r1 PmRef Cpu1Ist 3000 INTL 
> 20061109)
> [ 19.459465] ACPI: SSDT 7FED06E7, 0085 (r1 PmRef Cpu1Cst 3000 INTL 
> 20061109)
> [ 19.459641] ACPI Error (psargs-0355): [\_PR_.CPU0._PPC] Namespace
> lookup failure, AE_NOT_FOUND
> [ 19.459645] ACPI Error (psparse-0537): Method parse/execution failed
> [\_PR_.CPU1._PPC] (Node f7ccf180), AE_NOT_FOUND
> [ 19.459895] ACPI Error (psargs-0355): [\_PR_.CPU0._CST] Namespace
> lookup failure, AE_NOT_FOUND
> [ 19.459899] ACPI Error (psparse-0537): Method parse/execution failed
> [\_PR_.CPU1._CST] (Node f7ccf1f8), AE_NOT_FOUND
> [ 19.459979] ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
> --------
>
> I've checked it with 2.6.25 kernel - same errors.
> My main system (ubuntu 8.04):
>
> $ uname -a
> Linux astar-laptop 2.6.24-16-generic #1 SMP Thu Apr 10 13:23:42 UTC 
> 2008 i686 GNU/Linux
>
> Is there any solutions, except waiting firmware update from laptop 
> vendor?
>
> Best regards,
> Michael
>
>
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

