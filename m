From: Daniel Walker <dwalker@mvista.com>
Subject: RE: [PATCH 1/3] acpi: add real mutex function calls
Date: Thu, 24 Jul 2008 08:44:21 -0400
Message-ID: <1216903461.29701.11.camel@localhost.localdomain>
References: <1216491411-24080-1-git-send-email-dwalker@mvista.com>
	 <1216491411-24080-2-git-send-email-dwalker@mvista.com>
	 <1216605078.4135.23.camel@yakui_zhao.sh.intel.com>
	 <1216648574.2294.9.camel@dhcp32.mvista.com>
	 <4884E177.5000809@linux.intel.com>
	 <1216669184.2294.44.camel@dhcp32.mvista.com>
	 <9D39833986E69849A2A8E74C1078B6B3B6925F@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.158]:62351 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1753696AbYGXMpD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Jul 2008 08:45:03 -0400
In-Reply-To: <9D39833986E69849A2A8E74C1078B6B3B6925F@orsmsx415.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>, "Zhao, Yakui" <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, "Brown, Len" <len.brown@intel.com>

(Added back the CC list.)

I don't think the problem is in the machine specific ACPI info .. As far
as I can tell the problem is related to how the interpreter lock is
interleaved with the AML mutexes . For example, a series of AML locks
can be A->B->C and at any point the interpreter lock can be released,
and reacquired. So you have a possible lock sequence of I->A->B->C ,
then in another path you have A->I->B->C. That creates a circular lock
scenario and with multiple threads in those different paths you could
end up with a deadlock (or a lockdep warning).

I was also reading the ACPI spec on how the ASL compiler does checking
on mutex usage similar to what lockdep is doing. I would hope there are
no lockdep warning coming from that code.

Daniel

