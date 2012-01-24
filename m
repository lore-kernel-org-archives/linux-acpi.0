From: Len Brown <lenb@kernel.org>
Subject: ACPI & Power Management Patches for Linux 3.3-rc1
Date: Mon, 23 Jan 2012 20:29:59 -0500
Message-ID: <1327368609-28409-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:57381 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754834Ab2AXBab (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jan 2012 20:30:31 -0500
Received: from localhost.localdomain ([unknown] [74.104.158.190])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LYA00DF546CJ4D1@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 23 Jan 2012 19:30:18 -0600 (CST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org

This fixes a merge-window regression due to a conflict
between error injection and preparation to remove atomicio.c
Here we fix that regression and complete the removal
of atomicio.c.

This also re-orders some idle initializtion code to
complete the merge window series that allows cpuidle
to cope with bringing processors on-line after boot.

Please let me know if you see issues with any of these patches.

thanks,
Len Brown, Intel Open Source Technolgy Center

