From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC] - Mapping ACPI tables as CACHED
Date: Fri, 23 Jul 2010 09:23:01 +0200
Message-ID: <20100723072301.GC23461@elte.hu>
References: <20100722152220.GA18290@sgi.com>
 <1279849573.13929.28.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:54995 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752065Ab0GWHXu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 23 Jul 2010 03:23:50 -0400
Content-Disposition: inline
In-Reply-To: <1279849573.13929.28.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ykzhao <yakui.zhao@intel.com>
Cc: Jack Steiner <steiner@sgi.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>


* ykzhao <yakui.zhao@intel.com> wrote:

> From the above description maybe the E820_ACPI region can be mapped as 
> cached. But this still depends on the BIOS. If the some shared data resides 
> in the E820_ACPI region on some BIOS, maybe we can't map the E820_ACPI 
> region as cached again.

I dont think we can do this safely unless some other OS (Windows) does it as 
well. (the reason is that if some BIOS messes this up then it will cause nasty 
bugs/problems only on Linux.)

But the benefits of caching are very clear and well measured by Jack, so we 
want the feature. What we can do is to add an exception for 'known good' hw 
vendors - i.e. something quite close to Jack's RFC patch, but implemented a 
bit more cleanly:

Exposing x86_platform and e820 details to generic ACPI code isnt particularly 
clean - there should be an ACPI accessor function for that or so: a new 
acpi_table_can_be_cached(table) function or so.

In fact since __acpi_map_table(addr,size) is defined by architectures already, 
this could be done purely within x86 code.

Thanks,

	Ingo
