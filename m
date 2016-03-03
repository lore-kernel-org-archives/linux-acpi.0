From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 3/4] resource: Add device-managed insert/remove_resource()
Date: Thu, 3 Mar 2016 14:45:10 -0800
Message-ID: <CAPcyv4iBg0fsaAM-fnHaDir6mosLM-gwr+VU_doTsYU6st-yyQ@mail.gmail.com>
References: <1456959056-12316-1-git-send-email-toshi.kani@hpe.com>
	<1456959056-12316-4-git-send-email-toshi.kani@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:33480 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753954AbcCCWpM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Mar 2016 17:45:12 -0500
Received: by mail-ob0-f173.google.com with SMTP id fz5so34744311obc.0
        for <linux-acpi@vger.kernel.org>; Thu, 03 Mar 2016 14:45:12 -0800 (PST)
In-Reply-To: <1456959056-12316-4-git-send-email-toshi.kani@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Toshi Kani <toshi.kani@hpe.com>
Cc: Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andrew Morton <akpm@linux-foundation.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Mar 2, 2016 at 2:50 PM, Toshi Kani <toshi.kani@hpe.com> wrote:
> insert_resource() and remove_resouce() are called by producers
> of resources, such as FW modules and bus drivers.  These modules
> may be implemented as loadable modules.
>
> Add device-managed implementaions of insert_resource() and
> remove_resouce() functions.
>
> Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> ---
>  include/linux/ioport.h |    5 +++
>  kernel/resource.c      |   69 ++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 74 insertions(+)
>
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index 8017b8b..3580038 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -259,6 +259,11 @@ extern struct resource * __devm_request_region(struct device *dev,
>
>  extern void __devm_release_region(struct device *dev, struct resource *parent,
>                                   resource_size_t start, resource_size_t n);
> +
> +extern int devm_insert_resource(struct device *dev, struct resource *root,
> +                                struct resource *new);
> +extern void devm_remove_resource(struct device *dev, struct resource *old);
> +
>  extern int iomem_map_sanity_check(resource_size_t addr, unsigned long size);
>  extern int iomem_is_exclusive(u64 addr);
>
> diff --git a/kernel/resource.c b/kernel/resource.c
> index effb6ee..b1a3394 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -1449,6 +1449,75 @@ void __devm_release_region(struct device *dev, struct resource *parent,
>  EXPORT_SYMBOL(__devm_release_region);
>
>  /*
> + * Remove function for devm_insert_resource() and devm_remove_resource().
> + */
> +static void devm_resource_remove(struct device *dev, void *ptr)
> +{
> +       struct resource **r = ptr;
> +
> +       remove_resource(*r);
> +}
> +

Maybe call this __devm_remove_resource?  I think this makes it clearer
that it is a private helper function.  I was initially confused about
the difference between devm_resource_remove and devm_remove_resource.
