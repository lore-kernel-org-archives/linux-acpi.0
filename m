From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/2] ACPI: SPCR: Use access width to determine mmio usage
Date: Mon, 3 Jul 2017 23:44:30 +0200
Message-ID: <CAJZ5v0gw82WcRomx0b=ZmxdXG4VFP8iCXSoQ_BvArQvOoi90TA@mail.gmail.com>
References: <1499117589-4829-1-git-send-email-lho@apm.com> <1499117589-4829-2-git-send-email-lho@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1499117589-4829-2-git-send-email-lho@apm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Loc Ho <lho@apm.com>, Aleksey Makarov <aleksey.makarov@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Jon Mason <jon.mason@broadcom.com>, Jon Masters <jcm@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, patches@apm.com
List-Id: linux-acpi@vger.kernel.org

On Mon, Jul 3, 2017 at 11:33 PM, Loc Ho <lho@apm.com> wrote:
> The current SPCR code does not check the access width of the mmio, and
> uses a default of 8bit register accesses.  This prevents devices that
> only do 16 or 32bit register accesses from working.  By simply checking
> this field and setting the mmio string appropriately, this issue can be
> corrected.  To prevent any legacy issues, the code will default to 8bit
> accesses if the value is anything but 16 or 32.
>
> Signed-off-by: Loc Ho <lho@apm.com>
> [Re-send as single patch set]
> Signed-off-by: Jon Mason <jon.mason@broadcom.com>

Greg, Aleksey, any objections here?

If not, I'll route this through the ACPI tree.


> ---
>  drivers/acpi/spcr.c     | 18 ++++++++++++++++--
>  include/acpi/acrestyp.h |  7 +++++++
>  2 files changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
> index 3afa8c1..2905063 100644
> --- a/drivers/acpi/spcr.c
> +++ b/drivers/acpi/spcr.c
> @@ -74,8 +74,22 @@ int __init parse_spcr(bool earlycon)
>                 goto done;
>         }
>
> -       iotype = table->serial_port.space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY ?
> -                       "mmio" : "io";
> +       if (table->serial_port.space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
> +               switch (table->serial_port.access_width) {
> +               default:
> +                       pr_err("Unexpected SPCR Access Width.  Defaulting to byte size\n");
> +               case ACPI_ACCESS_SIZE_BYTE:
> +                       iotype = "mmio";
> +                       break;
> +               case ACPI_ACCESS_SIZE_WORD:
> +                       iotype = "mmio16";
> +                       break;
> +               case ACPI_ACCESS_SIZE_DWORD:
> +                       iotype = "mmio32";
> +                       break;
> +               }
> +       } else
> +               iotype = "io";
>
>         switch (table->interface_type) {
>         case ACPI_DBG2_ARM_SBSA_32BIT:
> diff --git a/include/acpi/acrestyp.h b/include/acpi/acrestyp.h
> index f0f7403..781cb55 100644
> --- a/include/acpi/acrestyp.h
> +++ b/include/acpi/acrestyp.h
> @@ -372,6 +372,13 @@ struct acpi_resource_generic_register {
>         u64 address;
>  };
>
> +/* Generic Address Space Access Sizes */
> +#define ACPI_ACCESS_SIZE_UNDEFINED             0
> +#define ACPI_ACCESS_SIZE_BYTE                  1
> +#define ACPI_ACCESS_SIZE_WORD                  2
> +#define ACPI_ACCESS_SIZE_DWORD                 3
> +#define ACPI_ACCESS_SIZE_QWORD                 4
> +
>  struct acpi_resource_gpio {
>         u8 revision_id;
>         u8 connection_type;
> --
> 1.8.3.1
>
