From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH] mailbox: pcc: Don't access an unmapped memory address space
Date: Wed, 6 Apr 2016 18:14:17 -0400
Message-ID: <CAJ5Y-eb6DJLf=RKTYUhK62c=MEt8hqaChdqCczuxpee3CXu_gw@mail.gmail.com>
References: <1459964964-16934-1-git-send-email-shankerd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:34940 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753494AbcDFWOk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Apr 2016 18:14:40 -0400
Received: by mail-lf0-f43.google.com with SMTP id c126so44020002lfb.2
        for <linux-acpi@vger.kernel.org>; Wed, 06 Apr 2016 15:14:39 -0700 (PDT)
In-Reply-To: <1459964964-16934-1-git-send-email-shankerd@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shanker Donthineni <shankerd@codeaurora.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>, linaro-acpi <linaro-acpi@lists.linaro.org>, Prashanth Prakash <pprakash@codeaurora.org>

On 6 April 2016 at 13:49, Shanker Donthineni <shankerd@codeaurora.org> wrote:
> The acpi_pcc_probe() is accessing memory outside of the PCCT table

NIT: s/is/could end up

> space causing the kernel panic(). Increment the pcct_entry pointer
> after parsing 'HW-reduced Communications Subspace' to fix the
> problem. This change also enables the parsing of subtable at index 0.
>
> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>

Thanks for catching this. Looks like this slipped through in the PCC
doorbell optimization patch.

Acked-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>

> ---
>  drivers/mailbox/pcc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 0ddf638..043828d 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -361,8 +361,6 @@ static int __init acpi_pcc_probe(void)
>                 struct acpi_generic_address *db_reg;
>                 struct acpi_pcct_hw_reduced *pcct_ss;
>                 pcc_mbox_channels[i].con_priv = pcct_entry;
> -               pcct_entry = (struct acpi_subtable_header *)
> -                       ((unsigned long) pcct_entry + pcct_entry->length);
>
>                 /* If doorbell is in system memory cache the virt address */
>                 pcct_ss = (struct acpi_pcct_hw_reduced *)pcct_entry;
> @@ -370,6 +368,8 @@ static int __init acpi_pcc_probe(void)
>                 if (db_reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
>                         pcc_doorbell_vaddr[i] = acpi_os_ioremap(db_reg->address,
>                                                         db_reg->bit_width/8);
> +               pcct_entry = (struct acpi_subtable_header *)
> +                       ((unsigned long) pcct_entry + pcct_entry->length);
>         }
>
>         pcc_mbox_ctrl.num_chans = count;
> --
> Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
