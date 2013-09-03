From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: Re: [PATCH RESEND 2/3] x86, mm: Update min_pfn_mapped in add_pfn_range_mapped().
Date: Tue, 03 Sep 2013 09:06:15 +0800
Message-ID: <52253607.9010907@cn.fujitsu.com>
References: <1378117829-9095-1-git-send-email-tangchen@cn.fujitsu.com> <1378117829-9095-3-git-send-email-tangchen@cn.fujitsu.com> <CAE9FiQXtWc6ud6BpsvUa5F4KKEX7cT5Phj4wvZfEr6zeWZVpZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:6010 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1756379Ab3ICBHd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 2 Sep 2013 21:07:33 -0400
In-Reply-To: <CAE9FiQXtWc6ud6BpsvUa5F4KKEX7cT5Phj4wvZfEr6zeWZVpZA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Pekka Enberg <penberg@kernel.org>, Jacob Shin <jacob.shin@amd.com>, Thomas Gleixner <tglx@linutronix.de>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>

Hi Yinghai,

On 09/03/2013 02:41 AM, Yinghai Lu wrote:
......
>
> Nak, you can not move that.
>
> min_pfn_mapped should not be updated before init_range_memory_mapping
> is returned. as it need to refer old min_pfn_mapped.
> and init_range_memory_mapping still init mapping from low to high locally.
> min_pfn_mapped can not be updated too early.

The current code is like this:

init_mem_mapping()
{
	while (from high to low) {
		init_range_memory_mapping()
		{
			/* Here is from low to high */
			for (from low to high) {
				init_memory_mapping()
				{
					for () {
						/* Need to refer min_pfn_mapped here */
						kernel_physical_mapping_init();
					}
					/* So if updating min_pfn_mapped here, it is too low */
					add_pfn_range_mapped();
				}
			}
		}		
	}
}

How about change the "for (from low to high)" in 
init_range_memory_mapping() to
"for_rev(from high to low)" ?
Then we can update min_pfn_mapped in add_pfn_range_mapped().

And also, the outer loop is from high to low, we can change the inner 
loop to be from high
to low too.

I think updating min_pfn_mapped in init_mem_mapping() is less readable. 
And min_pfn_mapped
and max_pfn_mapped should be updated together.

Thanks.

