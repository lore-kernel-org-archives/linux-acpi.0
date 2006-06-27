From: castet.matthieu@free.fr
Subject: Re: [patch 11/18] pnpacpi: reject ACPI_PRODUCER resources
Date: Tue, 27 Jun 2006 14:02:26 +0200
Message-ID: <1151409746.44a11e52e7002@imp8-g19.free.fr>
References: <CFF307C98FEABE47A452B27C06B85BB6D8C7C7@hdsmsx411.amr.corp.intel.com>  <20060627000324.b9457fb4.akpm@osdl.org>  <20060627073704.GD3438@neo.rr.com> <1151393390.21189.59.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp4-g19.free.fr ([212.27.42.30]:32489 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S932285AbWF0LtP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 Jun 2006 07:49:15 -0400
In-Reply-To: <1151393390.21189.59.camel@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: Adam Belay <ambx1@neo.rr.com>, Andrew Morton <akpm@osdl.org>, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, bjorn.helgaas@hp.com, uwe.bugla@gmx.de

Selon Shaohua Li <shaohua.li@intel.com>:

>
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=c4bb6f5ad968540d7f9619565bacd18d7419b85f
> Thanks and sorry I didn't find the issue before. We'd better blacklist
> root bridge. I saw at lest one BIOS (IA64 box) didn't assign correct
> producer/consumer flag to root bridge resources. Blacklist it is much
> safer.

Is only PNP0A03 is producer type in __all__ ACPI possible devices ?
If not we will have the same problem with others devices...

I don't think blacklist is the solution : pnpacpi should be able to handle all
ressources types : we should complete the implementation instead of blacklist
devices our implementation doesn't support.

If there are broken ACPI bios, there should be firmware update, a patched dsdt
or a quirk, but no "quirk and no generic solution".

To be honest I am bored about this acpi stuff : there are no reply when you ask
questions or propose things, it takes months to have a patch, there are lot's
of broken ACPI bios, ...

For example http://bugzilla.kernel.org/show_bug.cgi?id=3358 I submited 1,5 years
ago is still present in the kernel...


Matthieu CASTET

--------

"The fact that ACPI was designed by a group of monkeys high on LSD, and is some
of the worst designs in the industry obviously makes running it at _any_ point
pretty damn ugly. " (July 31, 2005) Linus Torvalds
