From: Stefan Becker <Stefan.Becker@nokia.com>
Subject: ACPI DMI info for Dell Precision WorkStation 380
Date: Mon, 18 Feb 2008 07:44:37 +0200
Message-ID: <47B91B45.9060007@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:43785 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350AbYBRFpO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Feb 2008 00:45:14 -0500
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m1I5ixLv030047
	for <linux-acpi@vger.kernel.org>; Mon, 18 Feb 2008 07:45:11 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

as requested by the kernel message:

kernel: 2.6.23.15-137.fc8PAE  (Fedora 8)

Without acpi_osi=

ACPI: BIOS _OSI(Linux) query ignored
ACPI: DMI System Vendor: Dell Inc.
ACPI: DMI Product Name: Precision WorkStation 380
ACPI: DMI Product Version:
ACPI: DMI Board Name: 0CJ774
ACPI: DMI BIOS Vendor: Dell Inc.
ACPI: DMI BIOS Date: 01/08/2007
ACPI: Please send DMI info above to linux-acpi@vger.kernel.org
ACPI: If "acpi_osi=Linux" works better, please notify 
linux-acpi@vger.kernel.org

With acpi_osi=Linux

ACPI: Added _OSI(Linux)
ACPI: BIOS _OSI(Linux) query honored via cmdline
ACPI: DMI System Vendor: Dell Inc.
ACPI: DMI Product Name: Precision WorkStation 380
ACPI: DMI Product Version:
ACPI: DMI Board Name: 0CJ774
ACPI: DMI BIOS Vendor: Dell Inc.
ACPI: DMI BIOS Date: 01/08/2007
ACPI: Please send DMI info above to linux-acpi@vger.kernel.org

Dell BIOS version is A09

Regards,

	Stefan

---
Stefan Becker
E-Mail: Stefan.Becker@nokia.com
