From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 1/3] acpi: HMAT support in acpi_parse_entries_array()
Date: Thu, 14 Dec 2017 17:10:17 -0800
Message-ID: <CAPcyv4gnZ3NJsEUugjBrsBHcs9-yqxkvs_G4V1HHGWF2JDi13g@mail.gmail.com>
References: <20171214021019.13579-1-ross.zwisler@linux.intel.com>
 <20171214021019.13579-2-ross.zwisler@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <20171214021019.13579-2-ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Ross Zwisler <ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: "Box, David E" <david.e.box-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dave Hansen <dave.hansen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Zheng, Lv" <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org" <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Anaczkowski,
 Lukasz" <lukasz.anaczkowski-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Moore,
 Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linux ACPI <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Odzioba, Lukasz" <lukasz.odzioba-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Schmauss,
 Erik" <erik.schmauss-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, John Hubbard <jhubbard-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Jerome Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org, "Kogut, Jaroslaw" <Jaroslaw.Kogut-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linux MM <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, "Koss, Marcin" <marcin.koss-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Brice Goglin <brice.goglin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Nachimuthu,
 Murugasamy" <murugasamy.nachimuthu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Dec 13, 2017 at 6:10 PM, Ross Zwisler
<ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> The current implementation of acpi_parse_entries_array() assumes that each
> subtable has a standard ACPI subtable entry of type struct
> acpi_subtable_header.  This standard subtable header has a one byte length
> followed by a one byte type.
>
> The HMAT subtables have to allow for a longer length so they have subtable
> headers of type struct acpi_hmat_structure which has a 2 byte type and a 4
> byte length.

Hmm, NFIT has a 2 byte type and a 2 byte length, so its one more
permutation. I happened to reinvent sub-table parsing in the NFIT
driver, but it might be nice in the future to refactor that to use the
common parsing.

>
> Enhance the subtable parsing in acpi_parse_entries_array() so that it can
> handle these new HMAT subtables.
>
> Signed-off-by: Ross Zwisler <ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  drivers/acpi/tables.c | 52 ++++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 41 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 80ce2a7d224b..f777b94c234a 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -218,6 +218,33 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
>         }
>  }
>
> +static unsigned long __init
> +acpi_get_entry_type(char *id, void *entry)
> +{
> +       if (strncmp(id, ACPI_SIG_HMAT, 4) == 0)
> +               return ((struct acpi_hmat_structure *)entry)->type;
> +       else
> +               return ((struct acpi_subtable_header *)entry)->type;
> +}

It seems inefficient to make all checks keep asking "is HMAT?".
Especially if we want to extend this to other table types should we
instead setup and pass a pair of function pointers to parse the
sub-table format?
