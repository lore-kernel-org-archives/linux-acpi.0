From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPICA: Check whether ACPI is disabled before getting a table
Date: Mon, 21 Aug 2017 15:30:47 +0200
Message-ID: <CAJZ5v0iE_H6xeyvzCEMRKhE=iuaP8aUOP4_bT=y2fMJ7htxyew@mail.gmail.com>
References: <20170818194644.14538-1-toshi.kani@hpe.com> <20170818194644.14538-2-toshi.kani@hpe.com>
 <20170821112657.hrtjoeagxhc67rrr@pd.tnic> <CAJZ5v0i_-Sb_o24EcmHN37cQ3fqVf53a+Yc_weX_1Mv7VAOw3g@mail.gmail.com>
 <20170821132054.mwhdxkcka4ocp6h5@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170821132054.mwhdxkcka4ocp6h5@pd.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Toshi Kani <toshi.kani@hpe.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mauro Carvalho Chehab <mchehab@kernel.org>, Tony Luck <tony.luck@intel.com>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "open list:EDAC-CORE" <linux-edac@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Aug 21, 2017 at 3:20 PM, Borislav Petkov <bp@alien8.de> wrote:
> Borislav Petkov <bp@suse.de>
>
> ... and save us the splrinking of this test around in the callers.
>
> No functionality change.
>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  drivers/acpi/acpica/tbxface.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
> index 010b1c43df92..881b0d5b2838 100644
> --- a/drivers/acpi/acpica/tbxface.c
> +++ b/drivers/acpi/acpica/tbxface.c
> @@ -226,6 +226,9 @@ acpi_get_table_header(char *signature,
>         u32 j;
>         struct acpi_table_header *header;
>
> +       if (acpi_disabled)
> +               return (AE_ERROR);
> +
>         /* Parameter validation */
>
>         if (!signature || !out_table_header) {
> --

Is acpi_disabled an ACPICA variable?  If not, this cannot go upstream.
Not a big deal I guess, but somewhat yucky.
