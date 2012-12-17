From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 0/6] ACPI: Simplify namespace scanning for devices
Date: Sun, 16 Dec 2012 23:00:04 -0800
Message-ID: <CAE9FiQXKCK=X8cay9r5YptnSiZZB=d9eC-Aa_m7QNDvVgC+0tw@mail.gmail.com>
References: <4532917.9APhB4xTvi@vostro.rjw.lan>
	<CAE9FiQUgEv0Ub8jAuuHzzOGqinbm0Nm5iiBs1ugRg5OT09h4+A@mail.gmail.com>
	<1904613.1YuyTUQtm1@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1904613.1YuyTUQtm1@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Toshi Kani <toshi.kani@hp.com>, Yijing Wang <wangyijing0307@gmail.com>, Jiang Liu <liuj97@gmail.com>, Wen Congyang <wency@cn.fujitsu.com>
List-Id: linux-acpi@vger.kernel.org

On Sun, Dec 16, 2012 at 2:31 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Sunday, December 16, 2012 09:36:49 AM Yinghai Lu wrote:
> There you go:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-scan-temp
>
>> I'd like to rebase for-pci-root-bus-hotplug patches, so what should be base?
>
rebase all pci patches (without four patches about drivers_autoprobe
and remove acpi_pci_root_start)
on top your branch.

root bus hotplug seems work well without problem.

Thanks a lot.

Yinghai
