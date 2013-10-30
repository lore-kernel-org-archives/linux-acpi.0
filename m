From: Levente Kurusa <levex@linux.com>
Subject: Re: [PATCH RESEND] ACPI: Add Toshiba NB100 to Vista _OSI blacklist
Date: Wed, 30 Oct 2013 07:11:59 +0100
Message-ID: <5270A32F.5030909@linux.com>
References: <526FE7E8.80806@linux.com> <2710175.xeuRHdVpyL@vostro.rjw.lan>
Reply-To: levex@linux.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ee0-f48.google.com ([74.125.83.48]:56221 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552Ab3J3GMD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Oct 2013 02:12:03 -0400
In-Reply-To: <2710175.xeuRHdVpyL@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Robert Hancock <hancockrwd@gmail.com>, Aaron Lu <aaron.lu@intel.com>, ACPI List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

2013-10-29 23:44 keltez=C3=A9ssel, Rafael J. Wysocki =C3=ADrta:
> On Tuesday, October 29, 2013 05:52:56 PM Levente Kurusa wrote:
>> This patch adds Toshiba NB100 to the Vista _OSI blacklist.
>>
>> The _OSI(Windows 2006) method is bugged on the netbook resulting in =
messed up
>> PCI IRQ Routing information. This was observed on a netbook,
>> whose SATA controller mode was set to Compatibility mode.
>> The driver would then register itself to IRQ#16, but the device
>> was in fact issuing interrupts to IRQ#20.
>> No side-effects were found during testing, everything is
>> working as it did before.
>>
>> See thread:
>> http://marc.info/?t=3D137862230200001&r=3D1&w=3D2
>> http://www.spinics.net/lists/linux-ide/msg46173.html
>>
>>
>> Signed-off-by: Levente Kurusa <levex@linux.com>
>> Reviewed-by: Robert Hancock <hancockrwd@gmail.com>
>=20
> That should be in linux-pm/linux-next already, isn't it there?

Hm, I didn't receive any reply back on the other mail, so I thought it =
got
lost somewhere. I see now that it has been applied, thanks and sorry fo=
r
the inconvenience.

--=20
Regards,
Levente Kurusa
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
