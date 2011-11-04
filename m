From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH 0/2] ACPI: Re-factor and remove
 ./drivers/acpi/atomicio.[ch]
Date: Fri, 04 Nov 2011 08:56:04 +0800
Message-ID: <1320368164.24181.17.camel@yhuang-dev>
References: <20110929215907.21126.24480.stgit@amt.stowe>
	 <201111031731.17547.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:12053 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750931Ab1KDA4H (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 Nov 2011 20:56:07 -0400
In-Reply-To: <201111031731.17547.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Myron Stowe <myron.stowe@redhat.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "rjw@sisk.pl" <rjw@sisk.pl>, "bhelgaas@google.com" <bhelgaas@google.com>

On Fri, 2011-11-04 at 00:31 +0800, Thomas Renninger wrote:
> On Thursday, September 29, 2011 11:59:08 PM Myron Stowe wrote:
> > Late last year I submitted a patch series that re-factored some existing
> > work that Huang Ying introduced adding support for accessing ACPI
> > generic registers backed by Memory Mapped I/O (MMIO) while within
> > interrupt context:
> >   Huang Ying's commit 15651291a2f8c11e7e6a42d8bfde7a213ff13262,
> >   My series: http://marc.info/?l=linux-acpi&m=128769263327206&w=2.
> 
> Ying: What is your opinion about this patchset?

I am OK with the patchset.  We just need some testing.

> One major change seem to be to use a mutex instead of a spinlock
> which looks like a fix as the pre-mapping should never happen in
> irq context.

Sorry, where is the mutex?

> I expect the rest is more or less the same, but double checking
> by someone who is more involved in these code paths would be
> great.

Best Regards,
Huang Ying


