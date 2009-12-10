From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH] asus-laptop: change light sens default values.
Date: Thu, 10 Dec 2009 08:16:12 +0100
Message-ID: <71cd59b00912092316r31228507hc34cbffe98031c56@mail.gmail.com>
References: <1260219950-28577-1-git-send-email-corentincj@iksaif.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qy0-f202.google.com ([209.85.221.202]:59171 "EHLO
	mail-qy0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760550AbZLJHWV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Dec 2009 02:22:21 -0500
Received: by qyk40 with SMTP id 40so3578658qyk.22
        for <linux-acpi@vger.kernel.org>; Wed, 09 Dec 2009 23:22:26 -0800 (PST)
In-Reply-To: <1260219950-28577-1-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Corentin Chary <corentincj@iksaif.net>, stable@kernel.org, Thomas Renninger <trenn@suse.de>, =?ISO-8859-1?Q?Peter_K=FCppers?= <peter-mailbox@web.de>, Michael Franzl <michaelfranzl@gmx.at>, Ian Turner <vectro@vectro.org>

Hi Len,
please don't forget that one (it is easy to do so as it is not part of
the last series).
Thanks,

On Mon, Dec 7, 2009 at 10:05 PM, Corentin Chary <corentincj@iksaif.net>=
 wrote:
> The light sensor disable brightness key and
> /sys/class/backlight/ control. There was a lot of report
> from users who didn't understand why they couldn't change their
> brightness, including:
> * https://bugs.launchpad.net/bugs/222171
> * https://bugzilla.novell.com/show_bug.cgi?id=3D514747
> * http://bugzilla.kernel.org/show_bug.cgi?id=3D13671
>
> Now the light sensor is disabled, and if the user want to enable
> it, the level should be ok.
>
> The funny thing is that comments where ok, not code.
>
> Cc: stable@kernel.org
> Cc: Thomas Renninger <trenn@suse.de>
> Cc: Peter K=FCppers <peter-mailbox@web.de>
> Cc: Michael Franzl <michaelfranzl@gmx.at>
> Cc: Ian Turner <vectro@vectro.org>
> Signed-off-by: Corentin Chary <corentincj@iksaif.net>
> ---
> =A0drivers/platform/x86/asus-laptop.c | =A0 =A04 ++--
> =A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x8=
6/asus-laptop.c
> index b39d2bb..849359a 100644
> --- a/drivers/platform/x86/asus-laptop.c
> +++ b/drivers/platform/x86/asus-laptop.c
> @@ -1283,8 +1283,8 @@ static int asus_hotk_add(struct acpi_device *de=
vice)
> =A0 =A0 =A0 =A0hotk->ledd_status =3D 0xFFF;
>
> =A0 =A0 =A0 =A0/* Set initial values of light sensor and level */
> - =A0 =A0 =A0 hotk->light_switch =3D 1; /* Default to light sensor di=
sabled */
> - =A0 =A0 =A0 hotk->light_level =3D 0; =A0/* level 5 for sensor sensi=
tivity */
> + =A0 =A0 =A0 hotk->light_switch =3D 0; /* Default to light sensor di=
sabled */
> + =A0 =A0 =A0 hotk->light_level =3D 5; =A0/* level 5 for sensor sensi=
tivity */
>
> =A0 =A0 =A0 =A0if (ls_switch_handle)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_light_sens_switch(hotk->light_swit=
ch);
> --
> 1.6.5.4
>
>



--=20
Corentin Chary
http://xf.iksaif.net
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
