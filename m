From: Mauro Carvalho Chehab <m.chehab@samsung.com>
Subject: Re: [PATCH 8/8] ACPI / trace: Add trace interface for eMCA driver
Date: Wed, 16 Oct 2013 08:55:58 -0300
Message-ID: <20131016085558.19fe143a@samsung.com>
References: <1381473166-29303-1-git-send-email-gong.chen@linux.intel.com>
 <1381473166-29303-9-git-send-email-gong.chen@linux.intel.com>
 <20131015165435.GA2777@naverao1-tp.ibm.com> <20131015170039.GF7908@pd.tnic>
 <525D7BCD.7080303@linux.vnet.ibm.com>
 <20131015214346.68718bcd.m.chehab@samsung.com>
 <20131016091640.GA13608@pd.tnic>
 <20131016073539.5a48f65e.m.chehab@samsung.com> <20131016104221.GC13608@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout3.w2.samsung.com ([211.189.100.13]:57554 "EHLO
	usmailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760182Ab3JPL4H (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Oct 2013 07:56:07 -0400
In-reply-to: <20131016104221.GC13608@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, "Chen, Gong" <gong.chen@linux.intel.com>, tony.luck@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Aristeu Rozanski Filho <arozansk@redhat.com>, Steven Rostedt <srostedt@redhat.com>

Em Wed, 16 Oct 2013 12:42:21 +0200
Borislav Petkov <bp@alien8.de> escreveu:

> On Wed, Oct 16, 2013 at 07:35:39AM -0300, Mauro Carvalho Chehab wrote:
> > Well, try to write some code on userspace to discover what's the error.
> > 
> > An error threshold mechanism on userspace will only work if userspace 
> > knows that the error belongs to the same DIMM.
> 
> Just read the first mail again:
> 
>           <idle>-0     [000] d.h. 56068.488759: extlog_mem_event: 3 corrected errors:unknown on Memriser1 CHANNEL A DIMM 0(FRU: 00000000-0000
> -0000-0000-000000000000  physical addr: 0x0000000851fe0000 node: 0 card: 0 module: 0 rank: 0 bank: 0 row: 28927 column: 1296)

On that log, "physical addr: 0x0000000851fe0000 node: 0 card: 0 module: 0 rank: 0 bank: 0 row: 28927 column: 1296"
is a string, instead of an hierarchical position, like what it is provided
on EDAC.

Worse than that, not all data may be available, as CPER allows to
ommit some data.

Also, I suspect that, if an error happens to affect more than one DIMM
(e. g. part of the location is not available for a given error),
that the DIMM label will also not be properly shown.

Also, writing the userspace counterpart that would work properly is
extremely hard, if the information about the memory layout is not known
in advance. So, in practice, if the above memory error is provided, all
userspace will likely be able to do is to store it and require someone
to manually identify what's happening.

On the other hand, if node, channel and dimm number information is
properly filled (like it happens on EDAC), usersapce can rely on those
data, in order to apply per dimm, per channel and per node thresholds.

It may even use the physical address to identify if the problem is only on
a certain region of a physical DIMM and poison that region, while it is
not possible to replace the damaged component.

Regards,
Mauro
