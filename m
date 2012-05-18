From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] Add ACPI and power trace points for laptop overheating
Date: Fri, 18 May 2012 16:14:29 +0200
Message-ID: <20120518141429.GO27374@one.firstfloor.org>
References: <1337263737-3541-1-git-send-email-andi@firstfloor.org> <CAJd=RBCwLOxQwfmppxxJjfJzEJ+RSoL4MaE9wKtSrotKe2J56w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:40261 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946089Ab2EROOg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 May 2012 10:14:36 -0400
Content-Disposition: inline
In-Reply-To: <CAJd=RBCwLOxQwfmppxxJjfJzEJ+RSoL4MaE9wKtSrotKe2J56w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hillf Danton <dhillf@gmail.com>
Cc: Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, lenb@kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>

> > --- a/drivers/acpi/Makefile
> > +++ b/drivers/acpi/Makefile
> > @@ -73,3 +73,4 @@ obj-$(CONFIG_ACPI_PROCESSOR_AGGREGATOR) +=3D acpi=
_pad.o
> > =A0obj-$(CONFIG_ACPI_IPMI) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D acpi=
_ipmi.o
> >
> > =A0obj-$(CONFIG_ACPI_APEI) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D apei=
/
> > +obj-$(CONFIG_TRACEPOINTS) =A0 =A0 =A0+=3D acpi-trace.o
> > \ No newline at end of file
>=20
> For what the newline is?

=46or nothing as make works.

-Andi
--=20
ak@linux.intel.com -- Speaking for myself only.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
