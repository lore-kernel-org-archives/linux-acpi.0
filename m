From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] Reduce ACPI resource conflict message to KERN_INFO
Date: Wed, 3 Mar 2010 08:40:27 -0700
Message-ID: <201003030840.27952.bjorn.helgaas@hp.com>
References: <1267564152-11048-1-git-send-email-chase.douglas@ubuntu.com> <201003021614.34026.bjorn.helgaas@hp.com> <1267573501.12051.25.camel@cndougla-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19]:20614 "EHLO
	g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573Ab0CCPk3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Mar 2010 10:40:29 -0500
In-Reply-To: <1267573501.12051.25.camel@cndougla-ubuntu>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chase Douglas <chase.douglas@ubuntu.com>
Cc: linux-acpi@vger.kernel.org

On Tuesday 02 March 2010 04:45:01 pm Chase Douglas wrote:
> On Tue, 2010-03-02 at 16:14 -0700, Bjorn Helgaas wrote:
> > On Tuesday 02 March 2010 02:09:12 pm Chase Douglas wrote:
> > > -			printk("%sACPI: %s resource %s [0x%llx-0x%llx]"
> > > +			printk(KERN_INFO "ACPI: %s resource %s [0x%llx-0x%llx]"
> > >  			       " conflicts with ACPI region %s"
> > >  			       " [0x%llx-0x%llx]\n",
> > > -			       acpi_enforce_resources == ENFORCE_RESOURCES_LAX
> > > -			       ? KERN_WARNING : KERN_ERR,
> > >  			       ioport ? "I/O" : "Memory", res->name,
> > >  			       (long long) res->start, (long long) res->end,
> > >  			       res_list_elem->name,
> > 
> > Since you're touching this anyway, can you convert this to use %pR?
> 
> I see the potential usage of %p, but is the 'R' a typo? I haven't found
> it in man 3 fprintf nor in a google search.

Nope, see this description of the %p<x> kernel extensions:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=lib/vsprintf.c;hb=51c24aaacaea90c8e87f1dec75a2ac7622b593f8#l915

There are several examples already in the tree, including
drivers/pci/setup-bus.c.

Bjorn
