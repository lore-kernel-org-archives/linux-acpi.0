From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RESEND PATCH v5 0/5] Make cpuid <-> nodeid mapping persistent
Date: Thu, 3 Mar 2016 03:08:46 +0100
Message-ID: <CAJZ5v0j1WMi5qMYoUeto8EbV2XnhZQ1j7eQ3jJtoC7h5dOxxkw@mail.gmail.com>
References: <1456969327-20011-1-git-send-email-zhugh.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1456969327-20011-1-git-send-email-zhugh.fnst@cn.fujitsu.com>
Sender: owner-linux-mm@kvack.org
To: Zhu Guihua <zhugh.fnst@cn.fujitsu.com>
Cc: cl@linux.com, Tejun Heo <tj@kernel.org>, mika.j.penttila@gmail.com, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "H. Peter Anvin" <hpa@zytor.com>, yasu.isimatu@gmail.com, isimatu.yasuaki@jp.fujitsu.com, kamezawa.hiroyu@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, gongzhaogang@inspur.com, Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, chen.tang@easystack.cn, x86@kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

On Thu, Mar 3, 2016 at 2:42 AM, Zhu Guihua <zhugh.fnst@cn.fujitsu.com> wrote:
> [Problem]
>
> cpuid <-> nodeid mapping is firstly established at boot time. And workqueue caches
> the mapping in wq_numa_possible_cpumask in wq_numa_init() at boot time.
>
> When doing node online/offline, cpuid <-> nodeid mapping is established/destroyed,
> which means, cpuid <-> nodeid mapping will change if node hotplug happens. But
> workqueue does not update wq_numa_possible_cpumask.
>

Are there any changes in this version relative to the previous one?

Thanks,
Rafael

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
