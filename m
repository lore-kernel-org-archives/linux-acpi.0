From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: Re: [PATCH] ACPI: video: DMI workaround broken Acer 5710 BIOS	enabling
 display brightness
Date: Mon, 14 Jun 2010 19:19:16 +0300
Message-ID: <4C165684.1060609@pardus.org.tr>
References: <1276499864-7609-1-git-send-email-ozan@pardus.org.tr> <20100614142554.GA22158@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lider.pardus.org.tr ([193.140.100.216]:35191 "EHLO
	lider.pardus.org.tr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753956Ab0FNQTT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Jun 2010 12:19:19 -0400
In-Reply-To: <20100614142554.GA22158@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Matthew Garrett wrote:
> On Mon, Jun 14, 2010 at 10:17:44AM +0300, Ozan =C3=87a=C4=9Flayan wro=
te:
>> Acer Aspire 5710 suffers from a similar ACPI problem reported at:
>>  http://bugzilla.kernel.org/show_bug.cgi?id=3D13121
>=20
> Bleah. Is this really necessary? If we set maximum brightness and the=
n=20
> read back something other than maximum brightness, then that gives us=
=20
> the offset.

By *this* do you mean the specific quirk that I sent or the whole offse=
t workaround
suggested and upstreamed in the bug report?

Actually I sync'ed the video driver from linux-2.6 on top of 2.6.31.13 =
and applied this patch.
The user reported that it fixed the issue but it is possible that this =
quirk
is NOOP and the bug is already fixed with what I've backported.

I'll let him try without the patch, and report back.

Thanks,
Regards.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
