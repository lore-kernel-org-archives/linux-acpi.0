From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH 3/3] eeepc-laptop: Update the backlight state when we
	change brightness
Date: Wed, 15 Jul 2009 11:40:08 +0200
Message-ID: <71cd59b00907150240q22e8694el281cf862e71e1b66@mail.gmail.com>
References: <1247587564-27737-1-git-send-email-mjg@redhat.com>
	 <1247587564-27737-2-git-send-email-mjg@redhat.com>
	 <1247587564-27737-3-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:45511 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753219AbZGOJkM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jul 2009 05:40:12 -0400
In-Reply-To: <1247587564-27737-3-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, rpurdie@rpsys.net, lenb@kernel.org, rui.zhang@intel.com

On Tue, Jul 14, 2009 at 6:06 PM, Matthew Garrett<mjg@redhat.com> wrote:
> Trigger a status update when the user hits a brightness key, allowing
> userspace to present appropriate UI.
>
> Signed-off-by: Matthew Garrett <mjg@redhat.com>
> ---
> =A0drivers/platform/x86/eeepc-laptop.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x=
86/eeepc-laptop.c
> index ec560f1..fde86b3 100644
> --- a/drivers/platform/x86/eeepc-laptop.c
> +++ b/drivers/platform/x86/eeepc-laptop.c
> @@ -641,7 +641,7 @@ static int notify_brn(void)
> =A0 =A0 =A0 =A0struct backlight_device *bd =3D eeepc_backlight_device=
;
> =A0 =A0 =A0 =A0if (bd) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int old =3D bd->props.brightness;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bd->props.brightness =3D read_brightnes=
s(bd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 backlight_force_update(bd, BACKLIGHT_UP=
DATE_HOTKEY);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return old;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0return -1;
> --
> 1.6.2.5
>
>

This could be added to asus-laptop too. It doesn't handle brightness
changes right now (only backlight on/off) but it works the same way,
so it won't be hard to add. I'll do that as soon as your main patch is
merged.
Thanks,


--=20
Corentin Chary
http://xf.iksaif.net - http://uffs.org
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
