From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: Re: [POC] Get acpi table to limit memory scope chosen by KASLR to
 home SB when "movable_node" is specified
Date: Thu, 3 Aug 2017 16:59:26 +0800
Message-ID: <f894c7cd-9120-f2ea-d25d-8dae3e4243b3@cn.fujitsu.com>
References: <20170803085155.GE25014@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170803085155.GE25014@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Fan <fanc.fnst@cn.fujitsu.com>, linux-kernel@vger.kernel.org, x86@kernel.org
Cc: hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, keescook@chromium.org, bhe@redhat.com, dyoung@redhat.com, arnd@arndb.de, dave.jiang@intel.com, indou.takao@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, "Rafael J., Wysocki" <rjw@rjwysocki.net>, "Zheng, Lv" <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Cc ACPI maintainers and mail list

At 08/03/2017 04:51 PM, Chao Fan wrote:
> Hi all,
>
> Here is an issue about movable_node and KASLR.
> Currently, KASLR works well with "mem=", by which we can limit the scope of
> memory chosen by KASLR. But if we use "movable_node" independently without
> "mem=", we don't know the scope of memory in the home SB, which will cause
> the memory of hotplug SB may be chosen by KASLR.
> To solve this problem, I want to do this job:
> If "movable_node" is specified, try to get the acpi table and find the scope
> of memory in home SB, then set "mem_limit".
>
> The order of getting table is:
> boot_params
>     \-systab
>         \-efi tables
>              \-rsdp
>                  \-rsdt or xsdt
>                       \-acpi root table list
>                             \-acpi srat mem affinity
>
> I am not sure if it's OK for community.
> If there are any problems, please let me know.
> Any comments will be welcome.
>
> Thanks,
> Chao Fan
>
>
>
