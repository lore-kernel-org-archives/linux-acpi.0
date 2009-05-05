From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [RFC] [PATCH] PCI mmconfig without ACPI
Date: Tue, 5 May 2009 13:32:54 -0700
Message-ID: <20090505133254.2dfc1937@hobbes>
References: <1233766786.16414.26.camel@localhost.localdomain>
	<20090204181738.GA16174@elte.hu>
	<1234812741.28801.4.camel@localhost.localdomain>
	<20090505105744.4268e341@hobbes>
	<9ae48b020905051309h14cf1d7au175e19c66137555@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-mail-136.bluehost.com ([67.222.39.26]:34026 "HELO
	outbound-mail-136.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751913AbZEEUc5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 5 May 2009 16:32:57 -0400
In-Reply-To: <9ae48b020905051309h14cf1d7au175e19c66137555@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ed Swierk <eswierk@aristanetworks.com>
Cc: Ingo Molnar <mingo@elte.hu>, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org

On Tue, 5 May 2009 13:09:30 -0700
Ed Swierk <eswierk@aristanetworks.com> wrote:

> On Tue, May 5, 2009 at 10:57 AM, Jesse Barnes
> <jbarnes@virtuousgeek.org> wrote:
> > I'm still a bit dubious about this; does it solve a real issue? =C2=
=A0Or
> > just remove the ACPI dependency for its own sake?
>=20
> Our products run Linux with a non-ACPI BIOS (Coreboot), so this is no=
t
> just a theoretical issue.

Ah of course, Coreboot.  The patch will need a lot of testing though;
care to send me an updated version so we can get it into linux-next and
have some people try it out?

Thanks,
--=20
Jesse Barnes, Intel Open Source Technology Center
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
