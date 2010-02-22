From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH] eeepc-laptop: disable wireless hotplug for 1005PE
Date: Mon, 22 Feb 2010 15:09:21 +0100
Message-ID: <71cd59b01002220609i5c471b62x1d1d4dcecd53a93@mail.gmail.com>
References: <4B7FC140.60501@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f219.google.com ([209.85.220.219]:54446 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753286Ab0BVOJX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Feb 2010 09:09:23 -0500
In-Reply-To: <4B7FC140.60501@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, stable@kernel.org, Ansgar Burchardt <ansgar@43-1.org>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>

On Sat, Feb 20, 2010 at 12:02 PM, Alan Jenkins
<alan-jenkins@tuffmail.co.uk> wrote:
> The wireless hotplug code is not needed on this model, and it disable=
s
> the wired ethernet card. =A0(Like on the 1005HA and 1201N).
>
> References:
> <http://lists.alioth.debian.org/pipermail/debian-eeepc-devel/2010-Feb=
ruary/003281.html>
>
> Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
> Reported-by: Ansgar Burchardt <ansgar@43-1.org>
> CC: stable@kernel.org
> ---
> drivers/platform/x86/eeepc-laptop.c | =A0 =A03 ++-
> 1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/platform/x86/eeepc-laptop.c
> b/drivers/platform/x86/eeepc-laptop.c
> index e2be6bb..6a47bb7 100644
> --- a/drivers/platform/x86/eeepc-laptop.c
> +++ b/drivers/platform/x86/eeepc-laptop.c
> @@ -1277,7 +1277,8 @@ static void eeepc_dmi_check(struct eeepc_laptop
> *eeepc)
> =A0 =A0 =A0 =A0 * hotplug code. In fact, current hotplug code seems t=
o unplug
> another
> =A0 =A0 =A0 =A0 * device...
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 if (strcmp(model, "1005HA") =3D=3D 0 || strcmp(model, "=
1201N") =3D=3D 0) {
> + =A0 =A0 =A0 if (strcmp(model, "1005HA") =3D=3D 0 || strcmp(model, "=
1201N") =3D=3D 0 ||
> + =A0 =A0 =A0 =A0 =A0 strcmp(model, "1005PE") =3D=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0eeepc->hotplug_disabled =3D true;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_info("wlan hotplug disabled\n");
> =A0 =A0 =A0 =A0}
> --
> 1.6.3.3
>

Ack,

Len, is it still possible merge this patch in the next rc ?
Thanks,


--=20
Corentin Chary
http://xf.iksaif.net
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
