From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 00/15] ACPI graph support
Date: Fri, 27 Jan 2017 18:02:55 +0200
Message-ID: <1485532990-8431-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:3158 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754725AbdA0QIL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 27 Jan 2017 11:08:11 -0500
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

The V4L2 patches can be found here. The fwnode graph interface is used by
the newly added V4L2 fwnode framework which replaces the V4L2 OF
framework, with equivalent functionality.

<URL:https://git.linuxtv.org/sailus/media_tree.git/log/?h=v4l2-acpi>


changes since RFC v1:

- Rebased the set --- there were a few conflicts.

- Fixed a bug in ACPI graph parsing. (Thanks to Mika!)

- Remove one layer (the "ports" node) of the _DSD hierarchical data
  structure. Change the documentation accordingly. Instead, rely on the
  presence of "port" and "endpoint" properties to identify port and
  endpoint nodes.

- Add a reference the DSD property rule document [1].


Feedback is welcome.


[1] Documentation/acpi/DSD-properties-rules.txt

-- 
Kind regards,
Sakari

