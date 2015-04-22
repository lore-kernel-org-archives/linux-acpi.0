From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] sbshc: fix NULL pointer dereference on rmmod
Date: Wed, 22 Apr 2015 04:16:47 +0200
Message-ID: <1791591.shHM2hgzQQ@vostro.rjw.lan>
References: <20150417111124.GA3554@localhost> <20150421232536.GA4769@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62235 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753933AbbDVBwG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Apr 2015 21:52:06 -0400
In-Reply-To: <20150421232536.GA4769@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chris Bainbridge <chris.bainbridge@gmail.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

On Wednesday, April 22, 2015 12:25:36 AM Chris Bainbridge wrote:
> Use list_for_each_entry_safe for iterating because handler may be freed
> in the loop.
> 
> BUG: unable to handle kernel NULL pointer dereference at 000000000000002c
> IP: [<ffffffff814d69c8>] acpi_ec_put_query_handler+0x7/0x1a
> Call Trace:
>  acpi_ec_remove_query_handler+0x87/0x97
>  acpi_smbus_hc_remove+0x2a/0x44 [sbshc]
>  acpi_device_remove+0x7b/0x9a
>  __device_release_driver+0x7e/0x110
>  driver_detach+0xb0/0xc0
>  bus_remove_driver+0x54/0xe0
>  driver_unregister+0x2b/0x60
>  acpi_bus_unregister_driver+0x10/0x12
>  acpi_smb_hc_driver_exit+0x10/0x12 [sbshc]
>  SyS_delete_module+0x1b8/0x210
>  system_call_fastpath+0x12/0x6a
> 
> Signed-off-by: Chris Bainbridge <chris.bainbridge@gmail.com>

Applied (with a modified subject), thanks!

> ---
>  drivers/acpi/ec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 220d640..5e8fed4 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -861,7 +861,7 @@ void acpi_ec_remove_query_handler(struct acpi_ec *ec, u8 query_bit)
>  		}
>  	}
>  	mutex_unlock(&ec->mutex);
> -	list_for_each_entry(handler, &free_list, node)
> +	list_for_each_entry_safe(handler, tmp, &free_list, node)
>  		acpi_ec_put_query_handler(handler);
>  }
>  EXPORT_SYMBOL_GPL(acpi_ec_remove_query_handler);
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
