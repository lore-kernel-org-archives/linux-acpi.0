From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / fan: Fix error reading cur_state
Date: Tue, 11 Oct 2016 23:56:09 +0200
Message-ID: <1854846.qdKNx1d4Nd@vostro.rjw.lan>
References: <1475614300-133004-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:54182 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1753735AbcJKVtZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 11 Oct 2016 17:49:25 -0400
In-Reply-To: <1475614300-133004-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rui.zhang@intel.com, linux-acpi@vger.kernel.org

On Tuesday, October 04, 2016 01:51:40 PM Srinivas Pandruvada wrote:
> On some platforms with ACPI4 variable speed fan, reading cur_state from
> cooling device returns "invalid value" error. This confuses user space
> applications.
> 
> This issue occurs as the current driver doesn't take account of
> "FineGrainControl" from _FIF(Fan Information). When the "FineGrainControl"
> is set, _FSL(FSL Set Level) takes argument as a percent, which doesn't
> have to match from any control value from _FPS(Fan Performance States).
> It is also possible that the Fan is not actually running at the requested
> speed returning a lower speed.
> On some platforms the BIOS is setting fan speed to a level during boot,
> which will not have an exact match to _FPS control values. The current
> implementation will treat this level as invalid value.
> 
> The simple change is to atleast return state corresponding to a maximum
> control value in the _FPS compared to the current level.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/acpi/fan.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
> index 384cfc3..f34859a 100644
> --- a/drivers/acpi/fan.c
> +++ b/drivers/acpi/fan.c
> @@ -129,8 +129,18 @@ static int fan_get_state_acpi4(struct acpi_device *device, unsigned long *state)
>  
>  	control = obj->package.elements[1].integer.value;
>  	for (i = 0; i < fan->fps_count; i++) {
> -		if (control == fan->fps[i].control)
> +		/*
> +		 * When Fine grain control is set, return the state
> +		 * corresponding to maximum fan->fps[i].control
> +		 * value compared to the current speed. Here the
> +		 * fan->fps[] is sorted array with increasing speed.
> +		 */
> +		if (fan->fif.fine_grain_ctrl && control < fan->fps[i].control) {
> +			i = (i > 0) ? i - 1 : 0;
>  			break;
> +		} else if (control == fan->fps[i].control) {
> +			break;
> +		}
>  	}
>  	if (i == fan->fps_count) {
>  		dev_dbg(&device->dev, "Invalid control value returned\n");
> 

Applied.

Thanks,
Rafael

