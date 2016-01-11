From: Tuan Phan <tphan@apm.com>
Subject: Re: [PATCH v3 1/2] acpi: Fix proper return code for function acpi_gsi_to_irq
Date: Mon, 11 Jan 2016 14:04:52 -0800
Message-ID: <CAGDN=zYa1r23EphdYQTFe2YXRhg_P-RDiaZVms9rdbFA3Y-x3g@mail.gmail.com>
References: <1446857519-5908-1-git-send-email-lho@apm.com> <1446857519-5908-2-git-send-email-lho@apm.com>
 <20160110110714.GA22896@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:36558 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760115AbcAKWFM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Jan 2016 17:05:12 -0500
Received: by mail-oi0-f54.google.com with SMTP id o124so51651867oia.3
        for <linux-acpi@vger.kernel.org>; Mon, 11 Jan 2016 14:05:12 -0800 (PST)
In-Reply-To: <20160110110714.GA22896@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Loc Ho <lho@apm.com>, dougthompson@xmission.com, mchehab@osg.samsung.com, tomasz.nowicki@linaro.org, fu.wei@linaro.org, rjw@rjwysocki.net, lenb@kernel.org, linux-edac@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Jon Masters <jcm@redhat.com>, patches@apm.com

On Sun, Jan 10, 2016 at 3:07 AM, Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Nov 06, 2015 at 05:51:58PM -0700, Loc Ho wrote:
> > The function acpi_gsi_to_irq should returns 0 on success as upper function
> > caller expect an 0 for sucesss.
> >
> > Signed-off-by: Tuan Phan <tphan@apm.com>
> > Signed-off-by: Loc Ho <lho@apm.com>
> > ---
> >  drivers/acpi/gsi.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/acpi/gsi.c b/drivers/acpi/gsi.c
> > index fa4585a..0ed1003 100644
> > --- a/drivers/acpi/gsi.c
> > +++ b/drivers/acpi/gsi.c
> > @@ -43,7 +43,7 @@ static unsigned int acpi_gsi_get_irq_type(int trigger, int polarity)
> >   *
> >   * irq location updated with irq value [>0 on success, 0 on failure]
> >   *
> > - * Returns: linux IRQ number on success (>0)
> > + * Returns: 0 on success
> >   *          -EINVAL on failure
> >   */
> >  int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
> > @@ -56,7 +56,7 @@ int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
> >        * *irq == 0 means no mapping, that should
> >        * be reported as a failure
> >        */
> > -     return (*irq > 0) ? *irq : -EINVAL;
> > +     return (*irq > 0) ? 0 : -EINVAL;
> >  }
> >  EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
>
> That function can be simplified. It should be made to return the irq
> number on success and 0 on failure. No need for that *irq output
> argument.
>
> --
> Regards/Gruss,
>     Boris.
>
> ECO tip #101: Trim your mails when you reply.

Hi Boris,
The same function which is implemented for x86
(arch/x86/kernel/acpi/boot.c) also returns 0 on success and -1 on
failure. If we need to change the API, need to change for X86 too
which we don't have a way to test it.

-- 
CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, is 
for the sole use of the intended recipient(s) and contains information that 
is confidential and proprietary to Applied Micro Circuits Corporation or 
its subsidiaries. It is to be used solely for the purpose of furthering the 
parties' business relationship. All unauthorized review, use, disclosure or 
distribution is prohibited. If you are not the intended recipient, please 
contact the sender by reply e-mail and destroy all copies of the original 
message.
