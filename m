From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v3 00/16] ACPI graph support
Date: Thu, 23 Feb 2017 18:19:20 +0200
Message-ID: <1487866776-24578-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:49521 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751158AbdBWQ0H (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 23 Feb 2017 11:26:07 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Cc: sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

Hello everyone, 

I posted a previous RFC labelled set of ACPI graph support a while ago: 

<URL:http://www.spinics.net/lists/linux-acpi/msg69547.html> 

Since then, the matter of how the properties should be used as in ACPI
_DSD was discussed in Ksummit and LPC, and a document detailing the rules 
was written [1].

I've additionally posted v1 and v2 which can be found here:

<URL:http://www.spinics.net/lists/linux-acpi/msg71661.html>
<URL:http://www.spinics.net/lists/linux-acpi/msg71809.html>

This set contains patches written by Mika Westerberg and by myself. The 
patchset brings support for graphs to ACPI. The functionality achieved by 
these patches is very similar to what the Device tree provides: the port
and the endpoint concept are being employed. The patches make use of the
_DSD property and data extensions to achieve this. The fwnode interface is
extended by graph functionality; this way graph information originating 
from both OF and ACPI may be accessed using the same interface, without 
being aware of the underlying firmware interface. 

The last patch of the set contains ASL documentation including an example.

The entire set may also be found here (on mediatree.git master, but it
also applies cleanly on linux-next):

<URL:https://git.linuxtv.org/sailus/media_tree.git/log/?h=acpi-graph> 

The resulting fwnode graph interface has been tested using V4L2 async with
fwnode matching and smiapp and omap3isp drivers, with appropriate changes 
to make use of the fwnode interface in drivers.

I'm additionally moving the firmware implementation specific code from
drivers/base/property.c to firmware specific locations. I'll post that
patchset soon. It'll be available here:

<URL:https://git.linuxtv.org/sailus/media_tree.git/log/?h=acpi-graph-cleaned>

The V4L2 patches can be found here. The fwnode graph interface is used by 
the newly added V4L2 fwnode framework which replaces the V4L2 OF
framework, with equivalent functionality. 

<URL:https://git.linuxtv.org/sailus/media_tree.git/log/?h=v4l2-acpi>

changes since v2.2:

- Drop device_fwnode_handle() function in favour of moving the existing
  dev_fwnode() function from drivers/base/property.c to linux/property.h
  (now patch 12).

- Unmerge two unrelated patches accidentally merged between RFC v1 and
  PATCH v1 of the series. The patch adding device_fwnode_handle() was
  accidentally merged with "device property: Obtain device's fwnode
  independently of FW type".

- Remove redundant forward declaration of struct device in
  linux/property.h.

changes since v2:

- Include linux/property.h for property fwnode API in additional drivers
  (current patch 11).

changes since v1: 

- Fix a few checkpatch.pl warnings in Mika's patches (too long lines),

- remove the "endpoint" property specifying the endpoint id. The endpoint 
id is a software concept and the index in the endpoint array can be used
instead if needed. The changes are in patches "device property: Add 
support for fwnode endpoints" and "ACPI / DSD: Document references, 
ports and endpoints" and

- add patch "irqchip/gic: Add missing forward declaration for 
struct device" (patch 9) to fix compilation warning on arm64 caused 
by "of: No need to include linux/property.h, linux/fwnode.h is
sufficient" (now patch 10)

changes since RFC v1: 

- Rebased the set --- there were a few conflicts. 

- Fixed a bug in ACPI graph parsing. (Thanks to Mika!)

- Remove one layer (the "ports" node) of the _DSD hierarchical data 
structure. Change the documentation accordingly. Instead, rely on the 
presence of "port" and "endpoint" properties to identify port and 
endpoint nodes. 

- Add a reference the DSD property rule document [1].

-- 
Kind regards,
Sakari

