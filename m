From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 1/3] acpi: HMAT support in acpi_parse_entries_array()
Date: Sat, 16 Dec 2017 02:53:07 +0100
Message-ID: <1658696.rIK19Js0WO@aspire.rjw.lan>
References: <20171214021019.13579-1-ross.zwisler@linux.intel.com> <20171214021019.13579-2-ross.zwisler@linux.intel.com> <CAPcyv4gnZ3NJsEUugjBrsBHcs9-yqxkvs_G4V1HHGWF2JDi13g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:48330 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755976AbdLPBxx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Dec 2017 20:53:53 -0500
In-Reply-To: <CAPcyv4gnZ3NJsEUugjBrsBHcs9-yqxkvs_G4V1HHGWF2JDi13g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Anaczkowski, Lukasz" <lukasz.anaczkowski@intel.com>, "Box, David E" <david.e.box@intel.com>, "Kogut, Jaroslaw" <Jaroslaw.Kogut@intel.com>, "Koss, Marcin" <marcin.koss@intel.com>, "Koziej, Artur" <artur.koziej@intel.com>, "Lahtinen, Joonas" <joonas.lahtinen@intel.com>, "Moore, Robert" <robert.moore@intel.com>, "Nachimuthu, Murugasamy" <murugasamy.nachimuthu@intel.com>, "Odzioba, Lukasz" <lukasz.odzioba@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Schmauss, Erik" <erik.schmauss@intel.com>, "Verma, Vishal L" <vishal.l.verma@intel.com>, "Zheng, Lv" <lv.zheng@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Balbir Singh <bsingharora>

On Friday, December 15, 2017 2:10:17 AM CET Dan Williams wrote:
> On Wed, Dec 13, 2017 at 6:10 PM, Ross Zwisler
> <ross.zwisler@linux.intel.com> wrote:
> > The current implementation of acpi_parse_entries_array() assumes that each
> > subtable has a standard ACPI subtable entry of type struct
> > acpi_subtable_header.  This standard subtable header has a one byte length
> > followed by a one byte type.
> >
> > The HMAT subtables have to allow for a longer length so they have subtable
> > headers of type struct acpi_hmat_structure which has a 2 byte type and a 4
> > byte length.
> 
> Hmm, NFIT has a 2 byte type and a 2 byte length, so its one more
> permutation. I happened to reinvent sub-table parsing in the NFIT
> driver, but it might be nice in the future to refactor that to use the
> common parsing.
> 
> >
> > Enhance the subtable parsing in acpi_parse_entries_array() so that it can
> > handle these new HMAT subtables.
> >
> > Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> > ---
> >  drivers/acpi/tables.c | 52 ++++++++++++++++++++++++++++++++++++++++-----------
> >  1 file changed, 41 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> > index 80ce2a7d224b..f777b94c234a 100644
> > --- a/drivers/acpi/tables.c
> > +++ b/drivers/acpi/tables.c
> > @@ -218,6 +218,33 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
> >         }
> >  }
> >
> > +static unsigned long __init
> > +acpi_get_entry_type(char *id, void *entry)
> > +{
> > +       if (strncmp(id, ACPI_SIG_HMAT, 4) == 0)
> > +               return ((struct acpi_hmat_structure *)entry)->type;
> > +       else
> > +               return ((struct acpi_subtable_header *)entry)->type;
> > +}
> 
> It seems inefficient to make all checks keep asking "is HMAT?".

Well, ideally, the signature should be checked once.  I guess that can be
arranged for here.

> Especially if we want to extend this to other table types should we
> instead setup and pass a pair of function pointers to parse the
> sub-table format?

Function pointers may be too much even. :-)

Thanks,
Rafael

