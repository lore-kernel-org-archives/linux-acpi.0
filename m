From: "Brown, Len" <len.brown@intel.com>
Subject: RE: msi s271 (1058)
Date: Tue, 25 Jul 2006 12:00:51 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6010E4269@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:11411 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S932448AbWGYQSM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Jul 2006 12:18:12 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>, andreas guetl <andreas@guetl.net>
Cc: linux-acpi@vger.kernel.org


>> does anyone know a method to get the dsdt table on windows? 
>(windows x64 that is).

Doesn't matter -- the DSDT is provided by the  BIOS and is the
same under Windows and Linux.  So the acpidump output that you're
going to get from booting Linux with "acpi=off" and attach to bugzilla
should be sufficient.

However, If you have a Windows disk, it would be good to know that
Windows is able to boot in ACPI mode on this box.  You can verify
that it is in ACPI mode by pressing the power button and seeing
if it is SW controlled:-) else you can look in the device manager
at the device tree and ACPI will be at the top.

cheers,
-Len
