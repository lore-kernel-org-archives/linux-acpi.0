From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: patch for bugs 9998 and 10724
Date: Tue, 09 Sep 2008 17:43:10 +0800
Message-ID: <1220953390.3989.99.camel@yakui_zhao.sh.intel.com>
References: <1219730254.4116.38.camel@yakui_zhao.sh.intel.com>
	 <20080904121820.GC18288@one.firstfloor.org> <48BFD5AA.3090006@suse.de>
	 <48BFD609.2050604@suse.de> <1220581596.3441.2.camel@rzhang-dt>
	 <48C129D3.5000904@suse.de> <1220842582.3441.30.camel@rzhang-dt>
	 <48C4E15F.2020701@suse.de>
	 <1220951583.3989.85.camel@yakui_zhao.sh.intel.com>
	 <48C63E0B.2030801@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:63402 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751938AbYIIJ2k (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 9 Sep 2008 05:28:40 -0400
In-Reply-To: <48C63E0B.2030801@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Zhang Rui <rui.zhang@intel.com>, Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Tue, 2008-09-09 at 13:12 +0400, Alexey Starikovskiy wrote:
> Zhao Yakui wrote:
> > Hi, Alexey
> >     You attached the updated patch on the bug 10724/9998.
> >     Can the following situation be handled by your patch?(For example:
> > bug 10724)
> >        EC GPE Interrupt storm is detected and EC GPE will be disabled
> > when doing EC transaction.
> >        If EC notification event happens while doing EC transaction(EC
> > GPE is disabled), the SCI_EVT bit of EC status register is cleared
> > automatically before we can handle it.
> SCI_EVT is cleared only as a response to query command sent to EC, there is no 
> timeout on it.
If the SCI_EVT is cleared only after issuing query the command, in
theory the poll timer should also handle it. But on the laptop of bug
10724 it seems that the poll timer can't handle such notification event.
And on the laptops of bug 11428 and 8459 the poll timer can't handle the
notification event when the system is switched from GPE mode to polling
mode.
> Transaction will take at most 2 ms (1 write/1 read or 2 writes in poll mode), 
> and at the end of the transaction there is a check of the SCI bit.
> With the un-patched EC SCI bit needs to stay for period while the QUERY_PENDING bit is set,
> which could be quite more than 2 ms, and it seems to comply with that even on most broken
> hardware.
> >        Can the EC notification event be handled by OS?
Maybe it will take very short time to do the EC transaction. Myabe in
most cases it is about 2ms. But in some worse situation it will take a
long time(For example: 100ms). If the EC notification happens in such
case, how to handle the event? (the SCI_EVT bit will be cleared before
we can detect it).

Best regards.
> What do you mean? 
> > 
> >  Thanks
> >      Yakui.
> Please strip unneeded tails from your mails.

