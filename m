From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [patch] ACPI/CPPC: signedness bug in register_pcc_channel()
Date: Fri, 23 Oct 2015 04:45:09 -0400
Message-ID: <CAJ5Y-ebKF1Au2C9Q3vyvmugDEomfqhO89KAgsUrph4sgxT_t9w@mail.gmail.com>
References: <20151022195259.GC24439@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20151022195259.GC24439@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 22 October 2015 at 15:52, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> The "pcc_subspace_idx" is -1 if it hasn't been initialized yet.  We need
> it to be signed.
>
> Fixes: 337aadff8e45 ('ACPI: Introduce CPU performance controls using CPPC')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 0bbf84b..2ed5516 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -302,7 +302,7 @@ err_ret:
>  }
>  EXPORT_SYMBOL_GPL(acpi_get_psd_map);
>
> -static int register_pcc_channel(unsigned pcc_subspace_idx)
> +static int register_pcc_channel(int pcc_subspace_idx)
>  {
>         struct acpi_pcct_subspace *cppc_ss;
>         unsigned int len;

Acked-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>

Thanks,
Ashwin.
