From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] x86/PCI: fix boot-time memory leak
Date: Mon, 17 Oct 2011 13:21:45 -0700
Message-ID: <20111017202145.GA6861@kroah.com>
References: <20111017194037.7778.11572.stgit@bhelgaas.mtv.corp.google.com>
 <20111017194652.GA22656@kroah.com>
 <CAErSpo4fo+qJei5XeCqWd3kK7h=EPVtpuP0K5EvicCwnheMG5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:33734 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753144Ab1JQUZE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Oct 2011 16:25:04 -0400
Content-Disposition: inline
In-Reply-To: <CAErSpo4fo+qJei5XeCqWd3kK7h=EPVtpuP0K5EvicCwnheMG5A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Bernd Schubert <bernd.schubert@itwm.fraunhofer.de>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Simon Kirby <sim@hostway.ca>, Catalin Marinas <catalin.marinas@arm.com>

On Mon, Oct 17, 2011 at 01:59:10PM -0600, Bjorn Helgaas wrote:
> On Mon, Oct 17, 2011 at 1:46 PM, Greg KH <greg@kroah.com> wrote:
> > On Mon, Oct 17, 2011 at 01:40:37PM -0600, Bjorn Helgaas wrote:
> >> From: Catalin Marinas <catalin.marinas@arm.com>
> >>
> >> If we're not using _CRS, the host bridge's bus name and resource s=
tructures
> >> were allocated but never freed. =A0This patch fixes that.
> >>
> >> Reported-by: Bernd Schubert <bernd.schubert@itwm.fraunhofer.de>
> >> Reported-by: Simon Kirby <sim@hostway.ca>
> >> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> >
> > Is this something for the 3.0-stable tree as well?
>=20
> It could be applied to 3.0-stable, but it only fixes a boot-time leak
> of a couple hundred bytes (approx 16-byte name + typically 4 56-byte
> struct resources), so I don't think it qualifies as any kind of a
> critical fix.

Ok, just wanted to check, thanks.

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
