From: Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH 6/7] acpi: Create subtable parsing infrastructure
Date: Mon, 19 Nov 2018 11:36:13 -0700
Message-ID: <20181119183613.GB26707@localhost.localdomain>
References: <20181114224921.12123-2-keith.busch@intel.com>
 <20181114224921.12123-7-keith.busch@intel.com>
 <CAJZ5v0gQCpmRHdSS=xxLSx-+1xbexSFQb_ZxMvZuKUjk6+w5ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gQCpmRHdSS=xxLSx-+1xbexSFQb_ZxMvZuKUjk6+w5ww@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Hansen <dave.hansen@intel.com>, Dan Williams <dan.j.williams@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Mon, Nov 19, 2018 at 10:58:12AM +0100, Rafael J. Wysocki wrote:
> > +static unsigned long __init
> > +acpi_get_entry_length(struct acpi_subtable_entry *entry)
> > +{
> > +       switch (entry->type) {
> > +       case ACPI_SUBTABLE_COMMON:
> > +               return entry->hdr->common.length;
> > +       }
> > +       WARN_ONCE(1, "invalid acpi type\n");
> 
> AFAICS this does a WARN_ONCE() on information obtained from firmware.
> 
> That is not a kernel problem, so generating traces in that case is not
> a good idea IMO.  Moreover, users can't really do much about this in
> the majority of cases, so a pr_info() message should be sufficient.

Sure thing, I'll fix that up for the next revision.
