From: Loc Ho <lho-qTEPVZfXA3Y@public.gmane.org>
Subject: Re: [PATCH v4 2/2] acpi: apei: Enable APEI multiple GHES source to
 share an single external IRQ
Date: Mon, 25 Jan 2016 13:25:00 -0800
Message-ID: <CAPw-ZTmmK1RvKQVpNLtP=X+cxMVj3wYqq78x1eZ+2w5+5Q1dYg@mail.gmail.com>
References: <1453335459-3617-1-git-send-email-lho@apm.com>
	<1453335459-3617-3-git-send-email-lho@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1453335459-3617-3-git-send-email-lho-qTEPVZfXA3Y@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Doug Thompson <dougthompson-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org>, Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Tomasz Nowicki <tomasz.nowicki-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-edac <linux-edac-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "patches-qTEPVZfXA3Y@public.gmane.org" <patches-qTEPVZfXA3Y@public.gmane.org>, Loc Ho <lho-qTEPVZfXA3Y@public.gmane.org>, Tuan Phan <tphan-qTEPVZfXA3Y@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Borislav,

On Wed, Jan 20, 2016 at 4:17 PM, Loc Ho <lho-qTEPVZfXA3Y@public.gmane.org> wrote:
> This patch allows APEI generic error source table with external
> IRQ to share an single IRQ.
>
> Signed-off-by: Tuan Phan <tphan-qTEPVZfXA3Y@public.gmane.org>
> Signed-off-by: Loc Ho <lho-qTEPVZfXA3Y@public.gmane.org>
> ---
>  drivers/acpi/apei/ghes.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 3dd9c46..76146c8 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -1011,7 +1011,8 @@ static int ghes_probe(struct platform_device *ghes_dev)
>                                generic->header.source_id);
>                         goto err_edac_unreg;
>                 }
> -               rc = request_irq(ghes->irq, ghes_irq_func, 0, "GHES IRQ", ghes);
> +               rc = request_irq(ghes->irq, ghes_irq_func, IRQF_SHARED,
> +                                "GHES IRQ", ghes);
>                 if (rc) {
>                         pr_err(GHES_PFX "Failed to register IRQ for generic hardware error source: %d\n",
>                                generic->header.source_id);

Can this be pull into 4.5-rcX given that it was already ack'ed week back?

-Loc
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
