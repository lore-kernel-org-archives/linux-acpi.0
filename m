From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/2] Default to ACPI reboots on newish X86 hardware
Date: Sat, 23 Jan 2010 14:57:28 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001231455440.5156@localhost.localdomain>
References: <alpine.LFD.2.00.1001200007560.4265@localhost.localdomain>
 <1264094323-7187-1-git-send-email-ch@zeha.at>
 <1264094323-7187-2-git-send-email-ch@zeha.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:54634 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888Ab0AWT5p (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 23 Jan 2010 14:57:45 -0500
In-reply-to: <1264094323-7187-2-git-send-email-ch@zeha.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Christian Hofstaedtler <ch@zeha.at>
Cc: x86@kernel.org, hpa@zytor.com, tglx@linutronix.de, linux-acpi@vger.kernel.org, venkatesh.pallipadi@intel.com, arjan@infradead.org, bruce.w.allan@intel.com, linux-kernel@vger.kernel.org

Hi Christian,
I've replaced your previous patch in the acpi-test tree with this 
refreshed pair.

Note that the 2nd patch had some checkpatch issues.
Perhaps you can run checkpatch before sending future patches.

WARNING: braces {} are not necessary for single statement blocks
#35: FILE: arch/x86/kernel/reboot.c:464:
+	if (!dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL)) {
+		return 1;
+	}

WARNING: braces {} are not necessary for single statement blocks
#38: FILE: arch/x86/kernel/reboot.c:467:
+	if (year == 0) {
+		return 1;
+	}

WARNING: braces {} are not necessary for single statement blocks
#43: FILE: arch/x86/kernel/reboot.c:472:
+	if (year < 2003) {
+		return 0;
+	}

ERROR: Missing Signed-off-by: line(s)

total: 1 errors, 3 warnings, 47 lines checked


thanks,
Len Brown, Intel Open Source Technology Center

