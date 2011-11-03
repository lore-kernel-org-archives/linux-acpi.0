From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 0/2] ACPI: Re-factor and remove ./drivers/acpi/atomicio.[ch]
Date: Thu, 3 Nov 2011 17:31:17 +0100
Message-ID: <201111031731.17547.trenn@suse.de>
References: <20110929215907.21126.24480.stgit@amt.stowe>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:40223 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933827Ab1KCQbT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 Nov 2011 12:31:19 -0400
In-Reply-To: <20110929215907.21126.24480.stgit@amt.stowe>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Myron Stowe <myron.stowe@redhat.com>, ying.huang@intel.com
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, rjw@sisk.pl, bhelgaas@google.com

On Thursday, September 29, 2011 11:59:08 PM Myron Stowe wrote:
> Late last year I submitted a patch series that re-factored some existing
> work that Huang Ying introduced adding support for accessing ACPI
> generic registers backed by Memory Mapped I/O (MMIO) while within
> interrupt context:
>   Huang Ying's commit 15651291a2f8c11e7e6a42d8bfde7a213ff13262,
>   My series: http://marc.info/?l=linux-acpi&m=128769263327206&w=2.

Ying: What is your opinion about this patchset?

One major change seem to be to use a mutex instead of a spinlock
which looks like a fix as the pre-mapping should never happen in
irq context.

I expect the rest is more or less the same, but double checking
by someone who is more involved in these code paths would be
great.

Thanks,

     Thomas
