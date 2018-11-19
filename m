From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 6/7] acpi: Create subtable parsing infrastructure
Date: Mon, 19 Nov 2018 10:58:12 +0100
Message-ID: <CAJZ5v0gQCpmRHdSS=xxLSx-+1xbexSFQb_ZxMvZuKUjk6+w5ww@mail.gmail.com>
References: <20181114224921.12123-2-keith.busch@intel.com> <20181114224921.12123-7-keith.busch@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181114224921.12123-7-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keith Busch <keith.busch@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Dave Hansen <dave.hansen@intel.com>, Dan Williams <dan.j.williams@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, Nov 14, 2018 at 11:53 PM Keith Busch <keith.busch@intel.com> wrote:
>
> Parsing entries in an ACPI table had assumed a generic header structure
> that is most common. There is no standard ACPI header, though, so less
> common types would need custom parsers if they want go walk their
> subtable entry list.
>
> Create the infrastructure for adding different table types so parsing
> the entries array may be more reused for all ACPI system tables.
>
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/acpi/tables.c | 75 ++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 65 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 61203eebf3a1..15ee77780f68 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -49,6 +49,19 @@ static struct acpi_table_desc initial_tables[ACPI_MAX_TABLES] __initdata;
>
>  static int acpi_apic_instance __initdata;
>
> +enum acpi_subtable_type {
> +       ACPI_SUBTABLE_COMMON,
> +};
> +
> +union acpi_subtable_headers {
> +       struct acpi_subtable_header common;
> +};
> +
> +struct acpi_subtable_entry {
> +       union acpi_subtable_headers *hdr;
> +       enum acpi_subtable_type type;
> +};
> +
>  /*
>   * Disable table checksum verification for the early stage due to the size
>   * limitation of the current x86 early mapping implementation.
> @@ -217,6 +230,45 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
>         }
>  }
>
> +static unsigned long __init
> +acpi_get_entry_type(struct acpi_subtable_entry *entry)
> +{
> +       switch (entry->type) {
> +       case ACPI_SUBTABLE_COMMON:
> +               return entry->hdr->common.type;
> +       }
> +       WARN_ONCE(1, "invalid acpi type\n");
> +       return 0;
> +}
> +
> +static unsigned long __init
> +acpi_get_entry_length(struct acpi_subtable_entry *entry)
> +{
> +       switch (entry->type) {
> +       case ACPI_SUBTABLE_COMMON:
> +               return entry->hdr->common.length;
> +       }
> +       WARN_ONCE(1, "invalid acpi type\n");

AFAICS this does a WARN_ONCE() on information obtained from firmware.

That is not a kernel problem, so generating traces in that case is not
a good idea IMO.  Moreover, users can't really do much about this in
the majority of cases, so a pr_info() message should be sufficient.

And similarly below.
