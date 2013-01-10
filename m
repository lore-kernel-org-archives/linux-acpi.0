From: Davidlohr Bueso <davidlohr.bueso@hp.com>
Subject: srat: harsh hot-pluggable memory check?
Date: Thu, 10 Jan 2013 11:41:47 -0800
Message-ID: <1357846907.7523.17.camel@buesod1.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g6t0184.atlanta.hp.com ([15.193.32.61]:29951 "EHLO
	g6t0184.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754053Ab3AJTlv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Jan 2013 14:41:51 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Andi Kleen <andi@firstfloor.org>, zeus@gnu.org, linux-kernel@vger.kernel.org

When parsing the memory affinity mappings in arch/x86/mm/srat.c:
acpi_numa_memory_affinity_init() I'm wondering if the hot-pluggable check is too harsh, 
as we consider an error if the hot-pluggable bit is set and CONFIG_MEMORY_HOTPLUG is not.

Based on the ACPI specs (v5):

"If the Enabled bit is set and the Hot Pluggable bit is also set. The
system hardware supports hot-add and hot-remove of this memory
region."

This only mentions that the system supports hot-plugging, and IMHO if the
user decides not to use CONFIG_MEMORY_HOTPLUG, it shouldn't be considered an error.
Therefore would it be ok to drop the check? Or am I missing something?

Thanks,
Davidlohr

