From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 00/24] acpi4asus update
Date: Fri, 28 Aug 2009 15:33:07 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908281524080.27023@localhost.localdomain>
References: <1251464215-6540-1-git-send-email-corentincj@iksaif.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:62923 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301AbZH1TdY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Aug 2009 15:33:24 -0400
Received: from localhost.localdomain ([64.140.212.33])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KP3008PQQB9E808@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 28 Aug 2009 14:33:15 -0500 (CDT)
In-reply-to: <1251464215-6540-1-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentincj@iksaif.net>
Cc: linux-acpi@vger.kernel.org, alan-jenkins@tuffmail.co.uk

Thanks for the series Corentin,
it applied and built cleanly.

Please go to

http://patchwork.kernel.org/project/linux-acpi/list/?order=submitter
and mark the patches from Alan that you forwarded in state "Superceded"
so that I don't end up trying to apply them again when I get
to sifting through the many patches from Alan.

I fixed a couple of whitespace warnings like this:
WARNING: suspect code indent for conditional statements (8, 17)
#459: FILE: drivers/platform/x86/eeepc-laptop.c:1150:
+	if (!device)
+		 return -EINVAL;

please run checkpatch.pl on your patches before submitting
them so that we don't trip on trivial stuff like this.

This one is considered an actual error by the checkpatch maintainers:

ERROR: do not use C99 // comments
#1466: FILE: drivers/platform/x86/asus-laptop.c:89:
+#define KEY_ON      0x200       //Keyboard backlight

I left it alone since it was consistent with the existing code.
Please send a single patch to convert all of these at once.

thanks,
Len Brown, Intel Open Source Technology Center
