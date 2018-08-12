From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi: bus: Fixed a pointer coding style issue
Date: Sun, 12 Aug 2018 13:16:53 +0200
Message-ID: <3140204.5IURiOkdET@aspire.rjw.lan>
References: <20180808005202.4011-1-thomas.m.a.todd@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180808005202.4011-1-thomas.m.a.todd@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tom Todd <thomas.m.a.todd@gmail.com>
Cc: rjw@jwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday, August 8, 2018 2:52:02 AM CEST Tom Todd wrote:
> Fixed a coding style issue.
> 
> Signed-off-by: Tom Todd <thomas.m.a.todd@gmail.com>
> ---
>  drivers/acpi/bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 84b4a62018eb..73e43d81ec63 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -962,7 +962,7 @@ static int acpi_device_probe(struct device *dev)
>  	return 0;
>  }
>  
> -static int acpi_device_remove(struct device * dev)
> +static int acpi_device_remove(struct device *dev)
>  {
>  	struct acpi_device *acpi_dev = to_acpi_device(dev);
>  	struct acpi_driver *acpi_drv = acpi_dev->driver;
> 

Applied (with a modified changelog), thanks!
