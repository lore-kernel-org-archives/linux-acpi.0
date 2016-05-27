From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH] acpi: cppc: Prevent cpc_desc_ptr points to the invalid data
Date: Fri, 27 May 2016 12:10:04 -0400
Message-ID: <CAJ5Y-ebkd6rbQkegdYUREn775Nu5jZqB3TBex5Rj1JsQ6Sjs-Q@mail.gmail.com>
References: <1464203363-20599-1-git-send-email-hotran@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464203363-20599-1-git-send-email-hotran@apm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hoan Tran <hotran@apm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Duc Dang <dhdang@apm.com>, Loc Ho <lho@apm.com>
List-Id: linux-acpi@vger.kernel.org

On 25 May 2016 at 15:09, Hoan Tran <hotran@apm.com> wrote:
> When CPPC fails to request PCC channel, the CPC data is freed
> and cpc_desc_ptr points to the invalid data. This change prevents
> this issue by moving cpc_desc_ptr assignment after PCC channel
> request.
>
> Signed-off-by: Hoan Tran <hotran@apm.com>
> ---
>  drivers/acpi/cppc_acpi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 8adac69..85fd8f7 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -595,9 +595,6 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>         /* Store CPU Logical ID */
>         cpc_ptr->cpu_id = pr->id;
>
> -       /* Plug it into this CPUs CPC descriptor. */
> -       per_cpu(cpc_desc_ptr, pr->id) = cpc_ptr;
> -
>         /* Parse PSD data for this CPU */
>         ret = acpi_get_psd(cpc_ptr, handle);
>         if (ret)
> @@ -610,6 +607,9 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>                         goto out_free;
>         }
>
> +       /* Plug PSD data into this CPUs CPC descriptor. */
> +       per_cpu(cpc_desc_ptr, pr->id) = cpc_ptr;
> +

Are you seeing a real problem without this change? I'm missing where
this pointer is dereferenced if the PCC channel request fails.

Thanks,
Ashwin.
