From: Len Brown <lenb@kernel.org>
Subject: [2.6.32.. stable PATCH] acpi-cpufreq: fix a memleak when unloading
 driver
Date: Mon, 01 Nov 2010 22:38:59 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1011012235360.14926@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:60538 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753018Ab0KBCjS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Nov 2010 22:39:18 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LB8008I7KP3WB24@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 01 Nov 2010 21:39:09 -0500 (CDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: stable@kernel.org
Cc: linux-acpi@vger.kernel.org

Hi Greg
Please cherry pick this 1-line patch from upstream into .stable

It applies at least as far back as 2.6.32.stable.

thanks,
-Len Brown, Intel Open Source Technology Center


Bcommit dab5fff14df2cd16eb1ad4c02e83915e1063fece
Author: Zhang Rui <rui.zhang@intel.com>
Date:   Tue Oct 12 09:09:37 2010 +0800

    acpi-cpufreq: fix a memleak when unloading driver

