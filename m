From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2 0/9] minor improvements for ACPI dock and acpiphp drivers
Date: Wed, 26 Jun 2013 20:34:14 +0200
Message-ID: <3595823.TLPByjpQFK@vostro.rjw.lan>
References: <1372264261-17442-1-git-send-email-liuj97@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:52270 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751383Ab3FZSYp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 26 Jun 2013 14:24:45 -0400
In-Reply-To: <1372264261-17442-1-git-send-email-liuj97@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiang Liu <liuj97@gmail.com>
Cc: Jiang Liu <jiang.liu@huawei.com>, Yijing Wang <wangyijing@huawei.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday, June 27, 2013 12:30:52 AM Jiang Liu wrote:
> From: Jiang Liu <jiang.liu@huawei.com>
> 
> This is an following up patchset of "[PATCH 0/3] ACPI / dock / PCI: Fix
> problems with dock and PCI hotplug" with minor code cleanups and
> refinements. It applies to
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
> 
> Due to hardware resource limitation, I have only done compilation and
> boot tests.
> 
> Jiang Liu (9):
>   ACPI, DOCK: avoid initializing acpi_dock_notifier_list multiple times
>   ACPI, DOCK: kill redundant spin lock in dock station object
>   ACPI, DOCK: mark initialization functions with __init
>   ACPI, DOCK: simplify implementation of dock_create_acpi_device()
>   ACPI: introduce three helper functions
>   ACPI: change acpi_[bay|dock]_match() in scan.c as global functions
>   ACPI: simplify dock driver with new interfaces
>   ACPI: simpilify scan.c with new interfaces
>   ACPI: simplify acpiphp driver with new interfaces
> 
>  drivers/acpi/dock.c                | 152 ++++---------------------------
>  drivers/acpi/scan.c                | 182 ++++++++++++-------------------------
>  drivers/acpi/utils.c               |  72 +++++++++++++++
>  drivers/pci/hotplug/acpiphp_glue.c |  30 ++----
>  include/acpi/acpi_bus.h            |   8 ++
>  5 files changed, 168 insertions(+), 276 deletions(-)

I'll queue up patches [1-4/9] for 3.12, but I have comments regarding the rest.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
