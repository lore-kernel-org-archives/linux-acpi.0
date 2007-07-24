From: Len Brown <lenb@kernel.org>
Subject: Re: Linus 2.6.23-rc1
Date: Tue, 24 Jul 2007 10:49:13 -0400
Message-ID: <200707241049.13943.lenb@kernel.org>
References: <alpine.LFD.0.999.0707221351030.3607@woody.linux-foundation.org> <200707231957.00794.ismail@pardus.org.tr> <5a4c581d0707231344w2943d5e5p6eece5f0bc0f98c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51280 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757869AbXGXOuG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Jul 2007 10:50:06 -0400
In-Reply-To: <5a4c581d0707231344w2943d5e5p6eece5f0bc0f98c2@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alessandro Suardi <alessandro.suardi@gmail.com>
Cc: Ismail =?iso-8859-1?q?D=F6nmez?= <ismail@pardus.org.tr>, Gabriel C <nix.or.die@googlemail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, len.brown@intel.com

On Monday 23 July 2007 16:44, Alessandro Suardi wrote:
> On 7/23/07, Ismail D=F6nmez <ismail@pardus.org.tr> wrote:
> > On Monday 23 July 2007 19:43:56 Gabriel C wrote:
> > > I get some ACPI Exception.
> > >
> > > ...
> > >
> > > [   33.075429] ACPI Exception (processor_throttling-0084): AE_NOT=
_FOUND,
> > > Evaluating _PTC [20070126] [   33.075437] ACPI Exception
> > > (processor_throttling-0147): AE_NOT_FOUND, Evaluating _TSS [20070=
126] [
> > > 33.075490] ACPI Exception (processor_throttling-0084): AE_NOT_FOU=
ND,
> > > Evaluating _PTC [20070126] [   33.075497] ACPI Exception
> > > (processor_throttling-0147): AE_NOT_FOUND, Evaluating _TSS [20070=
126] [
> > > 33.075529] ACPI Exception (processor_throttling-0084): AE_NOT_FOU=
ND,
> > > Evaluating _PTC [20070126] [   33.075536] ACPI Exception
> > > (processor_throttling-0147): AE_NOT_FOUND, Evaluating _TSS [20070=
126] [
> > > 33.075563] ACPI Exception (processor_throttling-0084): AE_NOT_FOU=
ND,
> > > Evaluating _PTC [20070126] [   33.075570] ACPI Exception
> > > (processor_throttling-0147): AE_NOT_FOUND, Evaluating _TSS [20070=
126]
> > >
> >
> > Same here, I was about to blame my holy Vaio, but latest ACPI merge=
 is to
> > blame instead.
>=20
> Add me too, Dell D610, 2.6.23-rc1 on top of Fedora 7.
>=20

Ignore it -- it is a new patch looking for optional hooks,
and it is simply too verbose when it doesn't find them.
the verbosity will be gone in rc2.

thanks,
-Len
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
