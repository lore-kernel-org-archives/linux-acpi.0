From: Len Brown <lenb@kernel.org>
Subject: 2.6.30-rc3 video/i915 build error
Date: Thu, 23 Apr 2009 12:36:33 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904231231100.15830@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:31166 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768AbZDWQgr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Apr 2009 12:36:47 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KIK00DD0BH1PXN8@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Apr 2009 11:36:40 -0500 (CDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>, Eric Anholt <eric@anholt.net>, rui.zhang@intel.com, Keith Packard <keithp@keithp.com>
Cc: linux-acpi@vger.kernel.org

I thought we had addressed this, no?
(not that this is a reasonable/realistic config, but it is possible)

For
CONFIG_DRM_I915=y
CONFIG_ACPI_VIDEO=m

drivers/built-in.o: In function `intel_opregion_init':
(.text+0x9d540): undefined reference to `acpi_video_register'


Len Brown, Intel Open Source Technology Center
