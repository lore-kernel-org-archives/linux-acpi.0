From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 6/6] ACPI:  update thermal temperature
Date: Thu, 17 Apr 2008 14:21:28 +0200
Message-ID: <20080417142128.34a58bda@hyperion.delvare>
References: <1207815623.27304.49.camel@acpi-hp-zz.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lm-sensors-bounces@lm-sensors.org>
In-Reply-To: <1207815623.27304.49.camel@acpi-hp-zz.sh.intel.com>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/lm-sensors>,
	<mailto:lm-sensors-request@lm-sensors.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/lm-sensors>
List-Post: <mailto:lm-sensors@lm-sensors.org>
List-Help: <mailto:lm-sensors-request@lm-sensors.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/lm-sensors>,
	<mailto:lm-sensors-request@lm-sensors.org?subject=subscribe>
Sender: lm-sensors-bounces@lm-sensors.org
Errors-To: lm-sensors-bounces@lm-sensors.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Rui,

On Thu, 10 Apr 2008 16:20:23 +0800, Zhang, Rui wrote:
> Fix the problem that thermal_get_temp returns the cached value,
> which causes the temperature in generic thermal never updates.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/thermal.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> Index: linux-2.6/drivers/acpi/thermal.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/thermal.c
> +++ linux-2.6/drivers/acpi/thermal.c
> @@ -884,10 +884,15 @@ static void acpi_thermal_check(void *dat
>  static int thermal_get_temp(struct thermal_zone_device *thermal, char *buf)
>  {
>  	struct acpi_thermal *tz = thermal->devdata;
> +	int result;
>  
>  	if (!tz)
>  		return -EINVAL;
>  
> +	result = acpi_thermal_get_temperature(tz);
> +	if (result)
> +		return result;
> +
>  	return sprintf(buf, "%ld\n", KELVIN_TO_MILLICELSIUS(tz->temperature));
>  }
>  

Yes, this fixes the problem I reported, thank you.

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
