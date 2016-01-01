From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V9 1/2] ACPI, PCI, irq: remove interrupt count restriction
Date: Fri, 01 Jan 2016 01:48:40 +0100
Message-ID: <6338540.F7x0ET9vtV@vostro.rjw.lan>
References: <1449677909-12432-1-git-send-email-okaya@codeaurora.org> <56842DDF.6040109@codeaurora.org> <CAHp75VePLCAP8L3ve4F4745Nnes+kYa5QHHKQos4=0iHw0Ah0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58417 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750977AbcAAASI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 31 Dec 2015 19:18:08 -0500
In-Reply-To: <CAHp75VePLCAP8L3ve4F4745Nnes+kYa5QHHKQos4=0iHw0Ah0Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Sinan Kaya <okaya@codeaurora.org>, Christopher Covington <cov@codeaurora.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, jcm@redhat.com, helgaas@kernel.org, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wednesday, December 30, 2015 09:55:35 PM Andy Shevchenko wrote:
> On Wed, Dec 30, 2015 at 9:17 PM, Sinan Kaya <okaya@codeaurora.org> wr=
ote:
> > On 12/30/2015 8:28 AM, Andy Shevchenko wrote:
> >> Yep, I meant not to use an additional variable.
> >>
> >>> > BTW, I suggest you spend some time around checkpatch for contri=
butions. I could
> >>> > have caught most of the issues you are generally concerned befo=
re submitting a patch.
> >> Is it a question?
> >
> > It is a request not a question. I hate wasting your time and my tim=
e with things that I could
> > have fixed before submitting a patch.
> >
> > I ran the checkpatch and it said I'm good to go. But, obviously I'm=
 not.
>=20
> Hmm=E2=80=A6 checkpatch.pl is just a small helper to fix style issues=
=2E Here is
> just a common sense rule, or kind of Occam's razor: no need to have
> more variables then needed if it doesn't improve something really
> significantly.

That said, compilers optimize things anyway, so using an extra local va=
riable
shouldn't matter for the resulting machine code.

Thanks,
Rafael

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
