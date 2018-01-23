From: gengdongjiu <gengdongjiu@huawei.com>
Subject: Re: [RFC 0/7] APEI: Move arm64 NMI notifications to use estatus cache
Date: Tue, 23 Jan 2018 16:51:53 +0800
Message-ID: <ecabb4af-ec52-e639-38cb-53d9990270d7@huawei.com>
References: <20180122192942.30487-1-james.morse@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga06-in.huawei.com ([45.249.212.32]:51541 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751086AbeAWIw7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 Jan 2018 03:52:59 -0500
In-Reply-To: <20180122192942.30487-1-james.morse@arm.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: James Morse <james.morse@arm.com>, "Zhengqiang (turing)" <zhengqiang10@huawei.com>, "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>
Cc: linux-acpi@vger.kernel.org, huangshaoyu@huawei.com, Tyler Baicar <tbaicar@codeaurora.org>

Add more Huawei's guys to know the status and review this solution.

Hi James，
   Thanks for your work.

On 2018/1/23 3:29, James Morse wrote:
> Hi guys, kbuild-robot,
> 
> This RFC is rough, and not at all ready. This is the current status of
> my attempts to split up the ghes.c code to allow multiple notifications
> to be NMI-like. On arm64 we have NOTIFY_{SEA, SEI, SDEI} all of which
> have NMI-like behaviour.
Ok.

> 
> This series splits up APEIs in_nmi() path so that more than one
> notification can use it. To support the asyncronous notifications: SEI
> and SDEI we move all the NMI-like handlers over to the estatus-cache.
> This gives us the same APEI behaviour as x86, and means the multiple
> notification methods can interact if firmware implements more than one.
> 
> estatus.. queue? ghes.c has three things all called 'estatus'. One is
> a pool of memory that has a static size, and is grown/shrunk when new
> NMI users are allocated. The second is the cache, this holds recent
> notifications so it can suppress notifications we've already handled.
> The last is the queue, which holds data from NMI notifications (in pool
> memory) that can't be handled immediatly.
thanks for the explanation.

> 
> So far this has only been tested using SDEI.
> 
> This RFC makes a know race worse. (I aim to fix the race before dropping
> the RFC tag). Xie XiuQi reported that both the arch code and
> memory_failure() will signal an affected process, what the process gets
Yes, Now in the ARCH code we firstly call memory_failure() which may signal an affected process,
then the ARCH code also signal the affected process.

> depends on the order these run in, and how the signals get merged.
> Using the estatus-cache makes this worse. My intention is for the arch
> code's new 'apei_claim_x()' helpers to give any queue that the claimed
I checked your patch and give some comments. It looks like using apei_claim_x()' helpers
is good, which can be called both by ARCH kernel and KVM in the NMI path.

> RAS event may be stuck in a kick, depending on which irq/preemptible
> flags the notification caused to be set.>
> Your CC list is wrong! Yes, given how ropey this is I want to keep the
> noise low, it would only need posting again at rc1.
Great, hope these patches can be applied in rc1 or rc2.

> 
> 
> Comments on the overall approach welcome!
> 
> 
> Thanks,
> 
> James Morse (7):
>   ACPI / APEI: Move the estatus queue code up, and under its own ifdef
>   ACPI / APEI: Generalise the estatus queue's add/remove and notify code
>   ACPI / APEI: Switch NOTIFY_SEA to use the estatus queue
>   KVM: arm/arm64: Add kvm_ras.h to collect kvm specific RAS plumbing
>   arm64: KVM/mm: Move SEA handling behind a single 'claim' interface.
>   ACPI / APEI: Make the fixmap_idx per-ghes to allow multiple in_nmi()
>     users
>   ACPI / APEI: Split fixmap pages for arm64 NMI-like notifications
> 
>  arch/arm/include/asm/kvm_ras.h       |  14 ++
>  arch/arm/include/asm/system_misc.h   |   5 -
>  arch/arm64/include/asm/acpi.h        |   2 +
>  arch/arm64/include/asm/daifflags.h   |   1 +
>  arch/arm64/include/asm/fixmap.h      |   4 +-
>  arch/arm64/include/asm/kvm_ras.h     |  23 ++
>  arch/arm64/include/asm/system_misc.h |   2 -
>  arch/arm64/kernel/acpi.c             |  30 +++
>  arch/arm64/mm/fault.c                |  30 +--
>  drivers/acpi/apei/ghes.c             | 467 ++++++++++++++++++-----------------
>  include/acpi/ghes.h                  |   5 +
>  virt/kvm/arm/mmu.c                   |   4 +-
>  12 files changed, 327 insertions(+), 260 deletions(-)
>  create mode 100644 arch/arm/include/asm/kvm_ras.h
>  create mode 100644 arch/arm64/include/asm/kvm_ras.h
> 

