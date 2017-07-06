From: Ross Zwisler <ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [RFC v2 2/5] acpi: HMAT support in acpi_parse_entries_array()
Date: Thu, 6 Jul 2017 16:22:00 -0600
Message-ID: <20170706222200.GA31795@linux.intel.com>
References: <20170706215233.11329-1-ross.zwisler@linux.intel.com>
 <20170706215233.11329-3-ross.zwisler@linux.intel.com>
 <CAJZ5v0gUA4d+NFqEdsXPVktXf+2AX9MurEQAiCFGxU_eaoYE5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gUA4d+NFqEdsXPVktXf+2AX9MurEQAiCFGxU_eaoYE5A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "Box, David E" <david.e.box-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dave Hansen <dave.hansen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Zheng, Lv" <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org" <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Anaczkowski,
 Lukasz" <lukasz.anaczkowski-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Moore,
 Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Odzioba,
 Lukasz" <lukasz.odzioba-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Schmauss, Erik" <erik.schmauss-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jerome Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org" <devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org>, "Kogut,
 Jaroslaw" <Jaroslaw.Kogut-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linux Memory Management List <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Nachimuthu,
 Murugasamy" <murugasamy.nachimuthu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lahtinen,
 Joo
List-Id: linux-acpi@vger.kernel.org

On Fri, Jul 07, 2017 at 12:13:54AM +0200, Rafael J. Wysocki wrote:
> On Thu, Jul 6, 2017 at 11:52 PM, Ross Zwisler
> <ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> > The current implementation of acpi_parse_entries_array() assumes that each
> > subtable has a standard ACPI subtable entry of type struct
> > acpi_sutbable_header.  This standard subtable header has a one byte length
> > followed by a one byte type.
> >
> > The HMAT subtables have to allow for a longer length so they have subtable
> > headers of type struct acpi_hmat_structure which has a 2 byte type and a 4
> > byte length.
> >
> > Enhance the subtable parsing in acpi_parse_entries_array() so that it can
> > handle these new HMAT subtables.
> >
> > Signed-off-by: Ross Zwisler <ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > ---
> >  drivers/acpi/numa.c   |  2 +-
> >  drivers/acpi/tables.c | 52 ++++++++++++++++++++++++++++++++++++++++-----------
> >  2 files changed, 42 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
> > index edb0c79..917f1cc 100644
> > --- a/drivers/acpi/numa.c
> > +++ b/drivers/acpi/numa.c
> > @@ -443,7 +443,7 @@ int __init acpi_numa_init(void)
> >          * So go over all cpu entries in SRAT to get apicid to node mapping.
> >          */
> >
> > -       /* SRAT: Static Resource Affinity Table */
> > +       /* SRAT: System Resource Affinity Table */
> >         if (!acpi_table_parse(ACPI_SIG_SRAT, acpi_parse_srat)) {
> >                 struct acpi_subtable_proc srat_proc[3];
> >
> 
> This change is unrelated to the rest of the patch.
> 
> Maybe send it separately?

Sure, will do.

> > diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> > index ff42539..7979171 100644
> > --- a/drivers/acpi/tables.c
> > +++ b/drivers/acpi/tables.c
> > @@ -218,6 +218,33 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
> >         }
> >  }
> >
> > +static unsigned long __init
> > +acpi_get_entry_type(char *id, void *entry)
> > +{
> > +       if (!strncmp(id, ACPI_SIG_HMAT, 4))
> > +               return ((struct acpi_hmat_structure *)entry)->type;
> > +       else
> > +               return ((struct acpi_subtable_header *)entry)->type;
> > +}
> 
> I slightly prefer to use ? : in similar situations.

Hmm..that becomes rather long, and seems complex for the already hard to read
?: operator?  Let's see, this:

	if (!strncmp(id, ACPI_SIG_HMAT, 4))
		return ((struct acpi_hmat_structure *)entry)->type;
	else
		return ((struct acpi_subtable_header *)entry)->type;

becomes

	return strncmp(id, ACPI_SIG_HMAT, 4)) ?
		((struct acpi_subtable_header *)entry)->type :
		((struct acpi_hmat_structure *)entry)->type;

Hmm...we only save one line, and I personally find that a lot harder to read,
but that being said if you feel strongly about it I'll make the change.
