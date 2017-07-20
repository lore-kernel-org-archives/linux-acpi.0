From: Loc Ho <lho@apm.com>
Subject: Re: [PATCH 0/1] acpi: apei: Enable APEI multiple GHES source to share
 an single external IRQ
Date: Thu, 20 Jul 2017 10:49:08 -0700
Message-ID: <CAPw-ZTmSmgUA9udZh3iCHSiCrtU2J6fRk-98910BnvmjhiCimw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:36090 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750746AbdGTRtJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Jul 2017 13:49:09 -0400
Received: by mail-io0-f172.google.com with SMTP id q2so14309235ioe.3
        for <linux-acpi@vger.kernel.org>; Thu, 20 Jul 2017 10:49:09 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Salter <msalter@redhat.com>, bp@suse.de
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, tbaicar@codeaurora.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Borislav/Mark,

> On Wed, Jul 19, 2017 at 04:05:21PM -0400, Mark Salter wrote:
> > Yes, I should have included Boris. The last time this came up, Boris
> > said it was up to you. :)
> >
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/401772.html
>
> /me goes back and reads the old emails.
>
> So I had some issues with how acpi_gsi_to_irq() returns the irq number
> but that required more involved simplification and the submitter was
> unsurprisingly reluctant to do it.
>
> That's why it was Rafael's call.
>
> AFAIR.
>
> Also, from looking at the patches, the SOB chain is wrong:
>
> Signed-off-by: Tuan Phan <tphan@apm.com>
> Signed-off-by: Loc Ho <lho@apm.com>
>
> I don't know from that who's the author and who's the submitter.
> SubmittingPatches has more info on the whole deal.
>
> So please resubmit updated versions with issues addressed.

Tuan and I both worked on the APEI side for X-Gene and for this one,
we both sign off. If you required, I can re-post another version. Or
you can simple pull in v4 2/2 patch -
http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/400780.html

-Loc
