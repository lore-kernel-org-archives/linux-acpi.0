From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] ACPI / video: Add HP EliteBook Revolve 810 to the blacklist
Date: Fri, 07 Feb 2014 09:29:58 +0800
Message-ID: <52F43716.7020008@intel.com>
References: <1391425156-27821-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:40405 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751051AbaBGB3p (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 6 Feb 2014 20:29:45 -0500
In-Reply-To: <1391425156-27821-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org

On 02/03/2014 06:59 PM, Mika Westerberg wrote:
> On HP EliteBook Revolve 810 the ACPI backlight device doesn't work as
> expected. For example when resuming from system sleep, it seems to lose
> backlight settings.
> 
> Forcing Intel driver fixes the problem so add this machine the ACPI
> video detect blacklist.

For reference's purpose, can you please file a bug to kernel bugzilla
under the ACPI/Power-Video category and attach the acpidump and dmesg
there? Thanks.

-Aaron

> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/acpi/video_detect.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index f0447d3daf2c..a697b77b8865 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -170,6 +170,14 @@ static struct dmi_system_id video_detect_dmi_table[] = {
>  	},
>  	{
>  	.callback = video_detect_force_vendor,
> +	.ident = "HP EliteBook Revolve 810",
> +	.matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "HP EliteBook Revolve 810 G1"),
> +		},
> +	},
> +	{
> +	.callback = video_detect_force_vendor,
>  	.ident = "Lenovo Yoga 13",
>  	.matches = {
>  		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> 

