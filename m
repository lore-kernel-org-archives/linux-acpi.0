From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [GIT PULL] PCI changes for v4.20
Date: Tue, 13 Nov 2018 08:47:46 -0600
Message-ID: <20181113144746.GA69034@google.com>
References: <20181023173934.GA14918@bhelgaas-glaptop.roam.corp.google.com>
 <20181113071712.GA2353@gmail.com>
 <20181113102004.GC10502@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181113102004.GC10502@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Tom Lendacky <thomas.lendacky@amd.com>, Martin =?iso-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

[+cc Martin, Rafael, Len, linux-acpi]

On Tue, Nov 13, 2018 at 11:20:04AM +0100, Borislav Petkov wrote:
> On Tue, Nov 13, 2018 at 08:17:12AM +0100, Ingo Molnar wrote:
> > 
> > * Bjorn Helgaas <helgaas@kernel.org> wrote:
> > 
> > > PCI changes:
> > > 
> > >   - Pay attention to device-specific _PXM node values (Jonathan Cameron)
> > 
> > There's a new boot regression, my AMD ThreadRipper system (MSI X399 SLI 
> > PLUS (MS-7B09)) hangs during early bootup, and I have bisected it down to 
> > this commit:
> > 
> >   bad7dcd94f39: ACPI/PCI: Pay attention to device-specific _PXM node values
> > 
> > Reverting it solves the hang.
> > 
> > Unfortunately there's no console output when it hangs, even with 
> > earlyprintk. It just hangs after the "loading initrd" line.
> > 
> > Config is an Ubuntu-ish config with PROVE_LOCKING=y and a few other debug 
> > options.
> > 
> > All my other testsystems boot fine with similar configs, so it's probably 
> > something specific to this system.

Martin reported the same thing [1] (unfortunately the archive didn't
capture Martin's original emails, I think because they were multi-part
messages with attachments).

Looks like Martin might have a similar system:

  DMI: To Be Filled By O.E.M. To Be Filled By O.E.M./X399 Taichi, BIOS P3.30 08/14/2018
  smpboot: CPU0: AMD Ryzen Threadripper 2950X 16-Core Processor (family: 0x17, model: 0x8, stepping: 0x2)

Given how painful this is to debug, I queued up a revert on my
for-linus branch until we figure out what sanity checks are needed to
make the original patch safe.

I would expect proximity information to be basically just a hint for
optimization, not a functional requirement, so it would be really
interesting to figure out why this causes such a catastrophic failure.
Maybe there's a way to improve that path as well so it would be more
robust or at least more debuggable.

Bjorn

[1] https://lore.kernel.org/linux-pci/20180912152140.3676-2-Jonathan.Cameron@huawei.com
