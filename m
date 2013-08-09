From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: Re: [PATCH part4 2/4] x86, acpica, acpi: Try to find if SRAT is overrided
 earlier.
Date: Fri, 09 Aug 2013 17:41:14 +0800
Message-ID: <5204B93A.6030409@cn.fujitsu.com>
References: <1375954883-30225-1-git-send-email-tangchen@cn.fujitsu.com> <1375954883-30225-3-git-send-email-tangchen@cn.fujitsu.com> <CAE9FiQXUS9+heHagD45WAyO22NiGDMo3j2JumzvscypVhnjn9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:26098 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S965376Ab3HIJmn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 Aug 2013 05:42:43 -0400
In-Reply-To: <CAE9FiQXUS9+heHagD45WAyO22NiGDMo3j2JumzvscypVhnjn9A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>, Thomas Renninger <trenn@suse.de>, Jiang Liu <jiang.liu@huawei.com>, Zhang Yanfei <zhangyanfei@cn.fujitsu.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On 08/09/2013 12:29 AM, Yinghai Lu wrote:
......
>
> Please check if you can reuse first half of my patchset, so find and copy
> override table earlier. the copied acpi tables could be near kernel code range.
>

I don't think we need to do the finding step at that early time, in
head64.c stage.

Before pagetables are setup, we can use early_ioremap() to map the
memory we want to access. We don't need to use phys addr. We can do
it in setup_arch(), which has nothing to do with 32bit or 64bit.

> Move finding in head64.c stage could help xen/dom0 a bit.
> as Konrad is working on patchset with acpi override in xen hypervisor.
> We can avoid override acpi table two times. Esp xen like to change
> DMAR to XMAR.

Would you please give some more info about this, and explain why finding
override tables in head64.c stage is helpful for xen ?

Thanks.

