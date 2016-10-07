From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [tip:x86/apic] x86/acpi: Introduce persistent storage for cpuid
 <-> apicid mapping
Date: Fri, 7 Oct 2016 15:00:41 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1610071455360.19804@nanos>
References: <1472114120-3281-4-git-send-email-douly.fnst@cn.fujitsu.com> <tip-8f54969dc8d6704632b42cbb5e47730cd75cc713@git.kernel.org> <CAE9FiQVQx6FRXT-RdR7Crz4dg5LeUWHcUSy1KacjR+JgU_vGJg@mail.gmail.com> <alpine.DEB.2.20.1610041258410.7712@nanos>
 <CAE9FiQWigWvrZ8JzNDKtZ9FWARh2m0kGoF+VOZdwAdY9vnU3_w@mail.gmail.com> <4608f474-c49e-550b-90e2-c5f4c25e00f5@cn.fujitsu.com> <CAE9FiQVEvoK=TvYyhU6iiLh5FiX3pXXyy53tr2F7BEnRxGk7HA@mail.gmail.com> <e53a9807-2beb-0878-87dc-cc6f93b7c911@cn.fujitsu.com>
 <alpine.DEB.2.20.1610071448590.19804@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:44119 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756382AbcJGNDT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Oct 2016 09:03:19 -0400
In-Reply-To: <alpine.DEB.2.20.1610071448590.19804@nanos>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Yinghai Lu <yinghai@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "linux-tip-commits@vger.kernel.org" <linux-tip-commits@vger.kernel.org>, Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>, robert.moore@intel.com, linux-acpi@vger.kernel.org

On Fri, 7 Oct 2016, Thomas Gleixner wrote:
> On Fri, 7 Oct 2016, Dou Liyang wrote:
> > Is it possible that the "-1/oxffffffff" could appear in the MADT which is one
> > of the ACPI tables?
> 
> According to the SDM the x2apic id is a 32bit ID, so 0xffffffff is a
> legitimate value.

The ACPI spec says that bit 0 of the x2apic flags field tells whether the
logical processor is present or not. So the proper check for x2apic is that
flag.

The lapic structure has the same flag, but the kernel ignores the flags for
both lapic and x2apic.

I'm going to apply the minimal fix of checking for id == 0xff in
acpi_lapic_parse() for now, but this needs to be revisited and fixed
proper.

Thanks,

	tglx
