From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/4] ACPI: Make acpi_dev_get_resources() method agnostic
Date: Sat, 22 Jul 2017 00:05:39 +0200
Message-ID: <24234737.CuhWYzNn5W@aspire.rjw.lan>
References: <20170720144517.32529-1-lorenzo.pieralisi@arm.com> <20170720144517.32529-3-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:51338 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752780AbdGUWNd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 21 Jul 2017 18:13:33 -0400
In-Reply-To: <20170720144517.32529-3-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Robert Moore <robert.moore@intel.com>, Robin Murphy <robin.murphy@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Feng Kan <fkan@apm.com>, Jon Masters <jcm@redhat.com>, Zhang Rui <rui.zhang@intel.com>, Nate Watterson <nwatters@codeaurora.org>

On Thursday, July 20, 2017 03:45:14 PM Lorenzo Pieralisi wrote:
> The function acpi_dev_get_resources() is completely generic and
> can be used to parse resource objects that are not necessarily
> coming from the _CRS method but also from other objects eg _DMA
> that have the same _CRS resource format.
> 
> Create an acpi_dev_get_resources() helper, internal to the ACPI
> resources parsing compilation unit, acpi_dev_get_resources_method(),
> that takes a char* parameter to detect which ACPI method should be
> called to retrieve the resources list and make acpi_dev_get_resources()
> call it with a method name _CRS leaving the API behaviour unchanged.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> ---
>  drivers/acpi/resource.c | 54 +++++++++++++++++++++++++++++--------------------
>  1 file changed, 32 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index cd4c427..2b20a09 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -573,6 +573,36 @@ static acpi_status acpi_dev_process_resource(struct acpi_resource *ares,
>  	return AE_OK;
>  }
>  
> +static
> +int acpi_dev_get_resources_method(struct acpi_device *adev,

Do not break lines like this, please.

It should be

static int acpi_dev_get...

Also I would call it differently, maybe simply __acpi_dev_get_resources()?

> +				  struct list_head *list,
> +				  int (*preproc)(struct acpi_resource *, void *),
> +				  void *preproc_data, char *method)

const char *method ?

Thanks,
Rafael

