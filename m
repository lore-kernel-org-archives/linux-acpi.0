From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH/RFC] ACPICA: disable ACPI 2.0 _GTS/_BFS support
Date: Tue, 30 Dec 2008 19:16:56 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812301905430.17126@localhost.localdomain>
References: <alpine.LFD.2.00.0812190421140.1988@localhost.localdomain>
 <200812190939.05160.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:39415 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859AbYLaARK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Dec 2008 19:17:10 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KCP00JKMSS9NKE6@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 30 Dec 2008 18:17:00 -0600 (CST)
In-reply-to: <200812190939.05160.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org

On Fri, 19 Dec 2008, Bjorn Helgaas wrote:

> On Friday 19 December 2008 02:23:49 am Len Brown wrote:
> > ACPI 2.0 defined two new methods in the suspend/resume sequence,
> > _GTS (Going to Sleep) and _BFS (Back from Sleep)
> > 
> > They are optional methods, but if the BIOS supplies them,
> > the OS is supposed to evaluate them immediately before
> > writing the register to sleep, and immediately after waking up --
> > a time when interrupts are disabled.
> > 
> > ...
> > Now, several years after ACPI 2.0 was released,
> > we have yet to observe a single implementation of
> > _GTS/_BFS in the field -- suggesting that they will
> > never actually be deployed.
> 
> There are actually some HP ia64 systems that have _GTS.  All
> the rx7600-, rx8600-, and Superdome-class systems I looked at
> have it.  But in each case, the method is empty, so I don't
> know why they even bothered to implement it.

I've seen "place holders" in AML many times.
_SCP is another popular one that is almost never implemented,
but sometimes exists and does nothing -- which is
quite misleading...

> > So lets keep Linux simple by removing this
> > theoretical support for _GTS/_BFS, the only
> > AML methods that mandated being evaluated
> > with interrupts disabled.
> 
> Do you want to print a note that _GTS/_BFS exists, but
> we're ignoring it?  If some platform comes along that
> uses them, a dmesg note might help debug problems.

Good idea.

Probably the smart thing to do would be to print a
message if they exist and are non-empty.
Otherwise we'd have to DMI those HP boxes with
empty methods.

-- Len Brown, Intel Open Source Technology Center


