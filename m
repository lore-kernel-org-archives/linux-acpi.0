From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 02/04] PCI: use the MCFG table to properly access pci devices (i386)
Date: Wed, 15 Jun 2005 13:21:58 -0700
Message-ID: <20050615202158.GC31022@kroah.com>
References: <20050615052916.GA23394@kroah.com> <20050615053031.GB23394@kroah.com> <20050615053120.GC23394@kroah.com> <20050615094833.GB11898@wotan.suse.de> <20050615175447.GA29138@suse.de> <20050615182346.GQ11898@wotan.suse.de> <20050615183547.GA29587@suse.de> <20050615190338.GT11898@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261204AbVFOUWR@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050615190338.GT11898@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Greg KH <gregkh@suse.de>, len.brown@intel.com, acpi-devel@lists.sourceforge.net, linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Jun 15, 2005 at 09:03:38PM +0200, Andi Kleen wrote:
> > > For those you would have bus->ops pointing to the old port code,
> > > for the others to the mmconfig code.
> > 
> > Well, for that, I'll have to set the bus ops when they are discovered.
> > So the same callback I mentioned can be used for that (due to the need
> > to check the ranges in the MCFG table).  I'll work on that too.
> > 
> > Does the K8 box just not have MCFG entries for the northbridge busses?
> 
> I believe so. 

Ok, that give us a fighting chance to get this to work...

thanks,

greg k-h
