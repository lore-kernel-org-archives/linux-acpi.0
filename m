From: "Brown, Len" <len.brown@intel.com>
Subject: Linux/ACPI home page edit
Date: Tue, 27 Mar 2007 17:29:33 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB602D7F738@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:2055 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965483AbXC0V3g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Mar 2007 17:29:36 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Yu, Ling L" <ling.l.yu@intel.com>
Cc: linux-acpi@vger.kernel.org

Yu-Ling,

http://acpi.sourceforge.net/patches.html
is massively out of date.  Please delete it,
plus the link to it from here:
http://acpi.sourceforge.net/

The pointer to
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/README.A
CPI
is still valid, however, and the latest patch information lives there.

Speaking of the project home page....
We haven't used the term ACPI4Linux for years.
My personal preference is to globally replace it with "Linux/ACPI"
on the web pages.

Also, I think you can replace all the text on the home page with that
below.

thanks,
-Len
----------

Linux/ACPI Overview 

ACPI <http://www.acpi.info/> puts the OS in control of system
configuration and power management.
Further, it acts as a hardware abstraction layer between the OS and the
platform BIOS --
allowing the OS and the platform to evolve independently.  See the
Documentation section for further information.

The Linux/ACPI project is focused on making Linux run well on all
ACPI-enabled platforms.
Linux/ACPI is based on Intel's ACPI Component Architecture (ACPICA)
reference implementation.
<http://www.intel.com/technology/iapc/acpi/downloads.htm>

A central goal of the project is that any computer whose ACPI
implementation boots
and runs Windows properly, should also boot and run Linux properly.
This means that if Linux needs any ACPI-related command-line parameters
or a modified BIOS DSDT to boot and run properly,
then you should file a Linux bug.

To participate in the project, the latest information on filing bugs
and submitting patches is here:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/README.A
CPI
