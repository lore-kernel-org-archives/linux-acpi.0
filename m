From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [origin tree build failure] [PATCH] thinkpad-acpi: Fix build
	on !CONFIG_THINKPAD_ACPI_HOTKEY_POLL
Date: Mon, 28 Sep 2009 17:35:26 +0200
Message-ID: <20090928153526.GA9231@elte.hu>
References: <200909260519.n8Q5JrB6016778@hera.kernel.org> <20090927075254.GA20847@elte.hu> <20090927122828.GA24783@khazad-dum.debian.net> <alpine.LFD.2.00.0909272331520.5561@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:34067 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752518AbZI1PgB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Sep 2009 11:36:01 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0909272331520.5561@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

* Len Brown <lenb@kernel.org> wrote:

>=20
> > > >  drivers/platform/x86/thinkpad_acpi.c    |  632 +++++++++++++++=
++++---------
> > >=20
> > > -tip testing found that these changes caused a build failure=20
> > > in drivers/platform/x86/thinkpad_acpi.c when=20
> > > !CONFIG_THINKPAD_ACPI_HOTKEY_POLL - the fix is attached  below.
> >=20
> > Fixed by a different patch, which will hit mainline soon....
>=20
> Ingo,
> 2.6.32-rc1 should build fine* -- let me know if it doesn't.
>=20
> thanks,
> Len Brown, Intel Open Source Technology Center
>=20
> * module this message, which Henruque assures me will go away soon
> drivers/platform/x86/thinkpad_acpi.c:2225: warning:=20
> =E2=80=98tpacpi_hotkey_driver_mask_set=E2=80=99 defined but not used

well, the warning is fixed properly in my patch, as pointed out in the=20
changelog. Have you read that?

	Ingo
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
