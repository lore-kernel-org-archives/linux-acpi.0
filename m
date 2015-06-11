From: joeyli <jlee@suse.com>
Subject: Re: [PATCH 14/32] acer-wmi: Port to new backlight interface
 selection API
Date: Thu, 11 Jun 2015 11:01:48 +0800
Message-ID: <20150611030147.GC22631@linux-rxt1.site>
References: <1433941292-21530-1-git-send-email-hdegoede@redhat.com>
 <1433941292-21530-15-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:41493 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621AbbFKDCG (ORCPT
	<rfc822;groupwise-linux-acpi@vger.kernel.org:0:0>);
	Wed, 10 Jun 2015 23:02:06 -0400
Content-Disposition: inline
In-Reply-To: <1433941292-21530-15-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ben Skeggs <bskeggs@redhat.com>, Azael Avalos <coproscefalo@gmail.com>, Corentin Chary <corentin.chary@gmail.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Ike Panhc <ike.pan@canonical.com>, Anisse Astier <anisse@astier.eu>, Mattia Dongili <malattia@linux.it>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, acpi4asus-user@lists.sourceforge.net, dri-devel@lists.freedesktop.org, Aaron Lu <aaron.lu@intel.com>, linux-acpi@vger.kernel.org

On Wed, Jun 10, 2015 at 03:01:14PM +0200, Hans de Goede wrote:
> Port the backlight selection logic to the new backlight interface
> selection API.
> 
> This commit also removes various obsolete pr_xxx messages related to
> backlight interface selection. These are obsolete because they assume
> there is only a vendor or acpi backlight driver and no other choice.
> Also they are not necessary, if the user wants to know which backlight
> interfaces are registered a simple "ls /sys/class/backlight" suffices.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Lee, Chun-Yi <jlee@suse.com>

Thanks a lot!
Joey Lee

> ---
>  drivers/platform/x86/acer-wmi.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> index 3ac29a1..f6b280d 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -2246,14 +2246,10 @@ static int __init acer_wmi_init(void)
>  	set_quirks();
>  
>  	if (dmi_check_system(video_vendor_dmi_table))
> -		acpi_video_dmi_promote_vendor();
> -	if (acpi_video_backlight_support()) {
> +		acpi_video_set_dmi_backlight_type(acpi_backlight_vendor);
> +
> +	if (acpi_video_get_backlight_type() != acpi_backlight_vendor)
>  		interface->capability &= ~ACER_CAP_BRIGHTNESS;
> -		pr_info("Brightness must be controlled by acpi video driver\n");
> -	} else {
> -		pr_info("Disabling ACPI video driver\n");
> -		acpi_video_unregister_backlight();
> -	}
>  
>  	if (wmi_has_guid(WMID_GUID3)) {
>  		if (ec_raw_mode) {
> -- 
> 2.4.2
> 
