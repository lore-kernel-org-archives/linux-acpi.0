From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: New eMCA trace event interface
Date: Thu, 15 May 2014 04:30:39 -0400
Message-ID: <1400142646-10127-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:43589 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751254AbaEOJA4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 May 2014 05:00:56 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony.luck@intel.com, bp@alien8.de, m.chehab@samsung.com
Cc: linux-acpi@vger.kernel.org

[PATCH 1/7 v5] trace, RAS: Add basic RAS trace event
[PATCH 2/7 v3] trace, AER: Move trace into unified interface
[PATCH 3/7 v4] CPER: Adjust code flow of some functions
[PATCH 4/7 v2] RAS, debugfs: Add debugfs interface for RAS subsystem
[PATCH 5/7 v5] trace, RAS: Add eMCA trace event interface
[PATCH 6/7 v3] trace, eMCA: Add a knob to adjust where to save event log
[PATCH 7/7] RAS, extlog: Adjust init flow


This patch series add new eMCA trace event interface. To avoid conflict with
existed interface, a new unified trace event stub in the kernel is used.
New trace interface is mutually exclusive with console message via
a knob under debugfs. This knob is a reference counter. When it is opened,
the counter will be increased, whereas the counter will be decreased
if it is closed. Once this counter is greater than 0, the trace will be
used, otherwise, message will be routed to the console.

dmesg output will not conflict with trace output. Only one can work
at the same time.

When dmesg is used, you will get:

...
[  157.802455] {1}Hardware error detected on CPU0
[  157.802460] {1}It has been corrected by h/w and requires no further action
[  157.802463] {1}event severity: corrected
[  157.802465] {1} Error 0, type: corrected
[  157.802467] {1}  section_type: memory error
[  157.802469] {1}  physical_address: 0x000000042c201000
[  157.802472] {1}  node: 0 card: 0 module: 0 rank: 0 bank: 0 row: 25232 column: 1408
[  157.802474] {1}  DIMM location: Memriser1 CHANNEL A DIMM 0
[  416.121727] {2}Hardware error detected on CPU0
[  416.121732] {2}It has been corrected by h/w and requires no further action
[  416.121734] {2}event severity: corrected
[  416.121736] {2} Error 0, type: corrected
[  416.121738] {2}  section_type: memory error
[  416.121740] {2}  physical_address: 0x000000042e0fd000
[  416.121742] {2}  node: 0 card: 0 module: 0 rank: 0 bank: 0 row: 27279 column: 1480
[  416.121744] {2}  DIMM location: Memriser1 CHANNEL A DIMM 0
...

When trace is used, you will get:

...
# tracer: nop
# 
#  entries-in-buffer/entries-written: 2/2   #P:60
# 
#                               _-----=> irqs-off
#                              / _----=> need-resched
#                             | / _---=> hardirq/softirq
#                             || / _--=> preempt-depth
#                             ||| /     delay
#            TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
#               | |       |   ||||       |         |
#           <idle>-0     [000] dNh3   281.772573: extlog_mem_event: 1 corrected error: unknown DIMM location: Memriser1 CHANNEL A DIMM 0 physical addr: 0x0000000074516000 node: 0 card: 0 module: 0 rank: 0 bank: 0 row: 7329 column: 656 FRU: 00000000-0000-0000-0000-000000000000
            <idle>-0     [000] d.h3   364.449573: extlog_mem_event: 2 corrected errors: unknown DIMM location: Memriser1 CHANNEL A DIMM 0 physical addr: 0x0000000424b0b000 node: 0 card: 0 module: 0 rank: 0 bank: 0 row: 26320 column: 1176 FRU: 00000000-0000-0000-0000-000000000000

v3 -> v2: adjust RAS subsystem format & bunch of minor adjustments.
v2 -> v1: merge the comments from Tony Luck & Borislav Petkov.

