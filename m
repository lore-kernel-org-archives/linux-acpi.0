From: typo3@linuxmaker.de
Subject: Network and mouse failed with DSDT in initrd
Date: Fri, 27 Jan 2006 18:41:56 +0100 (CET)
Message-ID: <20060127174156.6734040040@smtp.it-netzwerkservice.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from swallow.it-netzwerkservice.net ([213.30.246.176]:15507 "EHLO
	smtp.it-netzwerkservice.net") by vger.kernel.org with ESMTP
	id S1750964AbWA0Rml (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 27 Jan 2006 12:42:41 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.it-netzwerkservice.net (Postfix) with ESMTP id 8BF0840042
	for <linux-acpi@vger.kernel.org>; Fri, 27 Jan 2006 18:42:40 +0100 (CET)
Received: from smtp.it-netzwerkservice.net ([127.0.0.1])
	by localhost (swallow [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 31430-09 for <linux-acpi@vger.kernel.org>;
	Fri, 27 Jan 2006 18:42:31 +0100 (CET)
Received: from tux (localhost.localdomain [127.0.0.1])
	by smtp.it-netzwerkservice.net (Postfix) with SMTP id 6734040040
	for <linux-acpi@vger.kernel.org>; Fri, 27 Jan 2006 18:41:56 +0100 (CET)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hello,

I use an ACER Extensa 4101WLMi Laptop with the BIOS-ID S3C23 and the operating system Debian Linux 3.1 with a self compiled kernel (2.6.15.1).
I have found a howto for generate a DSDT into the initrd at following sites http://gaugusch.at/kernel.shtml. In your repository I found two DSDT-Tables for ACER Extensa 4100WLMi with S3C23. So I use ACER-Extensa_4100WLMi-S3C23-original.asl to build my DSDT.aml like that HowTo above.
If I put down DSDT.aml into my /boot/initrd and I reboot my machine I can see, the state of battery will displayed and klaptop pick out the informations.
But now, me Laptop don't recognize at booting the card of network. And additional the response time of my USB-Mouse becomes very slow.
Do you know what gets here wrong? Or do you with DSDT in your repository is the right for my laptop? I have attempted to make a dsdt.dat with the second DSDT-table ACER-Extensa_4100WLMi-S3C23-custom. But the command
iasl -d ACER-Extensa_4100WLMi-S3C23-custom
tells me some errors:
"ACPI Error (tbutils-0252): Table signature at 0xbf8b2120 [0xbf8b20ec] has invalid characters
ACPI Warning (tbutils-0255): Invalid table signature found:][
Table header is invalid!
Could not get table from the file"

Also, if you can tell me, what I have to do right, in this case I become lucky!

Thank you,
Andreas
