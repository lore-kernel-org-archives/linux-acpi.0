From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: 2.6.9rc2-mm4 oops
Date: Fri, 1 Oct 2004 16:33:10 -0600
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200410011633.10171.bjorn.helgaas@hp.com>
References: <1096571653.11298.163.camel@cmn37.stanford.edu> <200410010904.52892.bjorn.helgaas@hp.com> <1096653158.7485.17.camel@cmn37.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S266768AbUJAWfK@vger.kernel.org>
In-Reply-To: <1096653158.7485.17.camel@cmn37.stanford.edu>
Content-Disposition: inline
To: Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, mingo@elte.hu, Len Brown <len.brown@intel.com>, acpi-devel@lists.sourceforge.net, Bernhard Rosenkraenzer <bero@arklinux.org>
List-Id: linux-acpi@vger.kernel.org

On Friday 01 October 2004 11:52 am, Fernando Pablo Lopez-Lezcano wrote:
> On Fri, 2004-10-01 at 08:04, Bjorn Helgaas wrote:
> >  Also, can you look up the bad address
> > (e.g., f8881920) in /proc/kallsyms? 
> 
> This is what I find:
> f8880f80 ? __mod_vermagic5      [xor]
> f8880fcd ? __module_depends     [xor]
> f8881000 t acpi_button_init     [button]
> f8881000 t init_module  [button]
> f8884000 t xor_pII_mmx_2        [xor]
> f8884130 t xor_pII_mmx_3        [xor]

You are remembering that /proc/kallsyms isn't sorted, right?

If you still can't match the address to anything interesting,
can you see whether it's related to any of the other modules
(i.e., see whether it happens even if you don't load any of
the other ACPI drivers, or try leaving out any other drivers
you can get along without)?  Maybe try loading an ACPI driver
other than floppy, at the same point in the module load sequence,
to see if the problem is specific to floppy, or if floppy is
just an innocent bystander?

I looked at all the callers of acpi_bus_register_driver(), and
they all look fine (except the hpet one I found yesterday).  But
maybe there's something I missed, or maybe the acpi_bus_drivers
list got corrupted somehow.

If you don't load the floppy driver, is the system stable?
