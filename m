From: joeyli <jlee@suse.com>
Subject: Re: [PATCH v2 3/3] acer-wmi: Add Aspire 5741 to
 video_vendor_dmi_table
Date: Tue, 20 May 2014 07:31:16 +0800
Message-ID: <20140519233116.GB2038@linux-rxt1.site>
References: <1400316483-6356-1-git-send-email-hdegoede@redhat.com>
 <1400316483-6356-4-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1400316483-6356-4-git-send-email-hdegoede@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Aaron Lu <aaron.lu@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Matthew Garrett <matthew.garrett@nebula.com>, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sat, May 17, 2014 at 10:48:03AM +0200, Hans de Goede wrote:
> The Aspire 5741 has broken acpi-video backlight control, so add it to the
> quirk table.
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1012674
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Lee, Chun-Yi <jlee@suse.com>

Thanks for your patch!

> ---
>  drivers/platform/x86/acer-wmi.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> index 3a74699..bbf78b2 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -570,6 +570,14 @@ static const struct dmi_system_id video_vendor_dmi_table[] = {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5750"),
>  		},
>  	},
> +	{
> +		.callback = video_set_backlight_video_vendor,
> +		.ident = "Acer Aspire 5741",
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Acer"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5741"),
> +		},
> +	},
>  	{}
>  };
>  
> -- 
> 1.9.0
> 
Joey Lee
