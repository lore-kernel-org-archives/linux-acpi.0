From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 0/5] ACPI: Rework acpi_bus_trim()
Date: Mon, 14 Jan 2013 14:21:38 -0800
Message-ID: <CAE9FiQUbQVdxDxD68ktZhFuJYs861-aFEXjTOgee1ueEous2eQ@mail.gmail.com>
References: <3885603.ydrrB7OEKf@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f51.google.com ([209.85.214.51]:38124 "EHLO
	mail-bk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756202Ab3ANWVk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Jan 2013 17:21:40 -0500
In-Reply-To: <3885603.ydrrB7OEKf@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, LKML <linux-kernel@vger.kernel.org>, Toshi Kani <toshi.kani@hp.com>, Jiang Liu <jiang.liu@huawei.com>, Taku Izumi <izumi.taku@jp.fujitsu.com>

On Mon, Jan 14, 2013 at 1:33 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> The next three patches actually rework acpi_bus_trim() in three steps:
>
> [3/5] Drop the second argument of acpi_bus_trim() (all callers pass 1 in there
>       anyway.
> [4/5] Reimplement acpi_bus_trim() using acpi_walk_namespace().
> [3/5] Make acpi_bus_trim() carry out two passes as described above.
>
> I'm aware of the fact that this will conflict with the patches that Yinghai
> posted a few days ago, but in my opinion the changes here are prerequisite for
> the Yinghai's patchset.

Sure, I will drop my change to acpi_bus_trim() and update one
reference accordingly.

Acked-by: for those 5 patches.

So you will put those patches in acpi-scan, and Bjorn will pull that
again to pci tree?

Thanks

Yinghai
