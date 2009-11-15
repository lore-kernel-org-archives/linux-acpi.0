From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: eeepc-laptop: bugreport
Date: Sun, 15 Nov 2009 10:39:22 +0100
Message-ID: <71cd59b00911150139i5d7377cawda04a17e5e50d05e@mail.gmail.com>
References: <cone.1258203372.445001.1633.1000@eeekiste>
	 <71cd59b00911140641i1502e95bt81d87db848feaf0@mail.gmail.com>
	 <cone.1258211472.464906.1633.1000@eeekiste>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:51529 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910AbZKOJjS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Nov 2009 04:39:18 -0500
Received: by pwi3 with SMTP id 3so2752821pwi.21
        for <linux-acpi@vger.kernel.org>; Sun, 15 Nov 2009 01:39:23 -0800 (PST)
In-Reply-To: <cone.1258211472.464906.1633.1000@eeekiste>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: andrej.gelenberg@udo.edu
Cc: linux acpi <linux-acpi@vger.kernel.org>, acpi4asus-user@lists.sourceforge.net, Matthew Garrett <mjg@redhat.com>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>

> Corentin Chary writes:
>> On Sat, Nov 14, 2009 at 1:56 PM, =A0<andrej.gelenberg@udo.edu> wrote=
:
>>>
>>> Hi,
>>>
>>> please see my bugreport on http://bugzilla.kernel.org:
>>> http://bugzilla.kernel.org/show_bug.cgi?id=3D14570
>>>
>>> I have posted a patch there too.
>>>
>>> Regards,
>>> Andrej Gelenberg
>>>
>>
>> Hi,
>> Did you test it on a newer 2.6.32-rc kernel ? The bug is still
>> reproductible ?
>> Thanks
>>
> Hi,
>
> i haven't tstes it on 32, but i tried to apply all patches for
> eeepc-laptop from 32 and next branches. As i can see, the pci-bus
> and pci-slot are still hardcoded and it will turn off my atl1c ethern=
et card
> and not my wlan-card.
>
> Hotplug in eeepc should not be where. Rfkill work fine
> without that and it make not much sense: after pci-rescan
> (echo 1 > /sys/bus/pci/rescan) is device there.
> In fakehotplug-driver is written, that there are no extra
> powersaving-benefit.
>
> Regard,
> Andrej Gelenberg
>

Hi,
We can't apply your patch as-is. But we need to fix that.

Matthew, you added hotplug in commit  5740294ca3a9b113fe146f2826effb69c=
a50008d,
it was needed for 701/900/901. Do you know if it's still needed for 100=
5ha ?

Thanks,

--=20
Corentin Chary
http://xf.iksaif.net
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
