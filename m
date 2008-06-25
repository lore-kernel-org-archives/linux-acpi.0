From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] ACPI: don't walk tables if ACPI was disabled
Date: Wed, 25 Jun 2008 09:07:40 +0200
Message-ID: <20080625070740.GA8506@elte.hu>
References: <20080620135639.GA5073@damson.getinternet.no> <alpine.LFD.1.10.0806201458500.3027@localhost.localdomain> <19f34abd0806201340t502ce471n578dd2498a5f1992@mail.gmail.com> <19f34abd0806201427h740ca3e7gc2f01c7e34616fd4@mail.gmail.com> <19f34abd0806210119o64a1c9ban78710651a01530cf@mail.gmail.com> <20080624114139.GC21890@elte.hu> <alpine.LFD.1.10.0806242240050.3014@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:57800 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752185AbYFYHIM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Jun 2008 03:08:12 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0806242240050.3014@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Vegard Nossum <vegard.nossum@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Zhao Yakui <yakui.zhao@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alexey Starikovskiy <astarikovskiy@suse.de>, Yinghai Lu <yhlu.kernel@gmail.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>


* Len Brown <lenb@kernel.org> wrote:

> > > and now I understand the purpose of the check; pnpbios does not 
> > > depend on ACPI; ACPI/pnpacpi is incompatible with pnpbios.
> > 
> > wow, rather old bug - i guess lockdep made it more visible.
> 
> No, that commit was not a bug, it was correct, and still is, for 
> pnpACPI and pnpBIOS must be mutually exclusive.
> 
> The thing that changed was the RTC specific code.

ok. Vegard's patch/workaround got my test setup going, i'll drop it if 
something better comes along. (tip/out-of-tree commits dont get 
propagated into linux-next so it will not interfere with anything)

	Ingo
