From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 25/70] ACPICA: Update disassembler for DMAR table changes
Date: Thu, 26 Jun 2008 00:41:10 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806260040290.3279@localhost.localdomain>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
 <ee61cb033678eaf16901813eb6394dafa51e9c85.1213947350.git.len.brown@intel.com>
 <20080620115201.GB8637@srcf.ucam.org>
 <alpine.LFD.1.10.0806201438130.3027@localhost.localdomain>
 <87d4mbansc.fsf@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:38947 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492AbYFZElS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Jun 2008 00:41:18 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K310069CZOO2ZQ3@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 25 Jun 2008 23:41:13 -0500 (CDT)
In-reply-to: <87d4mbansc.fsf@basil.nowhere.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, luming.yu@intel.com



On Fri, 20 Jun 2008, Andi Kleen wrote:

> Len Brown <lenb@kernel.org> writes:
> >
> > But there is actually quite a bit in ACPICA that is not in Linux.
> > The most useful, from a debugging point of view, might be the
> > hooking the ACPICA debug code into the kernel debugger --
> > something that Luming did about 2 years ago.  However, as the
> > debugger was not part of the Linux kernel tree, the changes
> > didn't really have a good path to a customer...
> 
> kgdb supports remote function calls, so if you just make a callable
> interface and perhaps supply a standard macro file users could call
> it.

at some point we need to seriously consider "productizing"
the ACPICA hooks to kgdb.  I guess this is one for the to-do list.

-len

