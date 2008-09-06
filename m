From: "William Dupre" <william.dupre@gmail.com>
Subject: (in plain text ;-) dmesg info from DELL XPS 1730 running Ubuntu Live CD
Date: Sat, 6 Sep 2008 09:15:00 +0000
Message-ID: <fb5a4d380809060215m4689d121qe8b397febfdb4ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.233]:8056 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685AbYIFJPB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 6 Sep 2008 05:15:01 -0400
Received: by rv-out-0506.google.com with SMTP id k40so758416rvb.1
        for <linux-acpi@vger.kernel.org>; Sat, 06 Sep 2008 02:15:00 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi guys,

Browsing dmesg for RAID info before installing Ubuntu on the drive, I
found a request to send you this info.
Just one question : what change could make the acpi_osi=Linux ? and
how could I test it ?

Thanks
William

[   55.442244] ACPI: EC: Look up EC in DSDT
[   55.442349] ACPI: BIOS _OSI(Linux) query ignored
[   55.442350] ACPI: DMI System Vendor: Dell Inc.
[   55.442351] ACPI: DMI Product Name: MXG071
[   55.442353] ACPI: DMI Product Version:
[   55.442354] ACPI: DMI Board Name: 0KX412
[   55.442355] ACPI: DMI BIOS Vendor: Dell Inc.
[   55.442356] ACPI: DMI BIOS Date: 10/30/2007
[   55.442357] ACPI: Please send DMI info above to linux-acpi@vger.kernel.org
[   55.442358] ACPI: If "acpi_osi=Linux" works better, please notify
linux-acpi@vger.kernel.org
[   55.479719] ACPI: SSDT CBE82880, 0043 (r1  LMPWR  DELLLOM     1001
INTL 20050624)
[   55.479846] ACPI: Interpreter enabled
[   55.479849] ACPI: (supports S0 S3 S4 S5)
[   55.479859] ACPI: Using IOAPIC for interrupt routing
[   55.497264] ACPI: PCI Root Bridge [PCI0] (0000:00)
