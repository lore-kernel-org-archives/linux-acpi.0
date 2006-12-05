From: Rodney Cacy <cacy-rodney-cacy@tlen.pl>
Subject: Re: understanding acpi
Date: Tue, 05 Dec 2006 12:14:04 +0100
Message-ID: <4575547C.6000909@tlen.pl>
References: <456EB894.20306@imag.fr> <45741364.5040308@tlen.pl> <45742ECD.6090203@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from d1.imc.pcz.czest.pl ([212.87.226.194]:2153 "HELO
	d1.imc.pcz.czest.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S967459AbWLELLU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Dec 2006 06:11:20 -0500
In-Reply-To: <45742ECD.6090203@imag.fr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Oliver.Henriot@imag.fr

You try to break rules and it is not easy so I do not expect that there=
=20
is another mailing list where you find an easy answer for your question=
=2E
In my opinion the acpid is not the right way. It is only for catching=20
acpi events and then run scripts. Using it you can be informed that the=
=20
processor changes state from c3->c2 and then you can react for the=20
information by running an application but there is no one which revert=20
the change (it is to force the processor to change state from c2->c3)=20
because the kernel is only the one that can do that. It is a question=20
for me why the battery presence allows the c3 state whilst without it=20
only c2 is possible. I do not know, really.
I think that the simplest way to deal with the noise reduction could by=
=20
thermal management. Why? I guess the working fan generate the noisy=20
sound :) so let turn it be on less frequently.
=46orgot about the "c" states - it is to difficult. For thermal managem=
ent=20
is an easy interface in /proc/acpi/thermal_zone. Read about it in the
http://www.columbia.edu/~ariel/acpi/acpi_howto.txt, section 8. If it is=
=20
too difficult to understand ask about it in other forum (maybe=20
LinuxQuestions.org) and read, read, read...

Cheers

Oliver Henriot wrote:
> Hi,
>=20
> Rodney Cacy a =E9crit :
>=20
>> I'm not an expert but you can pass a boot kernel option:
>>
>> processor.max_cstate
>=20
> Yes, I'd actually tried setting processor.max_cstate=3D4 a while ago =
to=20
> see if this changed anything and indeed, instead of reading
> max_cstate : C8
> from /proc/acpi/processor/CPU0/power as I usually get, I got
> max_cstate : C4
> Obivious, and no good either, unfortunately. I still ran at C2 on mai=
ns=20
> and C3 on battery.
> I suspect my settings in /etc/acpi are not good and I'm looking for a=
=20
> fine manual I could rtfm in order to understand what I should doo to=20
> fine tune acpi on my machine. Where I'm stuck is to find the fine man=
ual=20
> which I'll actually understand (I may not be very smart... ;-) ) and=20
> manage to put into application.
>=20
>> More inforamtion in=20
>> http://www.columbia.edu/~ariel/acpi/acpi_howto.txt, section 7.
>=20
> Yes, I'm actually trying to understand sections 6.3 through 6.6 of th=
at=20
> same document, which I suspect are precisely what I'm looking for and=
=20
> also point at /etc/acpi. My relatively limited skills are preventing =
me=20
> from getting any further at the moment, but I am confident I will=20
> eventually make something of it.
>=20
>> Write me about the results. Now I'm working under suspending sound,l=
an=20
>> etc. to save battery but soon I will work with the noise reduction.
>>
>> Cacy
>=20
>=20
> Cheers,
>=20
> P.S. considering the level of other discussions on this list, I suspe=
ct=20
> I have pointed my questions to the wrong place. Question : is there a=
=20
> noob oriented discussion list for acpi? Anyway, sorry for the list=20
> pollution with such "low level" questions.
>=20
>>
>>
>> Oliver Henriot wrote:
>>
>>> Hi all list subscribers,
>>>
>>> I'm looking for info on how acpi functions in order to get it to wo=
rk=20
>>> the best possible on my computer. It's a Sony laptop (vaio=20
>>> vgn-sz3xp/c, core2duo) running Debian Etch. In particular, I'm=20
>>> looking for ways to reduce thermal dissipation from the CPU as much=
=20
>>> as possible, in order to queep the machine as quiet as possible. Fr=
om=20
>>> the various docs I've read, so far I seem to understand that C-stat=
es=20
>>> is the way to go, throttling being probably not very efficient.
>>>
>>> When I'm running on batteries, C3 state is active (as shown by cat=20
>>> /prc/acpi/processor/CPU0/power) and is the main state, whereas when=
=20
>>> I'm running on mains, C3 disappears and only C1 and C2 remain.
>>>
>>> My question are : wouldn't it be better if I could use C3 even when=
=20
>>> on mains. Wouldn't it be even better with C4? As suggested by "Why =
My=20
>>> Cx Power State Is Not Used" I tried unloading various modules (e.g.=
=20
>>> those concerning usb but I got stuck with usbcore which refused to=20
>>> unload despite nothing usb being connected) without any success.=20
>>> Being relatively new to GNU/Linux, I'm a bit stuck here and don't=20
>>> know where to look or what to make of this.
>>>
>>> Any help would be gladly welcome.
>>>
>>> Cheers,
>>>
>>> Oliver
>>> -
>>> To unsubscribe from this list: send the line "unsubscribe linux-acp=
i" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20


-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
