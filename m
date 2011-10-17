From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] x86/PCI: fix boot-time memory leak
Date: Mon, 17 Oct 2011 22:04:22 +0100
Message-ID: <20111017210422.GA17547@arm.com>
References: <20110923165946.27079.95660.stgit@bhelgaas.mtv.corp.google.com>
 <CAErSpo4LWWFrvRxtm8juQcxnaq8+citS4=1PV0edhLhzm=5yKw@mail.gmail.com>
 <CAE9FiQWuxJC8j8L6hwbuQk6k2pn1yvDO789MH0=E8MWm0t29_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:64326 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753903Ab1JQVTr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Oct 2011 17:19:47 -0400
Content-Disposition: inline
In-Reply-To: <CAE9FiQWuxJC8j8L6hwbuQk6k2pn1yvDO789MH0=E8MWm0t29_A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Bernd Schubert <bernd.schubert@itwm.fraunhofer.de>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Simon Kirby <sim@hostway.ca>

On Mon, Oct 17, 2011 at 08:17:12PM +0100, Yinghai Lu wrote:
> On Mon, Oct 17, 2011 at 9:30 AM, Bjorn Helgaas <bhelgaas@google.com> =
wrote:
> > On Fri, Sep 23, 2011 at 10:59 AM, Bjorn Helgaas <bhelgaas@google.co=
m> wrote:
> >> If we're not using _CRS, the host bridge's bus name and resource s=
tructures
> >> were allocated but never freed. =A0This patch fixes that.
> >>
> >> Patch by Catalin Marinas <catalin.marinas@arm.com>
> >>
> >> Reported-by: Bernd Schubert <bernd.schubert@itwm.fraunhofer.de>
> >> Reported-by: Simon Kirby <sim@hostway.ca>
> >> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>=20
> is this patch from you or Catalin?
>=20
> If it is from Catalin, you should use
>=20
> From:  Catalin Marinas <catalin.marinas@arm.com>

I just proposed an alternative to the original patch but the full
investigation was done I think by Bjorn. I don't mind if I'm not the
author :)

--=20
Catalin
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
