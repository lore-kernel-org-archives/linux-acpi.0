From: Vincent Pelletier <plr.vincent@gmail.com>
Subject: Kohjinsha SH8 "BIOS _OSI(Linux) query ignored"
Date: Sun, 25 May 2008 10:15:48 +0200
Message-ID: <200805251015.48826.plr.vincent@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:18104 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752705AbYEYIQH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 25 May 2008 04:16:07 -0400
Received: by fg-out-1718.google.com with SMTP id 19so902875fgg.17
        for <linux-acpi@vger.kernel.org>; Sun, 25 May 2008 01:15:55 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Reporting as requested by dmesg:

[    0.166001] ACPI: BIOS _OSI(Linux) query ignored
[    0.166017] ACPI: DMI System Vendor: KOHJINSHA CO.,LTD.
[    0.166026] ACPI: DMI Product Name: SH series
[    0.166035] ACPI: DMI Product Version: Not Applicable
[    0.166044] ACPI: DMI Board Name: S37
[    0.166052] ACPI: DMI BIOS Vendor: Phoenix Technologies LTD
[    0.166062] ACPI: DMI BIOS Date: 08/30/07
[    0.166070] ACPI: Please send DMI info above to linux-acpi@vger.kernel.org
[    0.166082] ACPI: If "acpi_osi=Linux" works better, please notify 
linux-acpi@vger.kernel.org

Debian sid, kernel 2.6.25-2 .
"acpi_osi=Linux" not attemped (what would "work better" ?).

Side note: battery information is not available via /proc/acpi, though 
detected during boot:
[   14.638146] ACPI: Battery Slot [BAT0] (battery present)
It was available in 2.6.24, disapeared since 2.6.25.

--
Vincent Pelletier
