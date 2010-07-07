From: Len Brown <lenb@kernel.org>
Subject: gpe patches vs ACPICA updates
Date: Tue, 06 Jul 2010 23:07:39 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1007062304560.5977@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:54228 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822Ab0GGDH4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Jul 2010 23:07:56 -0400
Received: from localhost.localdomain ([unknown] [64.140.212.33])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L56005TU3CTZ9ND@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 06 Jul 2010 22:07:47 -0500 (CDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org

Rafael,
Bob and Lin-Ming sucked a bunch of your patches into ACPICA.

However, there are text changes, so some of your subsequent
patches, no longer cleanly apply.

In particular, these no longer apply if ACPICA is underneath:


commit 9227a22eb1dadbc746b9792c26a311f6eb49b86b
Author: Rafael J. Wysocki <rjw@sisk.pl>
Date:   Mon Jul 5 00:59:12 2010 +0200

    ACPI / ACPICA: Do not execute _PRW methods during initialization

commit be6d74ee134c5c01d8c0537924ab76aefc0b1201
Author: Rafael J. Wysocki <rjw@sisk.pl>
Date:   Mon Jul 5 01:00:49 2010 +0200

    ACPI / ACPICA: Simplify acpi_ev_initialize_gpe_block()


commit b8baccf5c9728c7c15292d833528302c743e5892
Author: Rafael J. Wysocki <rjw@sisk.pl>
Date:   Mon Jul 5 01:01:36 2010 +0200

    ACPI / ACPICA: Fail acpi_gpe_wakeup() if ACPI_GPE_CAN_WAKE is unset

