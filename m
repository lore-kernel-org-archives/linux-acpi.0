From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH 4/5] acpi-video: Add a module option to disable the
 reporting of keypresses
Date: Tue, 22 Dec 2015 12:09:32 -0800
Message-ID: <20151222200932.GO7244@malice.jf.intel.com>
References: <1450807792-4980-1-git-send-email-hdegoede@redhat.com>
 <1450807792-4980-5-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:37917 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964800AbbLVUJg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Dec 2015 15:09:36 -0500
Content-Disposition: inline
In-Reply-To: <1450807792-4980-5-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Corentin Chary <corentin.chary@gmail.com>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, ibm-acpi-devel@lists.sourceforge.net

On Tue, Dec 22, 2015 at 07:09:51PM +0100, Hans de Goede wrote:
> Add a module option to disable the reporting of keypresses, in some buggy
> firmware implementatinon, the reported events are wrong. E.g. they lag
> reality by one event in the case triggering the writing of this patch.
> 
> In this case it is better to not forward these wrong events to userspace
> (esp.) when there is another source of the same events which is not buggy.
> 
> Note this is only intended to work around implementations which send
> events which are plain wrong. In some cases we get double events, e.g.
> from both acpi-video and the atkbd driver, in this case acpi-video is
> considered the canonical source, and the events from the other source
> should be filtered (using e.g. /lib/udev/hwdb.d/60-keyboard.hwdb).
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/acpi_video.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index 2a649f3e..2971154 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -77,6 +77,13 @@ module_param(allow_duplicates, bool, 0644);
>  static int disable_backlight_sysfs_if = -1;
>  module_param(disable_backlight_sysfs_if, int, 0444);
>  
> +#define REPORT_OUTPUT_KEY_EVENTS		0x01
> +#define REPORT_BRIGHTNESS_KEY_EVENTS		0x02

Since report_key_events is used as a bitmask, it might be preferable to use
bitops.

> +static int report_key_events = -1;
> +module_param(report_key_events, int, 0644);
> +MODULE_PARM_DESC(report_key_events,
> +	"0: none, 1: output changes, 2: brightness changes, 3: all");
> +
>  static bool device_id_scheme = false;
>  module_param(device_id_scheme, bool, 0444);
>  
> @@ -1480,7 +1487,7 @@ static void acpi_video_bus_notify(struct acpi_device *device, u32 event)
>  		/* Something vetoed the keypress. */
>  		keycode = 0;
>  
> -	if (keycode) {
> +	if (keycode && (report_key_events & REPORT_OUTPUT_KEY_EVENTS)) {
>  		input_report_key(input, keycode, 1);
>  		input_sync(input);
>  		input_report_key(input, keycode, 0);
> @@ -1544,7 +1551,7 @@ static void acpi_video_device_notify(acpi_handle handle, u32 event, void *data)
>  
>  	acpi_notifier_call_chain(device, event, 0);
>  
> -	if (keycode) {
> +	if (keycode && (report_key_events & REPORT_BRIGHTNESS_KEY_EVENTS)) {

This and the above test would be more explicit if written as:

if (keycode && (report_key_events & BIT(REPORT_BRIGHTNESS_KEY_EVENTS))

Do you have a preference Rafael?

>  		input_report_key(input, keycode, 1);
>  		input_sync(input);
>  		input_report_key(input, keycode, 0);
> @@ -2080,7 +2087,8 @@ bool acpi_video_handles_brightness_key_presses(void)
>  	have_video_busses = !list_empty(&video_bus_head);
>  	mutex_unlock(&video_list_lock);
>  
> -	return have_video_busses;
> +	return have_video_busses &&
> +	       (report_key_events & REPORT_BRIGHTNESS_KEY_EVENTS);
>  }
>  EXPORT_SYMBOL(acpi_video_handles_brightness_key_presses);
>  
> -- 
> 2.5.0
> 
> 

-- 
Darren Hart
Intel Open Source Technology Center
