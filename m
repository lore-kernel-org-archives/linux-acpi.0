From: Sven Wegener <sven.wegener@stealer.net>
Subject: acer-wmi broken in latest git kernel on TravelMate 6492 (Insufficient
 arguments - method [WQAA])
Date: Sat, 2 Aug 2008 17:50:54 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0808021640310.2294@titan.stealer.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.stealer.net ([88.198.224.204]:33289 "EHLO
	smtp1.stealer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755692AbYHBPvI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 2 Aug 2008 11:51:08 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: Bob Moore <robert.moore@intel.com>, Andi Kleen <ak@linux.intel.com>, Lin Ming <ming.m.lin@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi all,

running Linus' latest (2b12a4c) git kernel, acer-wmi triggers the 
following ACPI Error on my Acer TravelMate 6492:

acer-wmi: Acer Laptop ACPI-WMI Extras
ACPI Error (nseval-0159): Insufficient arguments - method [WQAA] needs 1, found 0 [20080609]
acer-wmi: Unable to detect available WMID devices

Reverting commit f3454ae8104efb2dbf0d08ec42c6f5d0fe9225bc (ACPICA: Add 
argument count checking to control method invocation via 
acpi_evaluate_object) makes acer_wmi work as before.

Doing a little debugging the call trace starting at acer_wmi_init() is:

WMID_set_capabilities() (called from drivers/misc/acer-wmi.c:1192)
wmi_query_block(WMID_GUID2, 1, &out) (called from drivers/misc/acer-wmi.c:747)
acpi_evaluate_object(handle, method, NULL, out) (called from drivers/acpi/wmi.c:350)
acpi_ns_evaluate(info) (called from drivers/acpi/namespace/nsxfeval.c:258)

Is it a bug in acer-wmi or in Acer's ACPI implementation? I can provide 
more information as necessary.

Sven
