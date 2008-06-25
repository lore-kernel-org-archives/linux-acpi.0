From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/2] cleanup e820_setup_gap v2
Date: Wed, 25 Jun 2008 18:08:17 +0200
Message-ID: <20080625160817.GC24967@elte.hu>
References: <1214333310.27577.26.camel@promb-2n-dhcp368.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:52114 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754425AbYFYQIa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Jun 2008 12:08:30 -0400
Content-Disposition: inline
In-Reply-To: <1214333310.27577.26.camel@promb-2n-dhcp368.eng.vmware.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alok Kataria <akataria@vmware.com>
Cc: lenb@kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Yinghai Lu <yhlu.kernel@gmail.com>, the arch/x86 maintainers <x86@kernel.org>


* Alok Kataria <akataria@vmware.com> wrote:

> This is a preparatory patch for the next patch in series.
> Moves some code from e820_setup_gap to a new function e820_search_gap.
> This patch is a part of a bug fix where we walk the ACPI table to calculate
> a gap for PCI optional devices.
> 
> v1->v2: Patch on top of tip/master.
> 	Fixes a bug introduced in the last patch about the typeof "last".
> 	Also the new function e820_search_gap now returns if we found a gap in
> 	e820_map.

applied to tip/x86/setup-memory - thanks Alok.

should i put the other patch, "acpi based pci gap caluculation v2" into 
tip/out-of-tree for more testing of this new e820 facility?

	Ingo
