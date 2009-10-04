From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [PATCH] battery: Fix charge_now returned by broken batteries
Date: Mon, 05 Oct 2009 01:36:56 +0400
Message-ID: <4AC91578.2020807@suse.de>
References: <1254669853.26496.0.camel@carter> <ca2dc2820910041046i47a1c3dhba82266bb14a440c@mail.gmail.com> <4AC8F02B.6080209@suse.de> <200910042246.23712.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:53102 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758036AbZJDVhg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 4 Oct 2009 17:37:36 -0400
In-Reply-To: <200910042246.23712.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Rafael,

This is not my rule, it was/is the rule of power device class. If you d=
o not agree to it, please change
appropriate documentation.

Regards,
Alex.

Rafael J. Wysocki =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On Sunday 04 October 2009, Alexey Starikovskiy wrote:
>> Hi Miguel,
>=20
> Hi Alex,
>=20
>> I am going to reject your patch on the basis, that the battery drive=
r should report only
>> information it gained from battery hardware, not interpret it in any=
 way.
>> As your patch fall into "interpret" category, it does not belong in =
the kernel and battery
>> driver in particular. You may suggest it to any/all user space batte=
ry monitoring applications,
>> this is the place for "interpretations".
>=20
> Well, we do quirks for PCI devices, suspend quirks etc. in the kernel=
, so I'm
> not really sure we should use the "no interpretation" as a general ru=
le.  IMO,
> if there's a known broken system needing a quirk, it may just be more
> reasonable to put the quirk into the kernel than to put it into every=
 single
> user application out there.
>=20
> In this particular case we have an evidently quirky hardware (or BIOS=
) and it's
> not a fundamentally wrong idea to try to address that problem in the =
kernel.
>=20
> Thanks,
> Rafael

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
