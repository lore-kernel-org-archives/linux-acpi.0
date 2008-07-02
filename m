From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [patch 5/5] x86 PCI: use dev_printk when possible
Date: Tue, 1 Jul 2008 18:57:41 -0700
Message-ID: <200807011857.42384.jbarnes@virtuousgeek.org>
References: <20080613165209.507694130@ldl.fc.hp.com> <20080613165304.842091464@ldl.fc.hp.com> <20080630165737.2f9735f0.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-mail-135.bluehost.com ([67.222.39.25]:46867 "HELO
	outbound-mail-135.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758134AbYGBB6E (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Jul 2008 21:58:04 -0400
In-Reply-To: <20080630165737.2f9735f0.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, lenb@kernel.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday, June 30, 2008 4:57 pm Andrew Morton wrote:
> On Fri, 13 Jun 2008 10:52:14 -0600
>
> Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> > I converted DBG() to dev_dbg().  This DBG() is from arch/x86/pci/pci.h
> > and requires source-code modification to enable, so dev_dbg() seems
> > roughly equivalent.
> >
> > The printks in arch/x86/pci/irq.c were a little hairy, with lines
> > printed in several pieces.  I straightened it out a little, but
> > another set of eyes would be good.
> >
> > Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> >
> > ---
> >  arch/x86/pci/fixup.c |    3 +
> >  arch/x86/pci/i386.c  |   26 ++++++--------
> >  arch/x86/pci/irq.c   |   91
> > ++++++++++++++++++++++----------------------------- arch/x86/pci/numa.c 
> > |    5 +-
>
> Got a bunch of rejects in arch/x86/pci/irq.c due to pending whitespace
> fixes.  I fixed a couple of them but then I got bored, so the
> conversion in there is only partial.
>
> Please prefer to raise patches against linux-next if poss, especially
> during late -rc's.

Yeah, the x86 tree(s) move too fast for me to keep up with.  The change seems 
worthwhile though, maybe Ingo or one of the x86 team could just search & 
replace?

Jesse
