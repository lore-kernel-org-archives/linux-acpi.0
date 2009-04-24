From: Yinghai Lu <yhlu.kernel@gmail.com>
Subject: only one cpu has states listed in power
Date: Fri, 24 Apr 2009 15:26:09 -0700
Message-ID: <86802c440904241526q6ebe3c70yd624a574f3c4c9d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:33153 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753310AbZDXW0K (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Apr 2009 18:26:10 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Len Brown <lenb@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

/proc/acpi/processor/P002/power is broken in latest tree.  it works on
RHEL 5.3 stock kernel.

/proc/acpi/processor # pwd
/proc/acpi/processor
/proc/acpi/processor # find . -name "power" | xargs cat
active state:            C0
max_cstate:              C8
bus master activity:     00000000
maximum allowed latency: 2000000000 usec
states:
active state:            C0
max_cstate:              C8
bus master activity:     00000000
maximum allowed latency: 2000000000 usec
states:
active state:            C0
max_cstate:              C8
bus master activity:     00000000
maximum allowed latency: 2000000000 usec
states:
active state:            C0
max_cstate:              C8
bus master activity:     00000000
maximum allowed latency: 2000000000 usec
states:
active state:            C0
max_cstate:              C8
bus master activity:     00000000
maximum allowed latency: 2000000000 usec
states:
active state:            C0
max_cstate:              C8
bus master activity:     00000000
maximum allowed latency: 2000000000 usec
states:
active state:            C0
max_cstate:              C8
bus master activity:     00000000
maximum allowed latency: 2000000000 usec
states:
active state:            C0
max_cstate:              C8
bus master activity:     00000000
maximum allowed latency: 2000000000 usec
states:
active state:            C0
max_cstate:              C8
bus master activity:     00000000
maximum allowed latency: 2000000000 usec
states:
active state:            C0
max_cstate:              C8
bus master activity:     00000000
maximum allowed latency: 2000000000 usec
states:
active state:            C0
max_cstate:              C8
bus master activity:     00000000
maximum allowed latency: 2000000000 usec
states:
active state:            C0
max_cstate:              C8
bus master activity:     00000000
maximum allowed latency: 2000000000 usec
states:
active state:            C0
max_cstate:              C8
bus master activity:     00000000
maximum allowed latency: 2000000000 usec
states:
active state:            C0
max_cstate:              C8
bus master activity:     00000000
maximum allowed latency: 2000000000 usec
states:
active state:            C0
max_cstate:              C8
bus master activity:     00000000
maximum allowed latency: 2000000000 usec
states:
active state:            C0
max_cstate:              C8
bus master activity:     00000000
maximum allowed latency: 2000000000 usec
states:
    C1:                  type[C1] promotion[--] demotion[--]
latency[000] usage[00000000] duration[00000000000000000000]
