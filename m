From: Jonathan Freiermuth <jfreiermuth@vela.com>
Subject: ACPI DMI output during kernel boot
Date: Mon, 10 Nov 2008 10:01:58 -0500
Message-ID: <200811101001.58479.jfreiermuth@vela.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.vela.com ([199.227.51.132]:22320 "HELO velamail.vela.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1755853AbYKKM46 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Nov 2008 07:56:58 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Came across this output while booting a new (to me, not brand spanking new) pc 
with kernel 2.6.25 (gentoo sources). So here you are:

ACPI: EC: Look up EC in DSDT
ACPI: BIOS _OSI(Linux) query ignored
ACPI: DMI System Vendor: Dell Inc.              
ACPI: DMI Product Name: Dell DXP051
ACPI: DMI Product Version:
ACPI: DMI Board Name: 0FJ030
ACPI: DMI BIOS Vendor: Dell Inc.
ACPI: DMI BIOS Date: 01/08/2007
ACPI: Please send DMI info above to linux-acpi@vger.kernel.org
ACPI: If "acpi_osi=Linux" works better, please notify 
linux-acpi@vger.kernel.org

-- 
Jonathan Freiermuth
Sr. Software Engineer
Vela Research
