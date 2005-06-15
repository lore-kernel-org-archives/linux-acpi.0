From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 02/04] PCI: use the MCFG table to properly access pci devices (i386)
Date: Wed, 15 Jun 2005 11:48:33 +0200
Message-ID: <20050615094833.GB11898@wotan.suse.de>
References: <20050615052916.GA23394@kroah.com> <20050615053031.GB23394@kroah.com> <20050615053120.GC23394@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261363AbVFOJsg@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050615053120.GC23394@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: len.brown@intel.com, ak@suse.de, acpi-devel@lists.sourceforge.net, linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Jun 14, 2005 at 10:31:20PM -0700, Greg KH wrote:
> Now that we have access to the whole MCFG table, let's properly use it
> for all pci device accesses (as that's what it is there for, some boxes
> don't put all the busses into one entry.)
> 
> If, for some reason, the table is incorrect, we fallback to the "old
> style" of mmconfig accesses, namely, we just assume the first entry in
> the table is the one for us, and blindly use it.

I think it would be better to set different bus->ops at probe
time, not walk the table at runtime.

-Andi
