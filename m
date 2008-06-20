From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 25/70] ACPICA: Update disassembler for DMAR table changes
Date: Fri, 20 Jun 2008 14:41:41 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806201438130.3027@localhost.localdomain>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
 <ee61cb033678eaf16901813eb6394dafa51e9c85.1213947350.git.len.brown@intel.com>
 <20080620115201.GB8637@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:38353 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083AbYFTSmA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 14:42:00 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K2R0048RYLKE940@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 20 Jun 2008 13:41:45 -0500 (CDT)
In-reply-to: <20080620115201.GB8637@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, luming.yu@intel.com



On Fri, 20 Jun 2008, Matthew Garrett wrote:

> On Fri, Jun 20, 2008 at 03:43:27AM -0400, Len Brown wrote:
> >  extern struct acpi_dmtable_info acpi_dm_table_info_dmar1[];
> > +extern struct acpi_dmtable_info acpi_dm_table_info_dmar2[];
> >  extern struct acpi_dmtable_info acpi_dm_table_info_ecdt[];
> 
> Maybe I'm missing something here, but we don't actually seem to have the 
> disassembler code in Linux? It would be nice if we did (as a debug 
> option) - I'd love to be able to dump a disassembled version of what's 
> actually getting executed in response to events.

this patch and others like it are obviously just to keep Linux
in sync with ACPICA to minimize the diff we must track.

But there is actually quite a bit in ACPICA that is not in Linux.
The most useful, from a debugging point of view, might be the
hooking the ACPICA debug code into the kernel debugger --
something that Luming did about 2 years ago.  However, as the
debugger was not part of the Linux kernel tree, the changes
didn't really have a good path to a customer...

-Len

