From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH 2/5] dell-wmi: Use
 acpi_video_handles_brightness_key_presses()
Date: Tue, 22 Dec 2015 11:53:19 -0800
Message-ID: <20151222195319.GN7244@malice.jf.intel.com>
References: <1450807792-4980-1-git-send-email-hdegoede@redhat.com>
 <1450807792-4980-3-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1450807792-4980-3-git-send-email-hdegoede@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Corentin Chary <corentin.chary@gmail.com>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, ibm-acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

On Tue, Dec 22, 2015 at 07:09:49PM +0100, Hans de Goede wrote:

+ Pali

> Use the new acpi_video_handles_brightness_key_presses function to check
> if we should report brightness key-presses.
> 
> This makes the code both easier to read and makes it properly report
> key-presses when acpi-video is not reporting them for reasons other
> then the backlight type being vendor.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/platform/x86/dell-wmi.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
> index f2d77fe..cb8a9c2 100644
> --- a/drivers/platform/x86/dell-wmi.c
> +++ b/drivers/platform/x86/dell-wmi.c
> @@ -43,8 +43,6 @@ MODULE_LICENSE("GPL");
>  
>  #define DELL_EVENT_GUID "9DBB5994-A997-11DA-B012-B622A1EF5492"
>  
> -static int acpi_video;
> -
>  MODULE_ALIAS("wmi:"DELL_EVENT_GUID);
>  
>  /*
> @@ -159,7 +157,8 @@ static void dell_wmi_process_key(int reported_key)
>  
>  	/* Don't report brightness notifications that will also come via ACPI */
>  	if ((key->keycode == KEY_BRIGHTNESSUP ||
> -	     key->keycode == KEY_BRIGHTNESSDOWN) && acpi_video)
> +	     key->keycode == KEY_BRIGHTNESSDOWN) &&
> +	    acpi_video_handles_brightness_key_presses())
>  		return;
>  
>  	sparse_keymap_report_entry(dell_wmi_input_dev, key, 1, true);
> @@ -398,7 +397,6 @@ static int __init dell_wmi_init(void)
>  	}
>  
>  	dmi_walk(find_hk_type, NULL);
> -	acpi_video = acpi_video_get_backlight_type() != acpi_backlight_vendor;
>  
>  	err = dell_wmi_input_setup();
>  	if (err)
> -- 
> 2.5.0
> 
> 

-- 
Darren Hart
Intel Open Source Technology Center
