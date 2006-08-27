From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH](memory hotplug) Repost remove useless message at boot time from 2.6.18-rc4.
Date: Sun, 27 Aug 2006 14:50:50 +0200 (CEST)
Message-ID: <223978.1156683050640.SLOX.WebMail.wwwrun@imap-dhs.suse.de>
References: <20060810142329.EB03.Y-GOTO@jp.fujitsu.com> <1155643418.4302.1154.camel@queen.suse.de> <20060825205423.0778.Y-GOTO@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38310 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932101AbWH0MvA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 27 Aug 2006 08:51:00 -0400
In-Reply-To: <20060825205423.0778.Y-GOTO@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: akpm@osdl.org, "Brown, Len" <len.brown@intel.com>, keith mannthey <kmannth@us.ibm.com>, ACPI-ML <linux-acpi@vger.kernel.org>, Linux Kernel ML <linux-kernel@vger.kernel.org>, Linux Hotplug Memory Support <lhms-devel@lists.sourceforge.net>, naveen.b.s@intel.com

Am Fr 25.08.2006 13:59 schrieb Yasunori Goto <y-goto@jp.fujitsu.com>:
>
>>
>> > I sent a patch a while ago that gets rid of the whole namespace
>> > walking
>> > by making acpi_memoryhotplug an acpi device and making use of the
>> > .add
>> > callback function and the acpi_bus_register_driver call.
>> >
>> > I am not sure whether this is possible if you have multiple memory
>> > devices, though (if not maybe it should be made possible?)...
>> >
>> > Yasunori even tested the patch and sent an Ok:
>> > http://marc.theaimsgroup.com/?t=3D114065312400001&r=3D1&w=3D2
>> >
>> > If this is acceptable I can rebase the patch on a current kernel.
>>
>> Hi. Thomas-san.
>> Did you rebase your patch?
>>
>> I'm trying to do it now too.
>> But, current code (2.6.18-rc4) seems to register handler for
>> only enable status devices at boot time.
>> So, notification is -discarded- due to no handler for new memory
>> device when hot-add event occurs. Hmmm. :-(
>No, what I see the notify handler is always installed.
>But there seem to be added some device state code, which I think is no=
t
>correct:
>E.g. the=C2=A0state in acpi_memory_device_add():
> =C2=A0=C2=A0=C2=A0mem_device->state =3D MEMORY_POWER_ON_STATE;
>should be=C2=A0evaluated=C2=A0from=C2=A0_STA=C2=A0function.
> When an=C2=A0ACPI memory device=C2=A0is=C2=A0added,=C2=A0the=C2=A0phy=
sical memory=C2=A0might=C2=A0not
>be=C2=A0added yet... IMO only one state, the one evaluated from _STA s=
hould
>be used.
>I'll have a closer look.
>
>This probably is nothing for 2.6.18 ... you never know..., but maybe i=
t
>can be added
>to ACPI test branch or mm?
>Patch is against 2.6.18-rc4 and only compile
>tested=C2=A0(don't=C2=A0have=C2=A0hardware=C2=A0to=C2=A0test).
>
>The attached patch moves the install/remove notify handler to the
>.add/.remove callback functions that get invoked for every ACPI memory
>device
>(like it is done in other ACPI modules).
>No need for an additional walk_namespace() call.
>
>Sorry, I can only attach patch because of webmailer...
>

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
