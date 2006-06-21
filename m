From: Rajesh Shah <rajesh.shah@intel.com>
Subject: Re: [PATCH 0/25] Decouple IRQ issues (MSI, i386, x86_64, ia64)
Date: Tue, 20 Jun 2006 17:30:18 -0700
Message-ID: <20060620173017.A10402@unix-os.sc.intel.com>
References: <m1ac87ea8s.fsf@ebiederm.dsl.xmission.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:35931 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S932230AbWFUAgF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Jun 2006 20:36:05 -0400
Content-Disposition: inline
In-Reply-To: <m1ac87ea8s.fsf@ebiederm.dsl.xmission.com>; from ebiederm@xmission.com on Tue, Jun 20, 2006 at 04:24:35PM -0600
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, discuss@x86-64.org, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@suse.de>, Natalie Protasevich <Natalie.Protasevich@UNISYS.com>, Len Brown <len.brown@intel.com>, Kimball Murray <kimball.murray@gmail.com>, Brice Goglin <brice@myri.com>, Greg Lindahl <greg.lindahl@qlogic.com>, Dave Olson <olson@unixfolk.com>, Jeff Garzik <jeff@garzik.org>, Greg KH <gregkh@suse.de>, Grant Grundler <iod00d@hp.com>, "bibo,mao" <bibo.mao@intel.com>, Rajesh Shah <rajesh.shah@intel.com>, Mark Maule <maule@sgi.com>, Jesper Juhl <jesper.juhl@gmail.com>, Shaohua Li <shaohua.li@intel.com>, Matthew Wilcox <matthew@wil.cx>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Ashok Raj <ashok.raj@intel.com>, Randy Dunlap <rdunlap@xenotime.net>

On Tue, Jun 20, 2006 at 04:24:35PM -0600, Eric W. Biederman wrote:
> 
> The primary aim of this patch is to remove maintenances problems caused
> by the irq infrastructure.  The two big issues I address are an
> artificially small cap on the number of irqs, and that MSI assumes
> vector == irq.  My primary focus is on x86_64 but I have touched
> other architectures where necessary to keep them from breaking.
> 
The MSI portions of this patchset is similar to the MSI cleanup
I was working on. I'll drop my patchkit and instead comment on
the relevant patches in this kit.

I got a couple of minor compile errors on i386 (kernel/io_apic.c).
I fixed them up by hand and the resulting kernel booted and
worked with MSI in the limited testing I've done so far.

thanks,
Rajesh
