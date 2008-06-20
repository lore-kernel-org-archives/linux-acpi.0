From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/2] cleanup e820_setup_gap
Date: Fri, 20 Jun 2008 17:32:20 +0200
Message-ID: <20080620153220.GD17373@elte.hu>
References: <1213916250.27983.35.camel@promb-2n-dhcp368.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:48044 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757039AbYFTPcf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Jun 2008 11:32:35 -0400
Content-Disposition: inline
In-Reply-To: <1213916250.27983.35.camel@promb-2n-dhcp368.eng.vmware.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alok Kataria <akataria@vmware.com>
Cc: "Brown, Len" <len.brown@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Yinghai Lu <yhlu.kernel@gmail.com>


* Alok Kataria <akataria@vmware.com> wrote:

> This is a preparatory patch for the next patch in series. Moves some 
> code from e820_setup_gap to a new function e820_search_gap. This 
> function will be used by the next patch in the series.
> 
> Signed-off-by: Alok N Kataria <akataria@vmware.com>
> 
> Index: linux-2.6/arch/x86/kernel/e820_64.c
> ===================================================================
> --- linux-2.6.orig/arch/x86/kernel/e820_64.c	2008-06-12 10:42:22.000000000 -0700
> +++ linux-2.6/arch/x86/kernel/e820_64.c	2008-06-13 14:05:18.000000000 -0700
> @@ -872,26 +872,20 @@

note that this code has significantly changed in x86-next (it has been 
fixed, extended, cleaned up and unified). You can find the latest 
patches in tip/master at:

  http://people.redhat.com/mingo/tip.git/README

tip/master contains the integration of all changes in this area.

We could apply and test your change in tip/x86 as well, as it seems 
standalone and independent of ACPI - so that when the acpi change shows 
up in linux-next there's a e820_search_gap() function available.

	Ingo
