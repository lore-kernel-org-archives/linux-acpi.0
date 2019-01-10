From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCHv3 02/13] acpi: Add HMAT to generic parsing tables
Date: Thu, 10 Jan 2019 16:36:01 +0100
Message-ID: <CAJZ5v0j40_+-Jjbu4miBKUt8Gnw817G_r1rgCxWHoa9oH-a-Tg@mail.gmail.com>
References: <20190109174341.19818-1-keith.busch@intel.com> <20190109174341.19818-3-keith.busch@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190109174341.19818-3-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keith Busch <keith.busch@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael@kernel.org>, Dave Hansen <dave.hansen@intel.com>, Dan Williams <dan.j.williams@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jan 9, 2019 at 6:47 PM Keith Busch <keith.busch@intel.com> wrote:
>
> The Heterogeneous Memory Attribute Table (HMAT) header has different
> field lengths than the existing parsing uses. Add the HMAT type to the
> parsing rules so it may be generically parsed.
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Keith Busch <keith.busch@intel.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/tables.c | 9 +++++++++
>  include/linux/acpi.h  | 1 +
>  2 files changed, 10 insertions(+)
>
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 967e1168becf..d9911cd55edc 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -51,6 +51,7 @@ static int acpi_apic_instance __initdata;
>
>  enum acpi_subtable_type {
>         ACPI_SUBTABLE_COMMON,
> +       ACPI_SUBTABLE_HMAT,
>  };
>
>  struct acpi_subtable_entry {
> @@ -232,6 +233,8 @@ acpi_get_entry_type(struct acpi_subtable_entry *entry)
>         switch (entry->type) {
>         case ACPI_SUBTABLE_COMMON:
>                 return entry->hdr->common.type;
> +       case ACPI_SUBTABLE_HMAT:
> +               return entry->hdr->hmat.type;
>         }
>         return 0;
>  }
> @@ -242,6 +245,8 @@ acpi_get_entry_length(struct acpi_subtable_entry *entry)
>         switch (entry->type) {
>         case ACPI_SUBTABLE_COMMON:
>                 return entry->hdr->common.length;
> +       case ACPI_SUBTABLE_HMAT:
> +               return entry->hdr->hmat.length;
>         }
>         return 0;
>  }
> @@ -252,6 +257,8 @@ acpi_get_subtable_header_length(struct acpi_subtable_entry *entry)
>         switch (entry->type) {
>         case ACPI_SUBTABLE_COMMON:
>                 return sizeof(entry->hdr->common);
> +       case ACPI_SUBTABLE_HMAT:
> +               return sizeof(entry->hdr->hmat);
>         }
>         return 0;
>  }
> @@ -259,6 +266,8 @@ acpi_get_subtable_header_length(struct acpi_subtable_entry *entry)
>  static enum acpi_subtable_type __init
>  acpi_get_subtable_type(char *id)
>  {
> +       if (strncmp(id, ACPI_SIG_HMAT, 4) == 0)
> +               return ACPI_SUBTABLE_HMAT;
>         return ACPI_SUBTABLE_COMMON;
>  }
>
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 7c3c4ebaded6..53f93dff171c 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -143,6 +143,7 @@ enum acpi_address_range_id {
>  /* Table Handlers */
>  union acpi_subtable_headers {
>         struct acpi_subtable_header common;
> +       struct acpi_hmat_structure hmat;
>  };
>
>  typedef int (*acpi_tbl_table_handler)(struct acpi_table_header *table);
> --
> 2.14.4
>
