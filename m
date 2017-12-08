From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPICA: Fix indentation
Date: Fri, 8 Dec 2017 18:06:19 +0100
Message-ID: <CAJZ5v0hgt8MLkxSHeN1A49p4g6VCr-r8x7RGun9eVmtx0PZKgg@mail.gmail.com>
References: <1512750553-15467-1-git-send-email-gomonovych@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1512750553-15467-1-git-send-email-gomonovych@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vasyl Gomonovych <gomonovych@gmail.com>
Cc: Robert Moore <robert.moore@intel.com>, Lv <lv.zheng@intel.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Schmauss, Erik" <erik.schmauss@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Fri, Dec 8, 2017 at 5:29 PM, Vasyl Gomonovych <gomonovych@gmail.com> wrote:
> This patch avoids that smatch reports the following:
> drivers/acpi/acpica/exdump.c:623 acpi_ex_dump_operand() warn: inconsistent indenting
>
> Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>

This is ACPICA code, so changes like this should go in via the upstream.

Erik may want to pick this up, however.

> ---
>  drivers/acpi/acpica/exdump.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpica/exdump.c b/drivers/acpi/acpica/exdump.c
> index 83398dc..f43d3d7 100644
> --- a/drivers/acpi/acpica/exdump.c
> +++ b/drivers/acpi/acpica/exdump.c
> @@ -619,8 +619,8 @@ void acpi_ex_dump_operand(union acpi_operand_object *obj_desc, u32 depth)
>
>         ACPI_FUNCTION_NAME(ex_dump_operand)
>
> -           /* Check if debug output enabled */
> -           if (!ACPI_IS_DEBUG_ENABLED(ACPI_LV_EXEC, _COMPONENT)) {
> +       /* Check if debug output enabled */
> +       if (!ACPI_IS_DEBUG_ENABLED(ACPI_LV_EXEC, _COMPONENT)) {
>                 return;
>         }
>
> --
