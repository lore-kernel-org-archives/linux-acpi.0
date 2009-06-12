From: Frans Pop <elendil@planet.nl>
Subject: hp-wmi: reading hddtemp results in ACPI errors
Date: Fri, 12 Jun 2009 22:35:21 +0200
Message-ID: <200906122235.22872.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from Cpsmtpm-eml110.kpnxchange.com ([195.121.3.14]:62590 "EHLO
	CPSMTPM-EML110.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753848AbZFLUfW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 12 Jun 2009 16:35:22 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>

On my HP 2510p notebook I get five ACPI errors when the hp-wmi driver 
attempts to read hddtemp.

$ cat /sys/bus/platform/devices/hp-wmi/hddtemp
cat: /sys/bus/platform/devices/hp-wmi/hddtemp: Invalid argument

In dmesg this results in:
ACPI Exception (exoparg2-0445): AE_AML_PACKAGE_LIMIT, Index (000000002) is 
beyond end of object [20090320]
ACPI Error (psparse-0537): Method parse/execution failed [\_TZ_.C2FA] 
(Node ffff88007e042420), AE_AML_PACKAGE_LIMIT
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.C2BB.C2D9] 
(Node ffff88007e040180), AE_AML_PACKAGE_LIMIT
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.C2BB.C2D0] 
(Node ffff88007e01efc0), AE_AML_PACKAGE_LIMIT
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.C2BB.WMAA] 
(Node ffff88007e040120), AE_AML_PACKAGE_LIMIT

Would it be possible to improve the driver to prevent these errors?


Somewhat related, the value of 'display' seems rather strange:
$ cat /sys/bus/platform/devices/hp-wmi/display
65795
Any idea if that's correct or not and what the meaning of that value is?

Cheers,
FJP
