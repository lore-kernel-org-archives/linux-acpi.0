From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPICA: Revert
 "ACPICA: Remove obsolete acpi_os_validate_address interface"
Date: Wed, 01 Jul 2009 22:03:55 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0907012202580.19077@localhost.localdomain>
References: <1246415391.24831.30.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:45024 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752697AbZGBCEQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Jul 2009 22:04:16 -0400
Received: from localhost.localdomain ([64.140.212.33])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KM400B8PTQKJHP8@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 01 Jul 2009 21:04:03 -0500 (CDT)
In-reply-to: <1246415391.24831.30.camel@minggr.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Thomas Renninger <trenn@suse.de>, "Moore, Robert" <robert.moore@intel.com>, Zhao Yakui <yakui.zhao@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

I can't apply a patch that adds a known memory leak,
even if it removes a conflict between drivers.

The reason is that there is a workaround for the driver conflict,
but no workaround for the memory leak.

thanks,
Len Brown, Intel Open Source Technology Center

