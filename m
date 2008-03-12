From: Lukas Hejtmanek <xhejtman@ics.muni.cz>
Subject: Re: 2.6.25-rc2 Regression Thinkpad acpi
Date: Wed, 12 Mar 2008 14:55:21 +0100
Message-ID: <20080312135521.GE8141@ics.muni.cz>
References: <20080225230035.GA14503@khazad-dum.debian.net> <20080226184937.GA4280@ics.muni.cz> <20080304194513.GY6704@kernel.dk> <47CDBA74.5080304@gmail.com> <20080304211212.GD6704@kernel.dk> <47CDBE11.4010900@gmail.com> <20080312125912.GM17940@kernel.dk> <20080312131737.GA21290@khazad-dum.debian.net> <20080312132419.GN17940@kernel.dk> <20080312133529.GB21290@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from minas.ics.muni.cz ([147.251.4.40]:35888 "EHLO minas.ics.muni.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751585AbYCLN4P (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Mar 2008 09:56:15 -0400
Content-Disposition: inline
In-Reply-To: <20080312133529.GB21290@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Jens Axboe <jens.axboe@oracle.com>, Alexey Starikovskiy <aystarik@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Wed, Mar 12, 2008 at 10:35:29AM -0300, Henrique de Moraes Holschuh w=
rote:
> You shouldn't need to do anything other than teach userspace to respo=
nd to
> them, as they generate the proper KEY_* events.  If you are giving th=
e AML
> _OSI(Linux), at least...
>=20
> But maybe looking at the keyboard output in console mode, to make tri=
ple
> sure the events ARE being sent over the KDC as they should, would be =
in
> order?

so, do I understand correctly that volume keys have been controlled by =
ACPI
and seemed to work independently on SW and now (exactly since when?) ar=
e
passed complety to the user space as key codes?

--=20
Luk=E1=B9 Hejtm=E1nek
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
