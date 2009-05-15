From: Tulio Magno Quites Machado Filho <tuliom@quites.com.br>
Subject: Failed to switch brightness with an emachines
Date: Fri, 15 May 2009 09:08:22 +0200
Message-ID: <20090515070822.GA4121@joutaro.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:33729 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754092AbZEOGyM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 May 2009 02:54:12 -0400
Received: by ewy24 with SMTP id 24so2232524ewy.37
        for <linux-acpi@vger.kernel.org>; Thu, 14 May 2009 23:54:12 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,

I have got a bug here really weird. I thought it was the same as http://bugzilla.kernel.org/show_bug.cgi?id=13121 but I tried to make a patch for my emachines E510 without success. Maybe (and probably) I have made a mistake.
This notebook is from a subsidiary of Acer(emachines) and they have most software in commom and probably the ACPI table.

So, the description of the bug is the same as bug #13121, but the difference is that after a suspend to disk, everything seems to work fine, except that I continue to get the messages "ACPI: Failed to switch the brightness".

I have also seen this in dmesg:
[    0.262435] ACPI Warning (nspredef-0331): \_SB_.PCI0._OSC: Parameter count mismatch - ASL declared 5, ACPI requires 4 [20090320]

I'm running Linus' kernel 2.6.30-rc5.

Any ideas to solve this?

I'm not in the list so, please add my e-mail address in the replies.

Thank you,

-- 
Tulio Magno

