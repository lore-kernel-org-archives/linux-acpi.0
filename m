From: "Xue, Ken" <Ken.Xue@amd.com>
Subject: RE: [PATCH V2] ACPI: APD: Add device HID for future AMD UART
 controller
Date: Wed, 16 Mar 2016 05:07:04 +0000
Message-ID: <DM2PR12MB0201D0E0056D908D90A2ED53FB8A0@DM2PR12MB0201.namprd12.prod.outlook.com>
References: <1457688503-2377-1-git-send-email-annie.wang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457688503-2377-1-git-send-email-annie.wang@amd.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, SPG_Linux_Kernel <SPG_Linux_Kernel@amd.com>, "Wang, Annie" <Annie.Wang@amd.com>
List-Id: linux-acpi@vger.kernel.org

> From: Wang Hongcheng [mailto:annie.wang@amd.com]
> Sent: Friday, March 11, 2016 5:28 PM
> To: Rafael J. Wysocki; Len Brown; linux-acpi@vger.kernel.org; linux-
> kernel@vger.kernel.org; SPG_Linux_Kernel
> Cc: Wang, Annie
> Subject: [PATCH V2] ACPI: APD: Add device HID for future AMD UART
> controller
> 
> Add device HID AMDI0020 to match the AMD ACPI Vendor ID (AMDI) as
> registered in http://www.uefi.org/acpi_id_list, and the UART controller on
> future AMD paltform will use the HID instead of AMD0020.
> 
> Signed-off-by: Wang Hongcheng <annie.wang@amd.com>


Acked-by: Ken Xue <Ken.Xue@amd.com>

Hi Rafael,
Can you help apply and queue this patch into V4.6 like patch  "i2c: designware: Add device HID for future AMD I2C controller"?
Thanks.

> ---
>  drivers/acpi/acpi_apd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c index
> a450e7a..dc2d8a5 100644
> --- a/drivers/acpi/acpi_apd.c
> +++ b/drivers/acpi/acpi_apd.c
> @@ -134,6 +134,7 @@ static const struct acpi_device_id
> acpi_apd_device_ids[] = {
>  	/* Generic apd devices */
>  	{ "AMD0010", APD_ADDR(cz_i2c_desc) },
>  	{ "AMD0020", APD_ADDR(cz_uart_desc) },
> +	{ "AMDI0020", APD_ADDR(cz_uart_desc) },
>  	{ "AMD0030", },
>  	{ }
>  };
> --
> 1.9.1
