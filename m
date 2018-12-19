From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCHv2 01/12] acpi: Create subtable parsing infrastructure
Date: Wed, 19 Dec 2018 15:59:48 -0800
Message-ID: <CAPcyv4jmGH0FS8iBP9=A-nicNfgHAmU+nBHsGgxyS3RNZ9tV5Q@mail.gmail.com>
References: <20181211010310.8551-1-keith.busch@intel.com> <20181211010310.8551-2-keith.busch@intel.com>
 <CAJZ5v0iqC2CwR2nM7eF6pDcJe2Me-_fFekX=s16-1TGZ6f6gcA@mail.gmail.com> <CF6A88132359CE47947DB4C6E1709ED53C557D62@ORSMSX122.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CF6A88132359CE47947DB4C6E1709ED53C557D62@ORSMSX122.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Schmauss, Erik" <erik.schmauss@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Busch, Keith" <keith.busch@intel.com>, "Moore, Robert" <robert.moore@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Hansen, Dave" <dave.hansen@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, Dec 19, 2018 at 3:19 PM Schmauss, Erik <erik.schmauss@intel.com> wrote:
>
>
>
> > -----Original Message-----
> > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> > owner@vger.kernel.org] On Behalf Of Rafael J. Wysocki
> > Sent: Tuesday, December 11, 2018 1:45 AM
> > To: Busch, Keith <keith.busch@intel.com>
> > Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; ACPI Devel
> > Maling List <linux-acpi@vger.kernel.org>; Linux Memory Management List
> > <linux-mm@kvack.org>; Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org>; Rafael J. Wysocki <rafael@kernel.org>;
> > Hansen, Dave <dave.hansen@intel.com>; Williams, Dan J
> > <dan.j.williams@intel.com>
> > Subject: Re: [PATCHv2 01/12] acpi: Create subtable parsing infrastructure
> >
> > On Tue, Dec 11, 2018 at 2:05 AM Keith Busch <keith.busch@intel.com>
> > wrote:
> > >
>
> Hi Rafael and Bob,
>
> > > Parsing entries in an ACPI table had assumed a generic header
> > > structure that is most common. There is no standard ACPI header,
> > > though, so less common types would need custom parsers if they want go
> > > through their sub-table entry list.
> >
> > It looks like the problem at hand is that acpi_hmat_structure is incompatible
> > with acpi_subtable_header because of the different layout and field sizes.
>
> Just out of curiosity, why don't we use ACPICA code to parse static ACPI tables
> in Linux?
>
> We have a disassembler for static tables that parses all supported tables. This
> seems like a duplication of code/effort...

Oh, I thought acpi_table_parse_entries() was the common code. What's
the ACPICA duplicate?
