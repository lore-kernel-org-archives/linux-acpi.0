From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH 0/2] ACPI: Re-factor and remove
 ./drivers/acpi/atomicio.[ch]
Date: Fri, 04 Nov 2011 09:32:38 +0800
Message-ID: <1320370358.24181.19.camel@yhuang-dev>
References: <20110929215907.21126.24480.stgit@amt.stowe>
	 <201111031731.17547.trenn@suse.de> <1320368164.24181.17.camel@yhuang-dev>
	 <201111040324.31692.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:15800 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751914Ab1KDBck (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 Nov 2011 21:32:40 -0400
In-Reply-To: <201111040324.31692.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Myron Stowe <myron.stowe@redhat.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "rjw@sisk.pl" <rjw@sisk.pl>, "bhelgaas@google.com" <bhelgaas@google.com>

On Fri, 2011-11-04 at 10:24 +0800, Thomas Renninger wrote:
> On Friday 04 November 2011 01:56:04 Huang Ying wrote:
> > On Fri, 2011-11-04 at 00:31 +0800, Thomas Renninger wrote:
> > > On Thursday, September 29, 2011 11:59:08 PM Myron Stowe wrote:
> > > > Late last year I submitted a patch series that re-factored some existing
> > > > work that Huang Ying introduced adding support for accessing ACPI
> > > > generic registers backed by Memory Mapped I/O (MMIO) while within
> > > > interrupt context:
> > > >   Huang Ying's commit 15651291a2f8c11e7e6a42d8bfde7a213ff13262,
> > > >   My series: http://marc.info/?l=linux-acpi&m=128769263327206&w=2.
> > > 
> > > Ying: What is your opinion about this patchset?
> > 
> > I am OK with the patchset.
> Great, thanks.
> > We just need some testing.
> Hm, that's what release candidates (-rcX) are for.
> 
> > > One major change seem to be to use a mutex instead of a spinlock
> > > which looks like a fix as the pre-mapping should never happen in
> > > irq context.
> > 
> > Sorry, where is the mutex?
> you used a spinlock in atomicio.c:
> static DEFINE_SPINLOCK(acpi_iomaps_lock);
> in osl.c a mutex is used:
> static DEFINE_MUTEX(acpi_ioremap_lock);

Thanks.  I think mutex is OK here because it will not be used in IRQ/NMI
handler.

Best Regards,
Huang Ying


