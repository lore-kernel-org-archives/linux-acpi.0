From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [PATCH 1/4] ACPICA: take ACPI_MTX_INTERPRETER in acpi_unload_table_id
Date: Fri, 30 Jan 2015 01:03:48 +0100
Message-ID: <2246788.mX5nmqqL2I@vostro.rjw.lan>
References: <1418746353-3481-1-git-send-email-octavian.purdila@intel.com> <1418746353-3481-2-git-send-email-octavian.purdila@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1418746353-3481-2-git-send-email-octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, heikki.krogerus-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday, December 16, 2014 06:12:30 PM Octavian Purdila wrote:
> acpi_tb_delete_namespace_by_owner expects ACPI_MTX_INTERPRETER to be
> taken. This fixes the following issue:
> 
> ACPI Error: Mutex [0x0] is not acquired, cannot release (20141107/utmutex-322)
> Call Trace:
>   [<ffffffff81b0bd28>] dump_stack+0x4f/0x7b
>   [<ffffffff81546bfc>] acpi_ut_release_mutex+0x47/0x67
>   [<ffffffff81542cf1>] acpi_tb_delete_namespace_by_owner+0x57/0x8d
>   [<ffffffff81543ef1>] acpi_unload_table_id+0x3a/0x5e
> 
> Signed-off-by: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

I've queued up this one for 3.20.

> ---
>  drivers/acpi/acpica/tbxface.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
> index 6482b0d..9520ae1 100644
> --- a/drivers/acpi/acpica/tbxface.c
> +++ b/drivers/acpi/acpica/tbxface.c
> @@ -281,6 +281,11 @@ acpi_status acpi_unload_table_id(acpi_owner_id id)
>  
>  	ACPI_FUNCTION_TRACE(acpi_unload_table_id);
>  
> +	status = acpi_ut_acquire_mutex(ACPI_MTX_INTERPRETER);
> +	if (ACPI_FAILURE(status)) {
> +		return_ACPI_STATUS(status);
> +	}
> +
>  	/* Find table in the global table list */
>  	for (i = 0; i < acpi_gbl_root_table_list.current_table_count; ++i) {
>  		if (id != acpi_gbl_root_table_list.tables[i].owner_id) {
> @@ -297,6 +302,8 @@ acpi_status acpi_unload_table_id(acpi_owner_id id)
>  		acpi_tb_set_table_loaded_flag(i, FALSE);
>  		break;
>  	}
> +
> +	(void)acpi_ut_release_mutex(ACPI_MTX_INTERPRETER);
>  	return_ACPI_STATUS(status);
>  }
>  
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
