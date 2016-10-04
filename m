From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [RFC 00/15] ACPI graph support
Date: Wed,  5 Oct 2016 01:45:33 +0300
Message-ID: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:22043 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752699AbcJDWr2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 4 Oct 2016 18:47:28 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: mika.westerberg@linux.intel.com, rafael@kernel.org

Hello everyone,

I've been working awhile with my collegue Mika Westerberg to bring
firmware graph support to ACPI based systems. In practice the
functionality achieved by these patches is very similar to what the Device
tree provides: the port and the endpoint concept are being employed. The
patches make use of the _DSD property and data extensions to achieve this.
The fwnode interface is extended by graph functionality; this way graph
information originating from both OF and ACPI may be accessed using the
same interface.

The last patch of the set contains ASL documentation including and
example.

The entire set may also be found here:

<URL:https://git.linuxtv.org/sailus/media_tree.git/log/?h=acpi-graph>

The resulting fwnode graph interface has been tested using V4L2 async with
fwnode matching and smiapp and omap3isp drivers, with appropriate changes
to make use of the fwnode interface.

The V4L2 patches can be found here --- I'll send them to the linux-media
list in the near future:

<URL:https://git.linuxtv.org/sailus/media_tree.git/log/?h=v4l2-acpi>

Both sets can be found here, applied on the same tree (the V4L2 patches
depend on other patches not in Linus's tree yet):

<URL:https://git.linuxtv.org/sailus/media_tree.git/log/?h=v4l2-acpi-on-graph>

Feedback would be very welcome.

-- 
Kind regards,
Sakari

