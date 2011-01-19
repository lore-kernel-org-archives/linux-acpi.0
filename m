From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: ACPI notify handler and reentrancy of WMI device.
Date: Wed, 19 Jan 2011 09:15:07 +0100
Message-ID: <AANLkTinNFSkZHF+c3nKKc3uYBqqS-BFXqaTrgQ0xnC4e@mail.gmail.com>
References: <AANLkTi=hBDt+Ej+hNcxxnw4ZjPZ930kR13DVjtt50zwD@mail.gmail.com>
	<AANLkTim0auvcUeDSO7QGSVbj0A+g88FSon7-qT6KzBHd@mail.gmail.com>
	<1295229942.28388.87.camel@minggr.sh.intel.com>
	<AANLkTinfP+-L2T4oggiTpMwE74V6kxgcrStHumYGiH23@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:62801 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753624Ab1ASIPJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Jan 2011 03:15:09 -0500
In-Reply-To: <AANLkTinfP+-L2T4oggiTpMwE74V6kxgcrStHumYGiH23@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org, Len Brown <len.brown@intel.com>, Matthew Garrett <mjg@redhat.com>

On Mon, Jan 17, 2011 at 7:51 AM, Corentin Chary
<corentin.chary@gmail.com> wrote:
>>> I got an acpi notify handler. The notify is triggered when I call W=
MBC().
>>> In this notify handler, I must re-call WMBC (with some other argume=
nts, it won't
>>> notify again this time).
>>>
>>> If I do that, I'll get:
>>> [ =C2=A0176.920391] ACPI Error (dswload-0802): [_T_0] Namespace loo=
kup
>>> failure, AE_ALREADY_EXISTS
>>> [ =C2=A0176.920416] ACPI Exception: AE_ALREADY_EXISTS, During name
>>> lookup/catalog (20100428/psloop-231)
>>> [ =C2=A0176.920439] ACPI Error (psparse-0537): Method parse/executi=
on
>>> failed [\AMW0.WMBC] (Node f7023b88), AE_ALREADY_EXISTS
>>> [ =C2=A0176.920469] ACPI: Marking method WMBC as Serialized because=
 of
>>> AE_ALREADY_EXISTS error
>>
>> Could you attach the acpidump output?
>
> Here it is, and here is the patch I did (I used the workqueue solutio=
n
> in this one):
>
> http://git.iksaif.net/?p=3Dacpi4asus.git;a=3Dblobdiff;f=3Ddrivers/pla=
tform/x86/eeepc-wmi.c;h=3D725239860bad8d97dabf8b3db4086d6df4b7820b;hp=3D=
0d8217d1478028071859ba1a503ba226b3cb33a0;hb=3D1eac4d6a6fb632314a464e7d5=
2e1dcb1e4780931;hpb=3D5c5d1a036bb7d38153c6d2102767ef51e5d94ce3
>
> (check eeepc_rfkill_notify, it's triggered when the wlan rfkill is
> blocked: WMBC is called to disable the wlan card, it send a
> notification, the handler is called, the handler want to check the
> wlan card status, it calls WMBC again).
> Thanks;
>

The above patch doesn't seems to fix the issue everytime.
I think adding mutex protecting WMBC calls would do it.
I you know any cleaner way to do that, let me know.


--=20
Corentin Chary
http://xf.iksaif.net
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
