From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH] eeepc-laptop: disable pci hotplug code when all notifiers
	fail to load
Date: Wed, 16 Dec 2009 11:58:39 +0100
Message-ID: <71cd59b00912160258m35038f27j2862315826149c8d@mail.gmail.com>
References: <20091207212848.GA9171@srcf.ucam.org>
	 <1260738971-25456-1-git-send-email-corentincj@iksaif.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vw0-f192.google.com ([209.85.212.192]:63257 "EHLO
	mail-vw0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755556AbZLPK6l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 05:58:41 -0500
Received: by vws30 with SMTP id 30so261065vws.33
        for <linux-acpi@vger.kernel.org>; Wed, 16 Dec 2009 02:58:40 -0800 (PST)
In-Reply-To: <1260738971-25456-1-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, linux acpi <linux-acpi@vger.kernel.org>, acpi4asus-user@lists.sourceforge.net, Corentin Chary <corentincj@iksaif.net>, andrej.gelenberg@udo.edu

Hi Len,
Please merge this patch too, I forgot so send it to you earlier.
Thanks,


On Sun, Dec 13, 2009 at 10:16 PM, Corentin Chary <corentincj@iksaif.net=
> wrote:
> This is a short term workaround for Eeepc 1005HA.
>
> refs: <http://bugzilla.kernel.org/show_bug.cgi?id=3D14570>
>
> Signed-off-by: Corentin Chary <corentincj@iksaif.net>
> ---
> =A0drivers/platform/x86/eeepc-laptop.c | =A0 17 +++++++++++++----
> =A01 files changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x=
86/eeepc-laptop.c
> index 356ca11..45c3f52 100644
> --- a/drivers/platform/x86/eeepc-laptop.c
> +++ b/drivers/platform/x86/eeepc-laptop.c
> @@ -177,6 +177,7 @@ struct eeepc_laptop {
>
> =A0 =A0 =A0 =A0struct hotplug_slot *hotplug_slot;
> =A0 =A0 =A0 =A0struct mutex hotplug_lock;
> + =A0 =A0 =A0 bool hotplug_enabled;
>
> =A0 =A0 =A0 =A0struct led_classdev tpd_led;
> =A0 =A0 =A0 =A0int tpd_led_wk;
> @@ -642,6 +643,7 @@ static int eeepc_register_rfkill_notifier(struct =
eeepc_laptop *eeepc,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 eeepc);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ACPI_FAILURE(status))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_warning("Failed to =
register notify on %s\n", node);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 eeepc->hotplug_enabled =3D true;
> =A0 =A0 =A0 =A0} else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
>
> @@ -845,7 +847,17 @@ static int eeepc_rfkill_init(struct eeepc_laptop=
 *eeepc)
> =A0 =A0 =A0 =A0if (result && result !=3D -ENODEV)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto exit;
>
> - =A0 =A0 =A0 result =3D eeepc_setup_pci_hotplug(eeepc);
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Register notifiers first, if they all fail, we won=
't enable
> + =A0 =A0 =A0 =A0* pci hotplug because it's probably not needed for t=
his model
> + =A0 =A0 =A0 =A0* (eg: 1005HA)
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 eeepc_register_rfkill_notifier(eeepc, "\\_SB.PCI0.P0P5"=
);
> + =A0 =A0 =A0 eeepc_register_rfkill_notifier(eeepc, "\\_SB.PCI0.P0P6"=
);
> + =A0 =A0 =A0 eeepc_register_rfkill_notifier(eeepc, "\\_SB.PCI0.P0P7"=
);
> +
> + =A0 =A0 =A0 if (eeepc->hotplug_enabled)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =3D eeepc_setup_pci_hotplug(eeep=
c);
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * If we get -EBUSY then something else is handling th=
e PCI hotplug -
> =A0 =A0 =A0 =A0 * don't fail in this case
> @@ -853,9 +865,6 @@ static int eeepc_rfkill_init(struct eeepc_laptop =
*eeepc)
> =A0 =A0 =A0 =A0if (result =3D=3D -EBUSY)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0result =3D 0;
>
> - =A0 =A0 =A0 eeepc_register_rfkill_notifier(eeepc, "\\_SB.PCI0.P0P5"=
);
> - =A0 =A0 =A0 eeepc_register_rfkill_notifier(eeepc, "\\_SB.PCI0.P0P6"=
);
> - =A0 =A0 =A0 eeepc_register_rfkill_notifier(eeepc, "\\_SB.PCI0.P0P7"=
);
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Refresh pci hotplug in case the rfkill state was ch=
anged during
> =A0 =A0 =A0 =A0 * setup.
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
