From: Linus Torvalds <torvalds@osdl.org>
Subject: RE: ACPI_DOCK bug: noone cares
Date: Sun, 9 Jul 2006 15:05:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607091456020.5623@g5.osdl.org>
References: <CFF307C98FEABE47A452B27C06B85BB6ECF9CF@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:15260 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161179AbWGIWJF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Jul 2006 18:09:05 -0400
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6ECF9CF@hdsmsx411.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: Adrian Bunk <bunk@stusta.de>, "Accardi, Kristen C" <kristen.c.accardi@intel.com>, Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, gregkh@suse.de, linux-acpi@vger.kernel.org, Miles Lane <miles.lane@gmail.com>



On Sun, 9 Jul 2006, Brown, Len wrote:
> >
> >Fair enough. Reverted.
> 
> I disagree with this decision, and would like to know what
> is necessary to reverse it.

Mistakes happen. Fair enough. They happen all the time. This time around, 
for the 2.6.18-rc1 thing, I had heard more than the usual "nobody even 
reacted", as Andrew had held up two patch-series of his because of that 
issue..

So that makes me like it even less than usual when I'm told that a problem 
with something I merged was apparently known BEFORE IT WAS MERGED.

So Adrian's report on its own wouldn't have caused a revert. 

> If you address me directly when you are asking me to do something,
> that would really help me help you.

As far as I can tell, you were cc'd on all of these things, along with 
the linux-acpi mailing list.

			Linus
