From: Peter Feuerer <peter@piie.net>
Subject: Re: [PATCH] acerhdf: Limit modalias matching to supported boards
Date: Mon, 05 Oct 2009 18:41:42 +0200
Message-ID: <cone.1254760902.8356.3072.1000@deskpiie>
References: <4AC9E0F3.5030605@canonical.com> <200910050919.51581.bjorn.helgaas@hp.com> <4ACA1743.5030500@canonical.com> <200910051002.26385.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtprelay01.ispgateway.de ([80.67.31.24]:44668 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753854AbZJERAy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Oct 2009 13:00:54 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Stefan Bader <stefan.bader@canonical.com>, lenb@kernel.org, =?UTF-8?B?bGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc=?= <linux-acpi@vger.kernel.org>, Borislav Petkov <petkovbb@gmail.com>

Bjorn Helgaas writes:

> On Monday 05 October 2009 09:56:51 am Stefan Bader wrote:
>> Bjorn Helgaas wrote:
>> > On Monday 05 October 2009 06:05:54 am Stefan Bader wrote:
>> >>>>>> <stefan.bader@canonical.com> wrote:
>> >>>>>>>>> I search my acerhdf-inbox for the people who sent me the B=
IOS=20
>> >>>>>>>>> versions,
>> >>>>>>>> maybe they still have the netbook and can me send the modal=
ias=20
>> >>>>>>>> content. I'll

=2E..

>> >=20
>> > This smells like a maintenance problem.  The driver only works on =
the
>> > specific machines and BIOS versions compiled into it.  That means =
you
>> > have to update the driver every time a new machine comes out.  A m=
ajor
>> > goal of ACPI is to avoid stuff like that.
>> >=20
>> > Are you sure there's no way to make this driver work in a generic =
way,
>> > e.g., by claiming an ACPI device?
>>=20
>> The driver is currently only targeted at a small set of netbooks and=
 even there=20
>> some registers have changed between sub models or bios versions.
>> The functions are implemented by poking and reading bits from the EC=
=2E No acpi=20
>> interface to which one relate as far as I know. Maybe wmi, but from =
the=20
>> experiences with acer-wmi, I doubt anything works. At least acer-wmi=
 now=20
>> explicitly blacklist these models for uselessness.
>> So the driver performs very strict bios version checks and every unk=
nown=20
>> version get a big warning printed. Which you do not want to be issue=
d on every=20
>> hardware of one of these vendors. Which happens with the driver as i=
t is now.
>=20
> I understand the motivation for the current patch, and I'm not asking
> about it in particular.  My concern is about the underlying structure
> of the driver.
>=20
> I'm just asking why we would want a driver that requires an update
> for every new machine.  That sort of ongoing maintenance is a good
> sign that we're doing something wrong.

Hi Bjorn,

as Stefan already mentioned, is the driver only targeting a very small =
set=20
of (very popular) netbooks. The vendor supposed to control the fan only=
 by=20
BIOS. I think it is not ment to be controlled by the OS at all, as ther=
e is=20
no official Windows support neither.
The successor series of the supported netbooks even don't have the=20
register in EC anymore. So I think there won't be much changes caused b=
y new=20
devices in the future anymore. Besides that, I don't think there's a wa=
y to=20
detect the right register and the needed values automatically=E2=80=A6

kind regards,
--peter
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
