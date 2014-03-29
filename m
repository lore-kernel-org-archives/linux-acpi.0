From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [Patch v1 4/4] iio: imu: inv_mpu6050: ACPI enumeration
Date: Sat, 29 Mar 2014 10:59:34 +0000
Message-ID: <5336A796.502@kernel.org>
References: <1395248203-17027-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1395248203-17027-4-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1395248203-17027-4-git-send-email-srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On 19/03/14 16:56, Srinivas Pandruvada wrote:
> Added changes so that the module can be enumerated via ACPI.
> Also if there is no platform data available, it will use a default
> orientation data.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
This one looks fine as well, but again I can't take it now because of
patch 2 interfering with it.

Thanks,

Jonathan
> ---
>   drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 31 ++++++++++++++++++++++++++++--
>   1 file changed, 29 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 200163d..2b3f24d 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -24,8 +24,16 @@
>   #include <linux/kfifo.h>
>   #include <linux/spinlock.h>
>   #include <linux/iio/iio.h>
> +#include <linux/acpi.h>
>   #include "inv_mpu_iio.h"
>
> +/* Define some default platform data, if not supplied */
> +static struct inv_mpu6050_platform_data inv_def_platform_data = {
> +	.orientation = {-1,  0,  0,
> +			0,  1,  0,
> +			0,  0, -1 }
> +};
> +
>   /*
>    * this is the gyro scale translated from dynamic range plus/minus
>    * {250, 500, 1000, 2000} to rad/s
> @@ -706,6 +714,7 @@ static int inv_mpu_probe(struct i2c_client *client,
>   	struct inv_mpu6050_state *st;
>   	struct iio_dev *indio_dev;
>   	int result;
> +	char *name;
>
>   	if (!i2c_check_functionality(client->adapter,
>   		I2C_FUNC_SMBUS_I2C_BLOCK))
> @@ -717,7 +726,10 @@ static int inv_mpu_probe(struct i2c_client *client,
>
>   	st = iio_priv(indio_dev);
>   	st->client = client;
> -	st->plat_data = *(struct inv_mpu6050_platform_data
> +	if (!dev_get_platdata(&client->dev))
> +		st->plat_data = inv_def_platform_data;
> +	else
> +		st->plat_data = *(struct inv_mpu6050_platform_data
>   				*)dev_get_platdata(&client->dev);
>   	/* power is turned on inside check chip type*/
>   	result = inv_check_and_setup_chip(st, id);
> @@ -733,7 +745,14 @@ static int inv_mpu_probe(struct i2c_client *client,
>
>   	i2c_set_clientdata(client, indio_dev);
>   	indio_dev->dev.parent = &client->dev;
> -	indio_dev->name = id->name;
> +
> +	/* id will be NULL when enumerated via ACPI */
> +	if (id)
> +		name = (char *)id->name;
> +	else
> +		name = (char *)dev_name(&client->dev);
> +
> +	indio_dev->name = name;
>   	indio_dev->channels = inv_mpu_channels;
>   	indio_dev->num_channels = ARRAY_SIZE(inv_mpu_channels);
>
> @@ -815,12 +834,20 @@ static const struct i2c_device_id inv_mpu_id[] = {
>
>   MODULE_DEVICE_TABLE(i2c, inv_mpu_id);
>
> +static const struct acpi_device_id inv_acpi_match[] = {
> +	{"INVN6050", INV_MPU6050},
> +	{"INVN6500", INV_MPU6500},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, inv_acpi_match);
> +
>   static struct i2c_driver inv_mpu_driver = {
>   	.probe		=	inv_mpu_probe,
>   	.remove		=	inv_mpu_remove,
>   	.id_table	=	inv_mpu_id,
>   	.driver = {
>   		.owner	=	THIS_MODULE,
> +		.acpi_match_table = ACPI_PTR(inv_acpi_match),
>   		.name	=	"inv-mpu6050",
>   		.pm     =       INV_MPU6050_PMOPS,
>   	},
>
