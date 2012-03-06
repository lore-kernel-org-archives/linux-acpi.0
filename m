From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RESEND PATCH v3] Fix a copy & paste error in erst.c.
Date: Tue, 6 Mar 2012 09:55:09 -0700
Message-ID: <CAErSpo4svRTqJcRAUaEwykQ_d1-ONpXW0m9x6aAMM2_i4XF52g@mail.gmail.com>
References: <1331051359-21539-1-git-send-email-jiang.liu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:41009 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755697Ab2CFQzb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 6 Mar 2012 11:55:31 -0500
Received: by lahj13 with SMTP id j13so6229043lah.19
        for <linux-acpi@vger.kernel.org>; Tue, 06 Mar 2012 08:55:29 -0800 (PST)
In-Reply-To: <1331051359-21539-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiang Liu <liuj97@gmail.com>
Cc: Len Brown <lenb@kernel.org>, Huang Ying <ying.huang@intel.com>, Jiang Liu <jiang.liu@huawei.com>, linux-acpi@vger.kernel.org

On Tue, Mar 6, 2012 at 9:29 AM, Jiang Liu <liuj97@gmail.com> wrote:
> This patch fixes a copy & paste error in erst.c and it applies
> to v3.3-rc6.

It'd be nice if the subject line gave a hint about what sort of
problem this patch fixes.  It doesn't matter *how* the original error
was made; it's a question of what behavior we're changing.

Distro and stable kernel maintainers have to decide whether this is
important enough to be backported, and "fix copy & paste error"
doesn't tell them anything useful.

Maybe something like:

    ACPI, APEI, Fix ERST header length check

    This fixes the ERST header length check.  Without this patch, we
    mistakenly ignore the ERST table, and hardware errors can't be save=
d
    in the persistent store.


> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
> Acked-by: Huang Ying <ying.huang@intel.com>
> ---
> =A0drivers/acpi/apei/erst.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
> index eb9fab5..e4d9d24 100644
> --- a/drivers/acpi/apei/erst.c
> +++ b/drivers/acpi/apei/erst.c
> @@ -917,7 +917,7 @@ static int erst_check_table(struct acpi_table_ers=
t *erst_tab)
> =A0{
> =A0 =A0 =A0 =A0if ((erst_tab->header_length !=3D
> =A0 =A0 =A0 =A0 =A0 =A0 (sizeof(struct acpi_table_erst) - sizeof(erst=
_tab->header)))
> - =A0 =A0 =A0 =A0 =A0 && (erst_tab->header_length !=3D sizeof(struct =
acpi_table_einj)))
> + =A0 =A0 =A0 =A0 =A0 && (erst_tab->header_length !=3D sizeof(struct =
acpi_table_erst)))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0if (erst_tab->header.length < sizeof(struct acpi_table=
_erst))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
