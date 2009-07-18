From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [RFT] hp-wmi: improved rfkill support for wifi
Date: Sat, 18 Jul 2009 23:37:49 +0200
Message-ID: <71cd59b00907181437l6ef362ejc345818a5197a6c4@mail.gmail.com>
References: <4A61FE7D.9080409@tuffmail.co.uk>
	 <8db1092f0907181155h3d603a17q11815b9f174ac333@mail.gmail.com>
	 <4A623490.50305@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f228.google.com ([209.85.218.228]:40000 "EHLO
	mail-bw0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753764AbZGRVhw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 18 Jul 2009 17:37:52 -0400
In-Reply-To: <4A623490.50305@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Maciej Rutecki <maciej.rutecki@gmail.com>, Matthew Garrett <mjg@redhat.com>, Frans Pop <elendil@planet.nl>, Larry Finger <Larry.Finger@lwfinger.net>, linux acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Sat, Jul 18, 2009 at 10:46 PM, Alan
Jenkins<alan-jenkins@tuffmail.co.uk> wrote:
> Maciej Rutecki wrote:
>> 2009/7/18 Alan Jenkins <alan-jenkins@tuffmail.co.uk>:
>>
>>> I borrowed a HP G7000 last week. =A0The hp-wmi driver seemed a bit
>>> confused about hard v.s. soft blocks on the wifi, so I fixed it bas=
ed on
>>> acpidump output [1]. =A0I hope this will work on other HP model num=
bers,
>>> but it would benefit from testing. =A0Any volunteers?
>>>
>>
>> HP/Compaq nx6310
>> 2.6.31-rc3+patch
>>
>> When is enabled by button:
>> root@gumis:/sys/class/rfkill# ls
>> rfkill0 =A0rfkill1 =A0rfkill2 =A0rfkill3
>> root@gumis:/sys/class/rfkill# cat rfkill*/name
>> phy0
>> hci0
>> hp-wifi
>> hp-bluetooth
>> root@gumis:/sys/class/rfkill# cat rfkill*/state
>> 1
>> 1
>> 1
>> 1
>>
>> When disabled by button:
>> root@gumis:/sys/class/rfkill# ls
>> rfkill0 =A0rfkill2 =A0rfkill3
>> root@gumis:/sys/class/rfkill# cat rfkill*/name
>> phy0
>> hp-wifi
>> hp-bluetooth
>> root@gumis:/sys/class/rfkill# cat rfkill*/state
>> 2
>> 1
>> 0
>>
>> I enable again by button:
>> root@gumis:/sys/class/rfkill# ls
>> rfkill0 =A0rfkill2 =A0rfkill3 =A0rfkill4
>> root@gumis:/sys/class/rfkill# cat rfkill*/name
>> phy0
>> hp-wifi
>> hp-bluetooth
>> hci0
>> root@gumis:/sys/class/rfkill# cat rfkill*/state
>> 1
>> 1
>> 1
>> 1
>>
>> I disable "by software" in Windows XP (bluetooth and wireless):
>> root@gumis:/sys/class/rfkill# ls
>> rfkill0 =A0rfkill1 =A0rfkill2 =A0rfkill3
>> root@gumis:/sys/class/rfkill# cat rfkill*/name
>> phy0
>> hp-wifi
>> hp-bluetooth
>> hci0
>> root@gumis:/sys/class/rfkill# cat rfkill*/state
>> 2
>> 0
>> 1
>> 1
>>
>> Bluetooth works fine when I back to Linux, it seems be enabled durin=
g
>> boot. Wireless is disabled. I cannot connect to network. So I
>> re-enable it in Windows:
>> root@gumis:/sys/class/rfkill# ls
>> rfkill0 =A0rfkill1 =A0rfkill2 =A0rfkill3
>> root@gumis:/sys/class/rfkill# cat rfkill*/name
>> phy0
>> hci0
>> hp-wifi
>> hp-bluetooth
>> root@gumis:/sys/class/rfkill# cat rfkill*/state
>> 1
>> 1
>> 1
>> 1
>>
>> Regards
>>
>
> Great detail! =A0That all fits with what I was expecting.
>
> Linux can also do enabling "by software". =A0At the moment, you need =
to
> download and compile a utility to poke /dev/rfkill. =A0I wouldn't bot=
her
> testing it, because I didn't change that bit :-).

Utility is here
http://git.sipsolutions.net/?p=3Drfkill.git
And a patch to restore write access to /sys/class/rfkill/*/state file i=
s here
http://lkml.org/lkml/2009/7/10/339


> I'll try extending this to bluetooth and wwan as Matthew suggested. =A0=
If
> you have time to run "acpidump" and send me the output, that would he=
lp
> me check the details.

I have an HP 8710p, so if you want acpidump and test on another
hardware, just ask :).

--=20
Corentin Chary
http://xf.iksaif.net - http://uffs.org
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
