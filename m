From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] mailbox: PCC: handle parse error
Date: Fri, 14 Sep 2018 10:41:06 +0200
Message-ID: <8358588.tR87Gxe1PI@aspire.rjw.lan>
References: <1535397548-69588-1-git-send-email-darcari@redhat.com> <e9d05632-dae6-b904-fe62-d617b3dfe3fd@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e9d05632-dae6-b904-fe62-d617b3dfe3fd@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ahs3@redhat.com, David Arcari <darcari@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Jassi Brar <jassisinghbrar@gmail.com>
List-Id: linux-acpi@vger.kernel.org

On Monday, August 27, 2018 10:55:41 PM CEST Al Stone wrote:
> On 08/27/2018 01:19 PM, David Arcari wrote:
> > acpi_pcc_probe calls acpi_table_parse_entries_array but fails to check
> > for an error return.  This in turn can result in calling kcalloc with
> > a negative count as well as emitting the following misleading erorr
> > message:
> > 
> > [    2.642015] Could not allocate space for PCC mbox channels
> > 
> > Fixes: 8f8027c5f935 ("mailbox: PCC: erroneous error message when parsing ACPI PCCT")
> > 
> > Signed-off-by: David Arcari <darcari@redhat.com>
> > Cc: Al Stone <ahs3@redhat.com>
> > Cc: Jassi Brar <jassisinghbrar@gmail.com>
> > ---
> >  drivers/mailbox/pcc.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> > index 311e91b..256f18b 100644
> > --- a/drivers/mailbox/pcc.c
> > +++ b/drivers/mailbox/pcc.c
> > @@ -461,8 +461,11 @@ static int __init acpi_pcc_probe(void)
> >  	count = acpi_table_parse_entries_array(ACPI_SIG_PCCT,
> >  			sizeof(struct acpi_table_pcct), proc,
> >  			ACPI_PCCT_TYPE_RESERVED, MAX_PCC_SUBSPACES);
> > -	if (count == 0 || count > MAX_PCC_SUBSPACES) {
> > -		pr_warn("Invalid PCCT: %d PCC subspaces\n", count);
> > +	if (count <= 0 || count > MAX_PCC_SUBSPACES) {
> > +		if (count < 0)
> > +			pr_warn("Error parsing PCC subspaces from PCCT\n");
> > +		else
> > +			pr_warn("Invalid PCCT: %d PCC subspaces\n", count);
> >  		return -EINVAL;
> >  	}
> >  
> > 
> 
> Thanks, David.  Nice catch.
> 
> Reviewed-by: Al Stone <ahs3@redhat.com>

Patch applied, thanks!
