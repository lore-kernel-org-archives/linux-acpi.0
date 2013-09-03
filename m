From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH RESEND 2/3] x86, mm: Update min_pfn_mapped in add_pfn_range_mapped().
Date: Mon, 2 Sep 2013 19:48:12 -0700
Message-ID: <CAE9FiQXeiBZU9X7MprpBtyCQgW-u3u5m7XwvEujnvs5wHYdM4A@mail.gmail.com>
References: <1378117829-9095-1-git-send-email-tangchen@cn.fujitsu.com>
	<1378117829-9095-3-git-send-email-tangchen@cn.fujitsu.com>
	<CAE9FiQXtWc6ud6BpsvUa5F4KKEX7cT5Phj4wvZfEr6zeWZVpZA@mail.gmail.com>
	<52253607.9010907@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:46423 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759262Ab3ICCsN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Sep 2013 22:48:13 -0400
In-Reply-To: <52253607.9010907@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tang Chen <tangchen@cn.fujitsu.com>
Cc: Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Pekka Enberg <penberg@kernel.org>, Jacob Shin <jacob.shin@amd.com>, Thomas Gleixner <tglx@linutronix.de>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>

On Mon, Sep 2, 2013 at 6:06 PM, Tang Chen <tangchen@cn.fujitsu.com> wrote:
> Hi Yinghai,
>
> On 09/03/2013 02:41 AM, Yinghai Lu wrote:

> How about change the "for (from low to high)" in init_range_memory_mapping()
> to
> "for_rev(from high to low)" ?
> Then we can update min_pfn_mapped in add_pfn_range_mapped().
>
> And also, the outer loop is from high to low, we can change the inner loop
> to be from high
> to low too.

No. there is other reason for doing local from low to high.

kernel_physical_mapping_init() could clear some mapping near the end
of PUG/PMD entries but not the head.

>
> I think updating min_pfn_mapped in init_mem_mapping() is less readable. And
> min_pfn_mapped
> and max_pfn_mapped should be updated together.

min_pfn_mapped is early local variable to control allocation in alloc_low_pages.
put it in init_mem_mapping is more readable.

Yinghai
