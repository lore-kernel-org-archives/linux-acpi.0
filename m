From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v6 0/5] Make cpuid <-> nodeid mapping persistent
Date: Fri, 18 Mar 2016 11:34:03 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1603181133310.3978@nanos>
References: <cover.1458177577.git.zhugh.fnst@cn.fujitsu.com> <CAJZ5v0jFpQ75sKv6LS2z6h0h0YotgmtTbhjByuBgJL_JPtX=NQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:36154 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753820AbcCRKgQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Mar 2016 06:36:16 -0400
In-Reply-To: <CAJZ5v0jFpQ75sKv6LS2z6h0h0YotgmtTbhjByuBgJL_JPtX=NQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zhu Guihua <zhugh.fnst@cn.fujitsu.com>, cl@linux.com, Tejun Heo <tj@kernel.org>, mika.j.penttila@gmail.com, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "H. Peter Anvin" <hpa@zytor.com>, yasu.isimatu@gmail.com, isimatu.yasuaki@jp.fujitsu.com, kamezawa.hiroyu@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, gongzhaogang@inspur.com, Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>, chen.tang@easystack.cn, x86@kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>

On Thu, 17 Mar 2016, Rafael J. Wysocki wrote:
> >  arch/ia64/kernel/acpi.c       |   2 +-
> >  arch/x86/include/asm/mpspec.h |   1 +
> >  arch/x86/kernel/acpi/boot.c   |   8 ++-
> >  arch/x86/kernel/apic/apic.c   |  85 +++++++++++++++++++++++++----
> >  arch/x86/mm/numa.c            |  27 +++++-----
> >  drivers/acpi/acpi_processor.c |   5 +-
> >  drivers/acpi/bus.c            |   3 ++
> >  drivers/acpi/processor_core.c | 122 ++++++++++++++++++++++++++++++++++--------
> >  include/linux/acpi.h          |   6 +++
> >  9 files changed, 208 insertions(+), 51 deletions(-)
> >
> 
> OK
> 
> Since I know that there is demand for these changes, I'll queue them
> up early for 4.7 if there are no comments from the x86 maintainers
> till then.

Acked-by: Thomas Gleixner <tglx@linutronix.de>
