From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v2 06/20] x86, ACPI: Store override acpi tables phys addr
 in cpio files info array
Date: Thu, 4 Apr 2013 12:40:19 -0700
Message-ID: <CAE9FiQWexH=-AHNYi+PXpeCEgBz_rtZkbLaS_vTFmHgo4qv82A@mail.gmail.com>
References: <1362897887-30808-1-git-send-email-yinghai@kernel.org>
	<1362897887-30808-7-git-send-email-yinghai@kernel.org>
	<20130404182742.GU9425@htj.dyndns.org>
	<20130404183047.GV9425@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130404183047.GV9425@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Thomas Renninger <trenn@suse.de>, Tang Chen <tangchen@cn.fujitsu.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Apr 4, 2013 at 11:30 AM, Tejun Heo <tj@kernel.org> wrote:
> Also the comment contradicts with what you wrote in the next patch.
>
>   Boot loader could load initrd above max_low_pfn.

It does not contradict:
this patch: bootloader would not load initrd above 4G for 32bit kernel

max_low_pfn is below 4G.

Thanks

Yinghai
