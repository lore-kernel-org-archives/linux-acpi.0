From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI SBS: Re-enable battery manager
Date: Wed, 29 Apr 2015 02:38:33 +0200
Message-ID: <1799782.I8yvosxcYQ@vostro.rjw.lan>
References: <20150422154021.GA16720@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54825 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1031105AbbD2ANk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Apr 2015 20:13:40 -0400
In-Reply-To: <20150422154021.GA16720@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chris Bainbridge <chris.bainbridge@gmail.com>
Cc: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org

On Wednesday, April 22, 2015 04:40:21 PM Chris Bainbridge wrote:
> Commit 9faf6136 introduced a regression disabling the SBS battery
> manager. The battery manager should be marked as present when
> acpi_manager_get_info returns 0.
> 
> Signed-off-by: Chris Bainbridge <chris.bainbridge@gmail.com>

Applied, thanks!

> ---
>  drivers/acpi/sbs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
> index cd82762..01504c8 100644
> --- a/drivers/acpi/sbs.c
> +++ b/drivers/acpi/sbs.c
> @@ -684,7 +684,7 @@ static int acpi_sbs_add(struct acpi_device *device)
>  	if (!sbs_manager_broken) {
>  		result = acpi_manager_get_info(sbs);
>  		if (!result) {
> -			sbs->manager_present = 0;
> +			sbs->manager_present = 1;
>  			for (id = 0; id < MAX_SBS_BAT; ++id)
>  				if ((sbs->batteries_supported & (1 << id)))
>  					acpi_battery_add(sbs, id);
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
