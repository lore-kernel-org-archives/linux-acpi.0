From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: eeepc-laptop: bugreport
Date: Thu, 26 Nov 2009 16:03:41 +0100
Message-ID: <71cd59b00911260703r284b5bfdn3144de4db74b7c3a@mail.gmail.com>
References: <cone.1258203372.445001.1633.1000@eeekiste>
	 <71cd59b00911140641i1502e95bt81d87db848feaf0@mail.gmail.com>
	 <cone.1258211472.464906.1633.1000@eeekiste>
	 <71cd59b00911150139i5d7377cawda04a17e5e50d05e@mail.gmail.com>
	 <cone.1258312767.545625.1812.1000@eeekiste>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vw0-f192.google.com ([209.85.212.192]:35508 "EHLO
	mail-vw0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760564AbZKZPDf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Nov 2009 10:03:35 -0500
Received: by vws30 with SMTP id 30so229666vws.33
        for <linux-acpi@vger.kernel.org>; Thu, 26 Nov 2009 07:03:41 -0800 (PST)
In-Reply-To: <cone.1258312767.545625.1812.1000@eeekiste>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: andrej.gelenberg@udo.edu
Cc: linux acpi <linux-acpi@vger.kernel.org>, acpi4asus-user@lists.sourceforge.net, Matthew Garrett <mjg@redhat.com>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>

On Sun, Nov 15, 2009 at 8:19 PM,  <andrej.gelenberg@udo.edu> wrote:
> Hi,
>
> Corentin Chary writes:
>
>> Hi,
>> We can't apply your patch as-is. But we need to fix that.
>>
>> Matthew, you added hotplug in commit
>> =A05740294ca3a9b113fe146f2826effb69ca50008d,
>> it was needed for 701/900/901. Do you know if it's still needed for =
1005ha
>> ?
>>
>> Thanks,
>>
>> --
>> Corentin Chary
>> http://xf.iksaif.net
>
> how about to make hotplug optional?
> http://bugzilla.kernel.org/show_bug.cgi?id=3D14570#c7
>
> Regards,
> Andrej
>
>

Hi,
Making hotplug optional won't fix the problem,
because this mean you need to ship a specific module for each Eeepc.

We need a more generic solution, and we need to implement a driver for
the new wmi interface.
I'll start to work on that as soon as I can get the hardware...
Thanks,


--=20
Corentin Chary
http://xf.iksaif.net
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
