From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI/PPTT: Simplify leaf node detection.
Date: Tue, 12 Mar 2019 10:31:59 +0100
Message-ID: <3893217.oT7ovuD9xH@aspire.rjw.lan>
References: <20190301185221.608501-1-jeremy.linton@arm.com> <20190304100208.GA32379@e107155-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190304100208.GA32379@e107155-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, Lorenzo.Pieralisi@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Monday, March 4, 2019 11:02:08 AM CET Sudeep Holla wrote:
> On Fri, Mar 01, 2019 at 12:52:21PM -0600, Jeremy Linton wrote:
> > ACPI 6.3 bumps the PPTT table revision and adds a LEAF_NODE flag.
> > This allows us to avoid a second pass through the table to assure
> > that the node in question is a leaf.
> >
> 
> Reviewed-by:Sudeep Holla <sudeep.holla@arm.com>
> 
> --
> Regards,
> Sudeep
> 
> > Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> > ---
> >  drivers/acpi/pptt.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> > index ad31c50de3be..065c4fc245d1 100644
> > --- a/drivers/acpi/pptt.c
> > +++ b/drivers/acpi/pptt.c
> > @@ -209,6 +209,9 @@ static int acpi_pptt_leaf_node(struct acpi_table_header *table_hdr,
> >  	struct acpi_pptt_processor *cpu_node;
> >  	u32 proc_sz;
> >
> > +	if (table_hdr->revision > 1)
> > +		return (node->flags & ACPI_PPTT_ACPI_LEAF_NODE);
> > +
> >  	table_end = (unsigned long)table_hdr + table_hdr->length;
> >  	node_entry = ACPI_PTR_DIFF(node, table_hdr);
> >  	entry = ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr,
> > --

Patch applied, thanks!
