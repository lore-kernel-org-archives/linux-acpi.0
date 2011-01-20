From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: ACPI notify handler and reentrancy of WMI device.
Date: Thu, 20 Jan 2011 11:00:32 +0100
Message-ID: <AANLkTi=o8U78t4zMY9t6=mLdBgFu4VSb_KGPk4xy98e9@mail.gmail.com>
References: <AANLkTi=hBDt+Ej+hNcxxnw4ZjPZ930kR13DVjtt50zwD@mail.gmail.com>
	<AANLkTim0auvcUeDSO7QGSVbj0A+g88FSon7-qT6KzBHd@mail.gmail.com>
	<1295229942.28388.87.camel@minggr.sh.intel.com>
	<AANLkTinfP+-L2T4oggiTpMwE74V6kxgcrStHumYGiH23@mail.gmail.com>
	<1295517311.11852.7.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:59432 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110Ab1ATKAe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Jan 2011 05:00:34 -0500
In-Reply-To: <1295517311.11852.7.camel@minggr.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, Matthew Garrett <mjg@redhat.com>

On Thu, Jan 20, 2011 at 10:55 AM, Lin Ming <ming.m.lin@intel.com> wrote=
:
> On Mon, 2011-01-17 at 14:51 +0800, Corentin Chary wrote:
>> >> I got an acpi notify handler. The notify is triggered when I call=
 WMBC().
>> >> In this notify handler, I must re-call WMBC (with some other argu=
ments, it won't
>> >> notify again this time).
>> >>
>> >> If I do that, I'll get:
>> >> [ =C2=A0176.920391] ACPI Error (dswload-0802): [_T_0] Namespace l=
ookup
>> >> failure, AE_ALREADY_EXISTS
>> >> [ =C2=A0176.920416] ACPI Exception: AE_ALREADY_EXISTS, During nam=
e
>> >> lookup/catalog (20100428/psloop-231)
>> >> [ =C2=A0176.920439] ACPI Error (psparse-0537): Method parse/execu=
tion
>> >> failed [\AMW0.WMBC] (Node f7023b88), AE_ALREADY_EXISTS
>> >> [ =C2=A0176.920469] ACPI: Marking method WMBC as Serialized becau=
se of
>> >> AE_ALREADY_EXISTS error
>> >
>> > Could you attach the acpidump output?
>>
>> Here it is, and here is the patch I did (I used the workqueue soluti=
on
>> in this one):
>>
>> http://git.iksaif.net/?p=3Dacpi4asus.git;a=3Dblobdiff;f=3Ddrivers/pl=
atform/x86/eeepc-wmi.c;h=3D725239860bad8d97dabf8b3db4086d6df4b7820b;hp=3D=
0d8217d1478028071859ba1a503ba226b3cb33a0;hb=3D1eac4d6a6fb632314a464e7d5=
2e1dcb1e4780931;hpb=3D5c5d1a036bb7d38153c6d2102767ef51e5d94ce3
>>
>> (check eeepc_rfkill_notify, it's triggered when the wlan rfkill is
>> blocked: WMBC is called to disable the wlan card, it send a
>> notification, the handler is called, the handler want to check the
>> wlan card status, it calls WMBC again).
>> Thanks;
>>
>
> Sorry for late reply.
>
> WMBC is not an ACPI spec defined method (which always start with "_",
> _ADR, _DSW etc), the driver should only call ACPI spec defined method=
=2E
> What does this method do?
>
> And, I don't see any call to WMBC in eeepc-wmi.c or above patch.

It's a wmi driver, so it calls wmi_evaluate_method, wich internally
will call \AMW0.WMBC for this GUID.
Sorry for the confusion.

I finally found a solut^W^W workaround:
http://git.iksaif.net/?p=3Dacpi4asus.git;a=3Dcommitdiff;h=3Daa8ff8f23b2=
f99da9371da9154d3e523b964f054;hp=3Dd13f17d9657d7161884e289cc2ac6efb414a=
6ff9

But it would probably be cleaner to tell ACPI that we want to
serialize access to this method, and let acpica mechanism do the job
for us.

Thanks,

--=20
Corentin Chary
http://xf.iksaif.net
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
