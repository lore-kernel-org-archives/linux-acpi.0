From: Michael Sotnikov <astar@tut.by>
Subject: ACPI on HP Pavilion dv2765tx, c-states problems
Date: Thu, 24 Apr 2008 00:02:38 +0900
Message-ID: <funj2g$obi$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:58498 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752731AbYDWPPE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 Apr 2008 11:15:04 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JoggY-0005EX-TS
	for linux-acpi@vger.kernel.org; Wed, 23 Apr 2008 15:15:02 +0000
Received: from 211.237.219.102 ([211.237.219.102])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Wed, 23 Apr 2008 15:15:02 +0000
Received: from astar by 211.237.219.102 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Wed, 23 Apr 2008 15:15:02 +0000
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I hope, that I'm writing to the correct group. I've tried to find the
reason behind my problem, but didn't manage to.

The problem:
Can't start acpi_cpufreq ("No such device"), but p4_cpuclock driver
works well. In this case there is no c-state management (cpu is always
in C0).

I've decompiled dsdt - only some warnings about methods related to pci.
Checked _OSI() - nothing special.

There are errors in dmesg, related to cpu's info (truncated):
-----
[ 17.045653] ACPI Warning (tbutils-0217): Incorrect checksum in table 
[SSDT] -  E6, should be 38 [20070126]
....
[ 19.458760] ACPI Error (psargs-0355): [TS0T] Namespace lookup failure,
AE_NOT_FOUND
[ 19.458765] ACPI Error (psparse-0537): Method parse/execution failed
[\_PR_.CPU0._PDC] (Node f7c51b88), AE_NOT_FOUND
[ 19.459076] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[ 19.459278] ACPI: SSDT 7FED09A4, 00C8 (r1 PmRef Cpu1Ist 3000 INTL 20061109)
[ 19.459465] ACPI: SSDT 7FED06E7, 0085 (r1 PmRef Cpu1Cst 3000 INTL 20061109)
[ 19.459641] ACPI Error (psargs-0355): [\_PR_.CPU0._PPC] Namespace
lookup failure, AE_NOT_FOUND
[ 19.459645] ACPI Error (psparse-0537): Method parse/execution failed
[\_PR_.CPU1._PPC] (Node f7ccf180), AE_NOT_FOUND
[ 19.459895] ACPI Error (psargs-0355): [\_PR_.CPU0._CST] Namespace
lookup failure, AE_NOT_FOUND
[ 19.459899] ACPI Error (psparse-0537): Method parse/execution failed
[\_PR_.CPU1._CST] (Node f7ccf1f8), AE_NOT_FOUND
[ 19.459979] ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
--------

I've checked it with 2.6.25 kernel - same errors.
My main system (ubuntu 8.04):

$ uname -a
Linux astar-laptop 2.6.24-16-generic #1 SMP Thu Apr 10 13:23:42 UTC 2008 
i686 GNU/Linux

Is there any solutions, except waiting firmware update from laptop vendor?

Best regards,
Michael


