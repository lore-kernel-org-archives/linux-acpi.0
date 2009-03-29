From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH] eeepc-laptop: fix wlan rfkill state change during init
Date: Sun, 29 Mar 2009 23:16:25 +0200
Message-ID: <71cd59b00903291416o4e8d6013n8a061098bb4fabef@mail.gmail.com>
References: <49CFADDF.4040007@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:45500 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752874AbZC2VQ2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 29 Mar 2009 17:16:28 -0400
Received: by bwz17 with SMTP id 17so1684972bwz.37
        for <linux-acpi@vger.kernel.org>; Sun, 29 Mar 2009 14:16:25 -0700 (PDT)
In-Reply-To: <49CFADDF.4040007@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: acpi4asus-user@lists.sourceforge.net, linux acpi <linux-acpi@vger.kernel.org>

On Sun, Mar 29, 2009 at 7:20 PM, Alan Jenkins
<alan-jenkins@tuffmail.co.uk> wrote:
> When an rfkill device is registered, the rfkill core will change its
> state to the system default. So we need to prepare for state changes
> *before* we register it. That means installing the eeepc-specific ACP=
I
> callback which handles the hotplug of the wireless network adaptor.
>
> This problem doesn't occur during normal operation. =A0You have to
>
> 1) Boot with wireless enabled. eeepc-laptop should load automatically=
=2E
> 2) modprobe -r eeepc-laptop
> 3) modprobe eeepc-laptop
>
> On boot, the default rfkill state will be set to enabled.
> With the current core code, step 2) will disable the wireless.
> Therefore in step 3), the wireless will change state during registrat=
ion,
> from disabled to enabled. =A0But without this fix, the PCI device for=
 the
> wireless adaptor will not appear.
>
> Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
>
> diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x=
86/eeepc-laptop.c
> index 786ed86..b8951b9 100644
> --- a/drivers/platform/x86/eeepc-laptop.c
> +++ b/drivers/platform/x86/eeepc-laptop.c
> @@ -645,6 +645,9 @@ static int eeepc_hotk_add(struct acpi_device *dev=
ice)
> =A0 =A0 =A0 =A0if (ACPI_FAILURE(status))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(EEEPC_ERR "Error installing not=
ify handler\n");
>
> + =A0 =A0 =A0 eeepc_register_rfkill_notifier("\\_SB.PCI0.P0P6");
> + =A0 =A0 =A0 eeepc_register_rfkill_notifier("\\_SB.PCI0.P0P7");
> +
> =A0 =A0 =A0 =A0if (get_acpi(CM_ASL_WLAN) !=3D -1) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ehotk->eeepc_wlan_rfkill =3D rfkill_al=
locate(&device->dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 RFKILL_TYPE_WLAN);
> @@ -700,9 +703,6 @@ static int eeepc_hotk_add(struct acpi_device *dev=
ice)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto bluetooth_fail;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 eeepc_register_rfkill_notifier("\\_SB.PCI0.P0P6");
> - =A0 =A0 =A0 eeepc_register_rfkill_notifier("\\_SB.PCI0.P0P7");
> -
> =A0 =A0 =A0 =A0return 0;
>
> =A0bluetooth_fail:
>
>
>

Hi,
Cc'd linux-acpi to get more review about that.
I'm not very familiar with rfkill interface.


--=20
Corentin Chary
http://xf.iksaif.net
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
