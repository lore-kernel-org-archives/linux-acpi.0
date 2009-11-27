From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: eeepc-laptop: bugreport
Date: Fri, 27 Nov 2009 21:43:45 +0100
Message-ID: <71cd59b00911271243i2515db26m3b19bd7c3572840@mail.gmail.com>
References: <71cd59b00911140641i1502e95bt81d87db848feaf0@mail.gmail.com>
	 <cone.1258312767.545625.1812.1000@eeekiste>
	 <71cd59b00911260703r284b5bfdn3144de4db74b7c3a@mail.gmail.com>
	 <cone.1259253925.112628.13921.1000@eeekiste>
	 <20091126164856.GA19208@srcf.ucam.org>
	 <cone.1259320879.557715.3035.1000@eeekiste>
	 <4B0FB7B9.9040902@tuffmail.co.uk>
	 <cone.1259324857.296100.3035.1000@eeekiste>
	 <20091127172522.GA5422@srcf.ucam.org>
	 <cone.1259353583.101492.2926.1000@eeekiste>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vw0-f197.google.com ([209.85.212.197]:36322 "EHLO
	mail-vw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003AbZK0Uvr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Nov 2009 15:51:47 -0500
Received: by vws35 with SMTP id 35so512355vws.4
        for <linux-acpi@vger.kernel.org>; Fri, 27 Nov 2009 12:51:53 -0800 (PST)
In-Reply-To: <cone.1259353583.101492.2926.1000@eeekiste>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: andrej.gelenberg@udo.edu
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, linux acpi <linux-acpi@vger.kernel.org>, acpi4asus-user@lists.sourceforge.net

On Fri, Nov 27, 2009 at 9:26 PM,  <andrej.gelenberg@udo.edu> wrote:
> Hi,
>
>
> from Documentation/rfkill.txt:
>
> =A01. Introduction
>
> =A0The rfkill subsystem provides a generic interface to disabling any=
 radio
> =A0transmitter in the system. When a transmitter is blocked, it shall=
 not
> =A0radiate any power.
>
> =A0The subsystem also provides the ability to react on button presses=
 and
> =A0disable all transmitters of a certain type (or all). This is inten=
ded for
> =A0situations where transmitters need to be turned off, for example o=
n
> =A0aircraft.
>
> =A0The rfkill subsystem has a concept of "hard" and "soft" block, whi=
ch
> =A0differ little in their meaning (block =3D=3D transmitters off) but=
 rather in
> =A0whether they can be changed or not:
> =A0- hard block: read-only radio block that cannot be overriden by so=
ftware
> =A0- soft block: writable radio block (need not be readable) that is =
set by
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0the system software.
>
> The eepc-latop-rfkill should be hard block.

The block can be overriden by software (that's what we do), so it's a
soft block.

> If the LED is not on,
> my wlan-card won't transmit. The eeepc-laptop is only driver
> which use hotplug-subsystem to hide the hardware.
> It work only until next pci-rescan.
> Firmware must not tell you, where the wlan-card is,
> it should only provide hard-rfkill (on 1005ha it does).
> Or the wlan-driver should provide proper rfkill
> (at least soft block).
> The hardcoded bus and slot it not proper solution.
>
> For example in miniPCI-pinout pin 13 is "RF Silent input",
> also the firmware shuld only set the pin.
> http://www.interfacebus.com/MiniPCI_Pinout_124Pin.html
>
> Matthew Garrett writes:
>
>> That's because the eee firmware gives us no control over which devic=
e is
>> unplugged. I think you're missing the point of how the eee rfkill co=
de works
>> - we don't unplug any devices, the firmware does that. We then need =
to tell
>> Linux that the PCI device has vanished in order to prevent drivers f=
rom
>> attempting to use a piece of hardware that's no longer accessible.
>
> eeepc firmware does not unplug device, it set only a rfkill-pin,
> so the wlan-card know, that it should not transmit any more.

Do you mean this is the case on all Eeepc or only on 1005h ?

Thanks;
--=20
Corentin Chary
http://xf.iksaif.net
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
