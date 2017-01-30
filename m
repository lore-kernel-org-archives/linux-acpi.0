From: walter harms <wharms@bfs.de>
Subject: Re: [PATCH] acpi: nfit: use %u format string specifier for unsigned
 ints
Date: Mon, 30 Jan 2017 12:58:55 +0100
Message-ID: <588F2A7F.8020501@bfs.de>
References: <20170130112502.24426-1-colin.king@canonical.com>
Reply-To: wharms@bfs.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20170130112502.24426-1-colin.king@canonical.com>
Sender: kernel-janitors-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, joeyli.kernel@gmail.com, Toshi Kani <toshi.kani@hpe.com>, linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org



Am 30.01.2017 12:25, schrieb Colin King:
> From: Colin Ian King <colin.king@canonical.com>
> 
> scrub_mode and scrub_count are both unsigned ints, however, the %d
> format string specifier is being used instead of %u. Trivial fix,
> use %u.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/acpi/nfit/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 2f82b8e..093b768 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -906,7 +906,7 @@ static ssize_t hw_error_scrub_show(struct device *dev,
>  	struct nvdimm_bus_descriptor *nd_desc = to_nd_desc(nvdimm_bus);
>  	struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
>  
> -	return sprintf(buf, "%d\n", acpi_desc->scrub_mode);
> +	return sprintf(buf, "%u\n", acpi_desc->scrub_mode);
>  }
>  
>  /*
> @@ -967,7 +967,7 @@ static ssize_t scrub_show(struct device *dev,
>  	if (nd_desc) {
>  		struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
>  
> -		rc = sprintf(buf, "%d%s", acpi_desc->scrub_count,
> +		rc = sprintf(buf, "%u%s", acpi_desc->scrub_count,
>  				(work_busy(&acpi_desc->work)) ? "+\n" : "\n");
>  	}
>  	device_unlock(dev);

looks ok,
would it be an option to move the "\n" into the format string ?
this is much more common (see sprintf() above).

re,
 wh


