From: Frank Rehberger <Frank.Rehberger@web.de>
Subject: Medion Akoya 1210: BIOS _OSI(Linux) query ignored
Date: Sat, 17 Jan 2009 23:53:13 +0100
Message-ID: <1232232793.6996.3.camel@cereza>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmmailgate02.web.de ([217.72.192.227]:53885 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755339AbZAQWxQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 17 Jan 2009 17:53:16 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id D5FEBF8FEC08
	for <linux-acpi@vger.kernel.org>; Sat, 17 Jan 2009 23:53:14 +0100 (CET)
Received: from [217.83.79.251] (helo=[192.168.1.101])
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LOK2U-00051d-00
	for linux-acpi@vger.kernel.org; Sat, 17 Jan 2009 23:53:14 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi, 

the "Medion Akoya 1210" is a re-branded MSI-Wind U100, it seems the ACPI
is not supported correctly. I get the following message
in /var/log/messages.


Jan 14 14:32:07 cereza kernel: [    0.791904] ACPI: BIOS _OSI(Linux)
query ignored
Jan 14 14:32:07 cereza kernel: [    0.791911] ACPI: DMI System Vendor:
MEDION
Jan 14 14:32:07 cereza kernel: [    0.791915] ACPI: DMI Product Name:
E1210
Jan 14 14:32:07 cereza kernel: [    0.791919] ACPI: DMI Product Version:
Ver.001
Jan 14 14:32:07 cereza kernel: [    0.791923] ACPI: DMI Board Name:
E1210
Jan 14 14:32:07 cereza kernel: [    0.791928] ACPI: DMI BIOS Vendor:
American Me
gatrends Inc.
Jan 14 14:32:07 cereza kernel: [    0.791932] ACPI: DMI BIOS Date:
06/26/2008
Jan 14 14:32:07 cereza kernel: [    0.791936] ACPI: Please send DMI info
above to linux-acpi@vger.kernel.org
Jan 14 14:32:07 cereza kernel: [    0.791942] ACPI: If "acpi_osi=Linux"
works better, please notify linux-acpi@vger.kernel.org
Jan 14 14:32:07 cereza kernel: [    0.797629] ACPI: Interpreter enabled
Jan 14 14:32:07 cereza kernel: [    0.797635] ACPI: (supports S0 S1 S3
S4 S5)
Jan 14 14:32:07 cereza kernel: [    0.797676] ACPI: Using IOAPIC for
interrupt routing


