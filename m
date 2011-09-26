From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: [PATCH] ACPI: check mutex release status
Date: Mon, 26 Sep 2011 20:59:19 +0800
Message-ID: <CAF1ivSbXwb59WjySLrv6ZobqA_H7Jrf8Cq0c3exvVYH69QmKkw@mail.gmail.com>
References: <1317037184.2697.1.camel@offbook>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:62810 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135Ab1IZM7U convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Sep 2011 08:59:20 -0400
In-Reply-To: <1317037184.2697.1.camel@offbook>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: dave@gnu.org
Cc: Len Brown <lenb@kernel.org>, lkml <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

On Mon, Sep 26, 2011 at 7:39 PM, Davidlohr Bueso <dave@gnu.org> wrote:
> From: Davidlohr Bueso <dave@gnu.org>
>
> If this is not done we have a bogus ACPI_FAILURE() call.
>
> Signed-off-by: Davidlohr Bueso <dave@gnu.org>
> ---
> =A0drivers/acpi/acpica/nsload.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/acpi/acpica/nsload.c b/drivers/acpi/acpica/nsloa=
d.c
> index 5f7dc69..f3070fd 100644
> --- a/drivers/acpi/acpica/nsload.c
> +++ b/drivers/acpi/acpica/nsload.c
> @@ -115,7 +115,7 @@ acpi_ns_load_table(u32 table_index, struct acpi_n=
amespace_node *node)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 unlock:
> - =A0 =A0 =A0 (void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
> + =A0 =A0 =A0 status =3D acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);

No,

The status maybe set before the "goto unlock" statement.

Lin Ming

>
> =A0 =A0 =A0 =A0if (ACPI_FAILURE(status)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return_ACPI_STATUS(status);
> --
> 1.7.4.1
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
