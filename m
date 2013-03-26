From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RESEND PATCH 1/6] acpi: Remove the leading space of "unlock" label in acpi_memory_device_notify().
Date: Tue, 26 Mar 2013 14:17:17 +0100
Message-ID: <1843378.VZBEQ0WNNo@vostro.rjw.lan>
References: <1362558611-32255-1-git-send-email-tangchen@cn.fujitsu.com> <1362558611-32255-2-git-send-email-tangchen@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:42959 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932679Ab3CZNJy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Mar 2013 09:09:54 -0400
In-Reply-To: <1362558611-32255-2-git-send-email-tangchen@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tang Chen <tangchen@cn.fujitsu.com>
Cc: lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, ming.m.lin@intel.com, mpm@selenic.com, herbert@gondor.apana.org.au, rob@landley.net, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org

On Wednesday, March 06, 2013 04:30:06 PM Tang Chen wrote:
> There is a leading space in front of "unlock" label in acpi_memory_device_notify(). Remove it.
> 
> Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
> ---
>  drivers/acpi/acpi_memhotplug.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
> index da1f82b..8a10c23 100644
> --- a/drivers/acpi/acpi_memhotplug.c
> +++ b/drivers/acpi/acpi_memhotplug.c
> @@ -369,7 +369,7 @@ static void acpi_memory_device_notify(acpi_handle handle, u32 event, void *data)
>  			kfree(ej_event);
>  		}
>  
> - unlock:
> +unlock:
>  		acpi_scan_lock_release();
>  		if (ACPI_SUCCESS(status))
>  			return;

The leading space is actually in agreement with the kernel coding style
(and there's a reason why it's there).

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
