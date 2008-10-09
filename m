From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] ACPICA: Add hard limit to while loop
Date: Thu, 9 Oct 2008 09:49:41 -0700
Message-ID: <4911F71203A09E4D9981D27F9D830858031232DF@orsmsx503.amr.corp.intel.com>
References: <20081009103539.1238.81357.stgit@thinkpad>
 <4911F71203A09E4D9981D27F9D83085803123152@orsmsx503.amr.corp.intel.com>
 <4911F71203A09E4D9981D27F9D83085803123249@orsmsx503.amr.corp.intel.com>
 <alpine.LFD.1.10.0810091230001.3007@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:5606 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754085AbYJIQxt convert rfc822-to-8bit (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Thu, 9 Oct 2008 12:53:49 -0400
In-Reply-To: <alpine.LFD.1.10.0810091230001.3007@localhost.localdomain>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, "Linux-acpi@vger.kernel.org" <Linux-acpi@vger.kernel.org>

The mutex and event opcodes come to mind, the AML can wait forever on these (Acquire, Wait). However, the interpreter is released when these opcodes block, quite unlike a spinning while loop.

As far as infinite spin loops, I think While() is the only case. There is no GoTo AML operator, so loops cannot be artificially created.

So, I think the loop counter idea is ok. Of course, picking a maximum number might be a bit difficult. 64K loop iterations takes 4-5 seconds on my machine here (in Ring 3). That is a lot of loops for AML code, it might be ok.

Besides, we can say "nobody would ever need more than 64K loop iterations", and get ourselves in the computer hall of fame.  :-)

Bob


>-----Original Message-----
>From: Len Brown [mailto:lenb@kernel.org]
>Sent: Thursday, October 09, 2008 9:32 AM
>To: Moore, Robert
>Cc: Alexey Starikovskiy; Linux-acpi@vger.kernel.org
>Subject: RE: [PATCH] ACPICA: Add hard limit to while loop
>
>
>Are AML while loops our only exposure to getting stuck interpreting AML
>forever?
>
>Maybe there is a more general solution that would cover everything, such
>as counting opcodes or setting a watchdog timer?
>
>thanks,
>-Len

