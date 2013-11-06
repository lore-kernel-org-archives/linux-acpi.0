From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH 2/2] ACPI / video: Quirk initial backlight level 0
Date: Wed, 06 Nov 2013 09:18:16 +0800
Message-ID: <527998D8.2030809@intel.com>
References: <52799553.7020406@intel.com> <5279963E.8030109@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:13369 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755582Ab3KFBRd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 5 Nov 2013 20:17:33 -0500
In-Reply-To: <5279963E.8030109@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Kirill Tkhai <tkhai@yandex.ru>

On 11/06/2013 09:07 AM, Aaron Lu wrote:
> Some firmware doesn't initialize initial backlight level to a proper
> value and _BQC will return 0 on first time evaluation. We used to be
> able to detect such incorrect value with our code logic, as value 0
> normally isn't a valid value in _BCL. But with the introduction of Win8,
> firmware begins to fill _BCL with values from 0 to 100, now 0 becomes
> a valid value but that value will make user's screen black. This patch
> test initial _BQC for value 0, if such a value is returned, do not use
> it.
> 
> Reference: https://bugzilla.kernel.org/show_bug.cgi?id=64031
> Reference: https://bugzilla.kernel.org/show_bug.cgi?id=61231
> Reference: https://bugzilla.kernel.org/show_bug.cgi?id=63111
> Reported-by: Qingshuai Tian <qingshuai.tian@intel.com>
> Tested-by: Aaron Lu <aaron.lu@intel.com> on "Idealpad u330p"
> Reported-and-tested-by: <erno@iki.fi> on "Acer Aspire V5-573G"
> Reported-and-tested-by: Kirill Tkhai <tkhai@yandex.ru> on "HP 250 G1"

With this patch applied, we do not need commit e37f14a5fb85
"ACPI / video: Ignore BIOS initial backlight value for HP 250 G1"
any more.

So I made a revert patch on top of the two.

From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH] Revert "ACPI / video: Ignore BIOS initial backlight value for
 HP 250 G1"

This reverts commit e37f14a5fb85522f3bbf88ece6134c4e610ed598.

It turned out other systems also share the same problem with bug 63111
so I made a patch to catch initial brightness level 0 problem. With that
patch applied, we do not need to place HP 250 G1 in DMI table.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 drivers/acpi/video.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index a049fa9360d0..18dbdff4656e 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -504,14 +504,6 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion m4 Notebook PC"),
 		},
 	},
-	{
-	 .callback = video_ignore_initial_backlight,
-	 .ident = "HP 250 G1",
-	 .matches = {
-		DMI_MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),
-		DMI_MATCH(DMI_PRODUCT_NAME, "HP 250 G1 Notebook PC"),
-		},
-	},
 	{}
 };
 
-- 
1.8.4.39.ga0d3f10


> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> Cc: stable <stable@vger.kernel.org>
> ---
>  drivers/acpi/video.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index bf521b36c2f9..a049fa9360d0 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -858,7 +858,7 @@ acpi_video_init_brightness(struct acpi_video_device *device)
>  		for (i = 2; i < br->count; i++)
>  			if (level == br->levels[i])
>  				break;
> -		if (i == br->count)
> +		if (i == br->count || !level)
>  			level = max_level;
>  	}
>  
> 

