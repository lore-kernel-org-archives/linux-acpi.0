From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: eeepc-laptop: bugreport
Date: Mon, 7 Dec 2009 22:23:39 +0100
Message-ID: <71cd59b00912071323p58626576y3a9538b375f95861@mail.gmail.com>
References: <71cd59b00911150139i5d7377cawda04a17e5e50d05e@mail.gmail.com>
	 <71cd59b00911260703r284b5bfdn3144de4db74b7c3a@mail.gmail.com>
	 <cone.1259253925.112628.13921.1000@eeekiste>
	 <20091126164856.GA19208@srcf.ucam.org>
	 <cone.1259320879.557715.3035.1000@eeekiste>
	 <4B0FB7B9.9040902@tuffmail.co.uk>
	 <cone.1259324857.296100.3035.1000@eeekiste>
	 <20091127172522.GA5422@srcf.ucam.org>
	 <cone.1259353583.101492.2926.1000@eeekiste>
	 <20091127215815.GA9173@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vw0-f197.google.com ([209.85.212.197]:51458 "EHLO
	mail-vw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935596AbZLGVXh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Dec 2009 16:23:37 -0500
Received: by vws35 with SMTP id 35so2192440vws.4
        for <linux-acpi@vger.kernel.org>; Mon, 07 Dec 2009 13:23:39 -0800 (PST)
In-Reply-To: <20091127215815.GA9173@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: andrej.gelenberg@udo.edu, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, linux acpi <linux-acpi@vger.kernel.org>, acpi4asus-user@lists.sourceforge.net

On Fri, Nov 27, 2009 at 10:58 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Fri, Nov 27, 2009 at 09:26:23PM +0100, andrej.gelenberg@udo.edu wrote:
>
>> The eepc-latop-rfkill should be hard block. If the LED is not on,
>> my wlan-card won't transmit. The eeepc-laptop is only driver
>> which use hotplug-subsystem to hide the hardware.
>
> No. The *hardware* disables the PCI device, at which point all reads
> return errors and drivers fall over. The eeepc-laptop driver then hides
> the device because it's no longer there.
>
> Now, it's entirely possible that this behaviour is no longer present on
> the 1005h. That's fine, and it necessitates changing the behaviour of
> the driver. But it's not a reason for removing the functionality
> entirely, because the 700s, 900s and earlier 1000 series *do* require
> that PCI hotplugging be peformed.
>
> (Well. There's a separate situation where the PCI runtime power
> management code is going to interfere with the way eeepc-laptop does
> things, and this functionality is going to need to be added to the PCI
> core and removed from eeepc-laptop)

Matthew, do you think that we could skip the hotplug code when all
rfkill notifier (_SB.PCI0.P0P[5,6,7]) fail to register ?

This should work at least for 1005ha.

-- 
Corentin Chary
http://xf.iksaif.net
