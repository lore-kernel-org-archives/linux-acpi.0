From: Len Brown <lenb@kernel.org>
Subject: 2.6.20 poweroff regression on se7525gp2
Date: Mon, 5 Feb 2007 00:12:38 -0500
Message-ID: <200702050012.38485.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39251 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752713AbXBEFNz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 5 Feb 2007 00:13:55 -0500
Received: from d975xbx2.site (c-65-96-213-102.hsd1.ma.comcast.net [65.96.213.102])
	(authenticated bits=0)
	by hera.kernel.org (8.13.8/8.13.7) with ESMTP id l155CiZh014199
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Mon, 5 Feb 2007 05:13:53 GMT
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

With 2.6.19.2, init 0 works
with 2.6.20, it causes this box to reset when it should poweroff, and thus it reboots.

any suggestions on where to look first?

thanks,
-Len

Success case:

Linux version 2.6.19.2 (lenb@d975xbx2) (gcc version 4.1.2 20061115 (prerelease) (SUSE Linux)) #5 SMP Sun Feb
Command line: root=/dev/sda2 console=tty0 console=ttyS0,115200n8 debug                                       
...
# init 0
...
The system will be halted immediately.
Synchronizing SCSI cache for disk sda:
ACPI: PCI interrupt for device 0000:06:03.0 disabled
ACPI: PCI interrupt for device 0000:05:06.1 disabled
ACPI: PCI interrupt for device 0000:05:06.0 disabled
ACPI: PCI interrupt for device 0000:05:04.1 disabled
ACPI: PCI interrupt for device 0000:05:04.0 disabled
Power down.
acpi_power_off called
 hwsleep-0285 [02] enter_sleep_state     : Entering sleep state [S5]

Failure case:

Linux version 2.6.20 (lenb@d975xbx2) (gcc version 4.1.2 20061115 (prerelease) (SUSE Linux)) #1 SMP Sun Feb 
Command line: root=/dev/sda2 console=tty0 console=ttyS0,115200n8 debug                                       
...
# init 0
...
The system will be halted immediately.
Synchronizing SCSI cache for disk sda:
ACPI: PCI interrupt for device 0000:06:03.0 disabled
ACPI: PCI interrupt for device 0000:05:06.1 disabled
ACPI: PCI interrupt for device 0000:05:06.0 disabled
ACPI: PCI interrupt for device 0000:05:04.1 disabled
ACPI: PCI interrupt for device 0000:05:04.0 disabled
Power down.
acpi_power_off called
 hwsleep-0285 [02] enter_sleep_state     : Entering sleep state [S5]
