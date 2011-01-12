From: Len Brown <lenb@kernel.org>
Subject: ACPICA patches for 2.6.38 -v2
Date: Wed, 12 Jan 2011 04:38:01 -0500
Message-ID: <1294825090-21150-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:44692 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752984Ab1ALJiQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jan 2011 04:38:16 -0500
Received: from localhost.localdomain ([unknown] [108.7.58.61])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LEW006WRLFRYRA0@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 12 Jan 2011 03:38:16 -0600 (CST)
Received: from localhost.localdomain (x980 [127.0.0.1])
	by localhost.localdomain (8.14.4/8.14.4) with ESMTP id p0C9cDFu021189	for
 <linux-acpi@vger.kernel.org>; Wed, 12 Jan 2011 04:38:13 -0500
Received: (from lenb@localhost)	by localhost.localdomain (8.14.4/8.14.4/Submit)
 id p0C9cC2N021187	for linux-acpi@vger.kernel.org; Wed,
 12 Jan 2011 04:38:12 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

v2
refreshed the series on top of v2.6.37
incorporated Rafael's fix for "ACPICA: Implicit notify support"

thanks,
-Len

