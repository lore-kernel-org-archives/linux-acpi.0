From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI/device_sysfs: Add sysfs support for _HRV hardware revision
Date: Tue, 26 Apr 2016 22:41:50 +0200
Message-ID: <2388310.jGjaKS2NDe@vostro.rjw.lan>
References: <1460558894-11971-1-git-send-email-betty.dall@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460558894-11971-1-git-send-email-betty.dall@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Betty Dall <betty.dall@hpe.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday, April 13, 2016 08:48:14 AM Betty Dall wrote:
> The ACPI _HRV object on the device is used to supply Linux with
> the device's hardware revision. This is an optional object. Add
> sysfs support for the _HRV object if it exists on the device.
> 
> Signed-off-by: Betty Dall <betty.dall@hpe.com>
> ---
>  drivers/acpi/device_sysfs.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> index b9afb47..bf12dbe 100644
> --- a/drivers/acpi/device_sysfs.c
> +++ b/drivers/acpi/device_sysfs.c
> @@ -473,6 +473,21 @@ acpi_device_sun_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR(sun, 0444, acpi_device_sun_show, NULL);
>  
> +static ssize_t
> +acpi_device_hrv_show(struct device *dev, struct device_attribute *attr,
> +		     char *buf) {
> +	struct acpi_device *acpi_dev = to_acpi_device(dev);
> +	acpi_status status;
> +	unsigned long long hrv;
> +
> +	status = acpi_evaluate_integer(acpi_dev->handle, "_HRV", NULL, &hrv);
> +	if (ACPI_FAILURE(status))
> +		return -ENODEV;

Actually, this should be -EIO I think.

Thanks,
Rafael
