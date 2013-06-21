From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: [BUGFIX v2 0/4] fix bug 56531, 59501 and 59581
Date: Fri, 21 Jun 2013 19:02:35 +0600
Message-ID: <CAN_LGv1C7XPHTzXyFjJStffRE_BXxi5tNyJ4cV98RvPfbwFkGA@mail.gmail.com>
References: <1371238081-32260-1-git-send-email-jiang.liu@huawei.com>
	<1436701.V8egnZxOqz@vostro.rjw.lan>
	<CAN_LGv2kZy_8SrKae5YUwHoUM+mf1OgH2HkAEtiC+ojKCFYSeg@mail.gmail.com>
	<1620890.UBBDKT8mbZ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1620890.UBBDKT8mbZ@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jiang Liu <jiang.liu@huawei.com>, alexdeucher@gmail.com, Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yijing Wang <wangyijing@huawei.com>, linux-acpi@vger.kernel.org, Jiang Liu <liuj97@gmail.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

2013/6/21 Rafael J. Wysocki <rjw@sisk.pl>:
> The thing below looks like a radeon problem?
>
> [   52.268389] ------------[ cut here ]------------
> [   52.268395] WARNING: at drivers/gpu/drm/ttm/ttm_page_alloc_dma.c:533 ttm_dma_free_pool+0x101/0x110 [ttm]()

Yes. Let's ignore it for now, as it is a separate bug, likely a
special case of https://bugzilla.kernel.org/show_bug.cgi?id=59681

> But it looks like the removal actually succeeded.

It did.

> [   52.273103] pci_bus 0000:0b: busn_res: [bus 0b] is released
> [   52.273732] pci_bus 0000:0c: busn_res: [bus 0c] is released
> [   52.273816] pci_bus 0000:16: busn_res: [bus 16] is released
>
> Is the re-dock attempt included?  It doesn't seem to leave any trace ...

It is, and indeed it left no traces. See the followup when I attached
the result of manually rescanning the bus - you have already commented
on the deadlock there.

-- 
Alexander E. Patrakov
