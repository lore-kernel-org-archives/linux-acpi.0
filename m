From: "dhanya" <dhanya.justin@wipro.com>
Subject: How to get PCI slot information from ACPI
Date: Fri, 12 Jan 2007 14:16:59 +0530
Message-ID: <200701120839.OAA13480@wipro.tcpn.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wip-ec-mm01.wipro.com ([203.91.193.25]:43954 "EHLO
	wip-ec-mm01.wipro.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161041AbXALIrZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Jan 2007 03:47:25 -0500
Received: from wip-ec-mm01.wipro.com (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with ESMTP id C623E1F609C
	for <linux-acpi@vger.kernel.org>; Fri, 12 Jan 2007 14:17:22 +0530 (IST)
Received: from wipro.tcpn.com (adm.wipro.tcpn.com [172.31.41.11])
	by wip-ec-mm01.wipro.com (Postfix) with ESMTP id AD39C1F61BE
	for <linux-acpi@vger.kernel.org>; Fri, 12 Jan 2007 14:17:22 +0530 (IST)
Received: from EC4HP134180 ([172.31.42.81])
	by wipro.tcpn.com (8.9.3/8.9.3) with ESMTP id OAA13480
	for <linux-acpi@vger.kernel.org>; Fri, 12 Jan 2007 14:09:45 +0530 (IST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I am working on "Server Diagnostics Project". Our requirement is to display
the PCI slot information by retrieving the  ACPI Device Identification
Objects _SUN. I have couple of questions related to that.

My observations from ACPI Specs 3.0a are

1) ACPI Namespace

A hierarchical tree structure in OS-controlled memory that contains named
objects. These objects may be data objects, control method objects,
bus/device package objects, and so on. The OS dynamically changes the
contents of the namespace at run-time by loading and/or unloading definition
blocks from the ACPI Tables that reside in the ACPI BIOS. All the
information in the ACPI Namespace comes from the Differentiated System
Description Table (DSDT), which contains the Differentiated Definition
Block, and one or more other definition blocks.

2) Differentiated System Description Table (DSDT)

An OEM must supply a DSDT to an ACPI-compatible OS. The DSDT contains the
Differentiated Definition Block, which supplies the implementation and
configuration information about the base system. The OS always inserts the
DSDT information into the ACPI Namespace at system boot time and never
removes it.

And I have couple of questions related to that.

1) From the above two observations what I have understood is _SUN object
will be present in DSDT table. Is this assumption is true or not?

2) When this _SUN object will be present in DSDT table for PCI device? 
Is it for only HOT Plug PCI devices?
Or
Any system which has a PCI device will contain _SUN object?

3) If particular machine having PCI device and not having _SUN object in
DSDT table what is that mean?

4) What is that ACPI BIOS how it relate to DSDT table?


Thanks in advance,
Dhanya



