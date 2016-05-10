From: Alexey Klimov <alexey.klimov@arm.com>
Subject: Re: [PATCH v2] mailbox: pcc: Support HW-Reduced Communication
 Subspace Type 2
Date: Tue, 10 May 2016 11:34:06 +0100
Message-ID: <20160510103406.GA24079@arm.com>
References: <1462559914-28363-1-git-send-email-hotran@apm.com>
 <20160509094309.GA14006@arm.com>
 <CAFHUOYygKoHhwdNSRpOz_2bV2pfbtq=J0S6HKZSHW6pa16gBxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:43787 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751004AbcEJKeP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 May 2016 06:34:15 -0400
Content-Disposition: inline
In-Reply-To: <CAFHUOYygKoHhwdNSRpOz_2bV2pfbtq=J0S6HKZSHW6pa16gBxA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hoan Tran <hotran@apm.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Loc Ho <lho@apm.com>, Duc Dang <dhdang@apm.com>

On Mon, May 09, 2016 at 10:38:24AM -0700, Hoan Tran wrote:
> Hi Alexey,
> 
> On Mon, May 9, 2016 at 2:43 AM, Alexey Klimov <alexey.klimov@arm.com> wrote:
> > Hi Hoan,
> >
> > On Fri, May 06, 2016 at 11:38:34AM -0700, Hoan Tran wrote:
> >> From: hotran <hotran@apm.com>
> >>
> >> ACPI 6.1 has a PCC HW-Reduced Communication Subspace Type 2 intended for
> >> use on HW-Reduce ACPI Platform, which requires read-modify-write sequence
> >> to acknowledge doorbell interrupt. This patch provides the implementation
> >> for the Communication Subspace Type 2.
> >>
> >> This patch depends on patch [1] which supports PCC subspace type 2 header
> >> [1] https://lkml.org/lkml/2016/5/5/14
> >>  - [PATCH v2 03/13] ACPICA: ACPI 6.1: Support for new PCCT subtable
> >
> > So you finally decided to use separate structure declaration for type 2. Good.
> >
> >> v2
> >>  * Remove changes inside "actbl3.h". This file is taken care by ACPICA.
> >>  * Parse both subspace type 1 and subspace type 2
> >>  * Remove unnecessary variable initialization
> >>  * ISR returns IRQ_NONE in case of error
> >>
> >> v1
> >>  * Initial
> >>
> >> Signed-off-by: Hoan Tran <hotran@apm.com>
> >> ---
> >>  drivers/mailbox/pcc.c | 395 +++++++++++++++++++++++++++++++++++++-------------
> >>  1 file changed, 296 insertions(+), 99 deletions(-)
> >>
> >> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> >> index 043828d..58c9a67 100644
> >> --- a/drivers/mailbox/pcc.c
> >> +++ b/drivers/mailbox/pcc.c
> >> @@ -59,6 +59,7 @@
> >>  #include <linux/delay.h>
> >>  #include <linux/io.h>
> >>  #include <linux/init.h>
> >
> > [...]
> >
> >> @@ -307,6 +440,43 @@ static int parse_pcc_subspace(struct acpi_subtable_header *header,
> >>  }
> >>
> >>  /**
> >> + * pcc_parse_subspace_irq - Parse the PCC IRQ and PCC ACK register
> >> + *           There should be one entry per PCC client.
> >> + * @mbox_chans: Pointer to the PCC mailbox channel data
> >> + * @pcct_ss: Pointer to the ACPI subtable header under the PCCT.
> >> + *
> >> + * Return: 0 for Success, else errno.
> >> + *
> >> + * This gets called for each entry in the PCC table.
> >> + */
> >> +static int pcc_parse_subspace_irq(struct pcc_mbox_chan *mbox_chans,
> >> +             struct acpi_pcct_hw_reduced *pcct_ss)
> >> +{
> >> +     mbox_chans->irq = pcc_map_interrupt(pcct_ss->doorbell_interrupt,
> >> +                                         (u32)pcct_ss->flags);
> >> +     if (mbox_chans->irq <= 0) {
> >> +             pr_err("PCC GSI %d not registered\n",
> >> +                    pcct_ss->doorbell_interrupt);
> >> +             return -EINVAL;
> >> +     }
> >> +
> >> +     if (pcct_ss->header.type
> >> +             == ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2) {
> >> +             struct acpi_pcct_hw_reduced_type2 *pcct2_ss = (void *)pcct_ss;
> >> +
> >> +             mbox_chans->pcc_doorbell_ack_vaddr = acpi_os_ioremap(
> >> +                             pcct2_ss->doorbell_ack_register.address,
> >> +                             pcct2_ss->doorbell_ack_register.bit_width / 8);
> >> +             if (!mbox_chans->pcc_doorbell_ack_vaddr) {
> >> +                     pr_err("Failed to ioremap PCC ACK register\n");
> >> +                     return -ENOMEM;
> >> +             }
> >> +     }
> >> +
> >> +     return 0;
> >> +}
> >> +
> >> +/**
> >>   * acpi_pcc_probe - Parse the ACPI tree for the PCCT.
> >>   *
> >>   * Return: 0 for Success, else errno.
> >> @@ -316,7 +486,8 @@ static int __init acpi_pcc_probe(void)
> >>       acpi_size pcct_tbl_header_size;
> >>       struct acpi_table_header *pcct_tbl;
> >>       struct acpi_subtable_header *pcct_entry;
> >> -     int count, i;
> >> +     struct acpi_table_pcct *acpi_pcct_tbl;
> >> +     int count, i, rc;
> >>       acpi_status status = AE_OK;
> >>
> >>       /* Search for PCCT */
> >> @@ -334,22 +505,28 @@ static int __init acpi_pcc_probe(void)
> >>                       ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE,
> >>                       parse_pcc_subspace, MAX_PCC_SUBSPACES);
> >>
> >> +     count += acpi_table_parse_entries(ACPI_SIG_PCCT,
> >> +                     sizeof(struct acpi_table_pcct),
> >> +                     ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2,
> >> +                     parse_pcc_subspace, MAX_PCC_SUBSPACES);
> >> +
> >>       if (count <= 0) {
> >>               pr_err("Error parsing PCC subspaces from PCCT\n");
> >>               return -EINVAL;
> >>       }
> >
> > Looks like after first call to acpi_table_parse_entries() you may have negative
> > number in count. And then you add counted number of type 2 subtables to count variable.
> >
> > I am not aware how pedantic this all should be but you may have more than MAX_PCC_SUBSPACES
> > subspaces or don't probe any subspaces at all with such approach. Or other side effects.
> I should check the "count" at first call acpi_table_parse_entries().
> If "count < 0", assign count=0, then call the next
> acpi_table_parse_entries().
> 
> Thanks for your review
> -Hoan

That second call to acpi_table_parse_entries() might overwrite count with negative number again.

What about the following below?

int count;
int sum = 0;

count = acpi_table_parse_entries(type1);
sum += count >= 0 ? count : 0;

count = acpi_table_parse_entries(type2);
sum += count >= 0 ? count : 0;

if (sum <= 0 || sum >= MAX_PCC_SUBSPACES) {
	pr_err();
	return -ENODEV;
}

It's possible that I overlooked some corner case.
BTW, zero number of subspaces here doesn't indicate error actually (that's probably not the scope of this change).

Best regards,
Alexey

