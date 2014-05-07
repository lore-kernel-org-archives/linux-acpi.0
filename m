From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/3] acpi-blacklist: Add dmi_enable_osi_linux quirk for Asus EEE PC 1015PX
Date: Thu, 08 May 2014 01:45:47 +0200
Message-ID: <2854930.hLe5IKWG6o@vostro.rjw.lan>
References: <1399282690-5381-1-git-send-email-hdegoede@redhat.com> <1399282690-5381-2-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1399282690-5381-2-git-send-email-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Aaron Lu <aaron.lu@intel.com>, edm <fuffi.il.fuffo@gmail.com>, Balint Szigeti <balint.szgt@gmail.com>, AnAkkk <anakin.cs@gmail.com>, lou.cardone@gmail.com, linux-acpi@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Monday, May 05, 2014 11:38:09 AM Hans de Goede wrote:
> Without this this EEE PC exports a non working WMI interface, with this it
> exports a working "good old" eeepc_laptop interface, fixing brightness control
> not working as well as rfkill being stuck in a permanent wireless blocked
> state.
> 
> This is not an ideal way to fix this, but various attempts to fix this
> otherwise have failed, see:
> https://bugzilla.redhat.com/show_bug.cgi?id=1067181
> 
> Cc: stable@vger.kernel.org
> Reported-and-tested-by: lou.cardone@gmail.com
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Queued up for 3.15 and -stable, thanks!

> ---
>  drivers/acpi/blacklist.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
> index 51b8f64..b08e65a 100644
> --- a/drivers/acpi/blacklist.c
> +++ b/drivers/acpi/blacklist.c
> @@ -299,6 +299,19 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
>  		     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T500"),
>  		},
>  	},
> +	/*
> +	 * Without this this EEEpc exports a non working WMI interface, with
> +	 * this it exports a working "good old" eeepc_laptop interface, fixing
> +	 * both brightness control, and rfkill not working.
> +	 */
> +	{
> +	.callback = dmi_enable_osi_linux,
> +	.ident = "Asus EEE PC 1015PX",
> +	.matches = {
> +		     DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK Computer INC."),
> +		     DMI_MATCH(DMI_PRODUCT_NAME, "1015PX"),
> +		},
> +	},
>  	{}
>  };
>  
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
