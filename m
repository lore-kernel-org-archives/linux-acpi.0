From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RESEND PATCH 1/2] Fix two minor bugs in cper.c.
Date: Mon, 13 Feb 2012 13:50:56 -0800
Message-ID: <CAErSpo4O8stRdBSsOKZbYVTbnY1Dkmtbn-xC6zV1F31-ony3-g@mail.gmail.com>
References: <1329148335-30534-1-git-send-email-jiang.liu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:45382 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754236Ab2BMVvR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Feb 2012 16:51:17 -0500
Received: by werb13 with SMTP id b13so3776850wer.19
        for <linux-acpi@vger.kernel.org>; Mon, 13 Feb 2012 13:51:16 -0800 (PST)
In-Reply-To: <1329148335-30534-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiang Liu <liuj97@gmail.com>
Cc: Len Brown <lenb@kernel.org>, Huang Ying <ying.huang@intel.com>, Tony Luck <tony.luck@intel.com>, Chen Gong <gong.chen@linux.intel.com>, Jiang Liu <jiang.liu@huawei.com>, linux-acpi@vger.kernel.org

On Mon, Feb 13, 2012 at 7:52 AM, Jiang Liu <liuj97@gmail.com> wrote:
> The function apei_estatus_print() and apei_estatus_check() forget to =
move ahead
> the gdata pointer when dealing with multiple generic error data secti=
ons.
>
> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
> ---
> =A0drivers/acpi/apei/cper.c | =A0 =A02 ++
> =A01 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/acpi/apei/cper.c b/drivers/acpi/apei/cper.c
> index 5d41894..e6defd8 100644
> --- a/drivers/acpi/apei/cper.c
> +++ b/drivers/acpi/apei/cper.c
> @@ -362,6 +362,7 @@ void apei_estatus_print(const char *pfx,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gedata_len =3D gdata->error_data_lengt=
h;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0apei_estatus_print_section(pfx, gdata,=
 sec_no);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data_len -=3D gedata_len + sizeof(*gda=
ta);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gdata =3D (void *)(gdata + 1) + gedata_=
len;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sec_no++;
> =A0 =A0 =A0 =A0}
> =A0}
> @@ -396,6 +397,7 @@ int apei_estatus_check(const struct acpi_hest_gen=
eric_status *estatus)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (gedata_len > data_len - sizeof(*gd=
ata))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data_len -=3D gedata_len + sizeof(*gda=
ta);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gdata =3D (void *)(gdata + 1) + gedata_=
len;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0if (data_len)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> --

Thanks for splitting this into separate patches.  While you're at it,
please make the subject lines specific and meaningful.  "Fix bug" is
not useful to someone examining the changelogs looking for a specific
issue or deciding whether the change needs to be backported into a
distro.

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
