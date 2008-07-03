From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/2] cleanup e820_setup_gap v2
Date: Thu, 3 Jul 2008 14:52:27 +0200
Message-ID: <20080703125227.GA14082@elte.hu>
References: <1214333310.27577.26.camel@promb-2n-dhcp368.eng.vmware.com> <20080625160817.GC24967@elte.hu> <1214416962.27577.74.camel@promb-2n-dhcp368.eng.vmware.com> <86802c440806261101k78c5057id8ca0649188bd132@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:34601 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753507AbYGCMww (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 Jul 2008 08:52:52 -0400
Content-Disposition: inline
In-Reply-To: <86802c440806261101k78c5057id8ca0649188bd132@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yhlu.kernel@gmail.com>
Cc: akataria@vmware.com, "lenb@kernel.org" <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>


* Yinghai Lu <yhlu.kernel@gmail.com> wrote:

> > e820_search_gap also take a end_addr parameter to limit search from 
> > start_addr to end_addr.
> >
> > Signed-off-by: AloK N Kataria <akataria@vmware.com>
> 
> Acked-by: Yinghai Lu <yhlu.kernel@gmail.com>

applied to tip/x86/unify-setup - thanks!

	Ingo
