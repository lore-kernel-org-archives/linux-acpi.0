From: =?ISO-8859-1?Q?Sune_M=F8lgaard?= <sune@molgaard.org>
Subject: Re: Frequency scaling, Dell Inspiron 6000
Date: Mon, 30 Jul 2007 15:26:24 +0200
Message-ID: <46ADE700.6070400@molgaard.org>
References: <46AC9E33.3020008@molgaard.org> <20070730004423.GA27398@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cicero1.cybercity.dk ([212.242.40.4]:64532 "EHLO
	cicero1.cybercity.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756824AbXG3N03 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Jul 2007 09:26:29 -0400
In-Reply-To: <20070730004423.GA27398@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org

Matthew Garrett wrote:
> On Sun, Jul 29, 2007 at 04:03:31PM +0200, Sune M=F8lgaard wrote:
>=20
>> The CPU of the machine is labeled as centrino compliant, but is in f=
act=20
>> a Celeron-M, and hence does not support _Enhanced_ Speedstep. Howeve=
r, I=20
>> clearly remember having frequency scaling working with Ubuntu kernel=
=20
>> 2.6.15, but failing with Ubuntu 2.6.17 (possibly with some 2.6.18 co=
de=20
>> backported).
>=20
> It doesn't support Speedstep at all. You were probably using p4-clock=
mod=20
> in the past, which is a mechanism for temperature control rather than=
=20
> any sort of useful power saving.

Hi Matthew, and thanks for answering,

This might be as you describe, as I don't know which module was used=20
when it worked.

However, I got a warning dialogue window from the GNOME powernowd apple=
t=20
about frequency scaling being unavailable upon the kernel upgrade, not=20
upon an upgrade of powernowd as one might suspect, if powernowd suddenl=
y=20
seized to support p4-clockmod.

If I had bought the laptop today and encountered the problems, I would=20
probably reach the same conclusion as you, but IIRC powernowd doesn't=20
cooperate with p4-clockmod, and it was a kernel upgrade that made it=20
complain.

I stated earlier that I didn't recall if the BIOS or the kernel upgrade=
=20
came first, but digging into my memory of events, plus my normal way of=
=20
dealing with problems, I am now fairly sure that the kernel upgrade=20
borked frequency scaling (or clockmod, which I still find unlikely),=20
prompting the BIOS upgrade.

Best regards,

Sune M=F8lgaard

--=20
Men will wrangle for religion; write for it; fight for it; die for it;=20
anything but live for it.
- Charles Caleb Colton
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
