From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/3] acpi: video: trivial style cleanups
Date: Sat, 03 Aug 2013 02:01:57 +0200
Message-ID: <3692149.CN6y0aXjQ7@vostro.rjw.lan>
References: <1375400641-1694-1-git-send-email-felipe.contreras@gmail.com> <2112254.EC1eeAtOxW@vostro.rjw.lan> <CAMP44s2oYm+iE-BYu93-bniTRPiu_LZWSAmAd8xEoNSZJbjemQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:52797 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754789Ab3HBXvp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Aug 2013 19:51:45 -0400
In-Reply-To: <CAMP44s2oYm+iE-BYu93-bniTRPiu_LZWSAmAd8xEoNSZJbjemQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Aaron Lu <aaron.lwe@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Jiri Kosina <trivial@kernel.org>

On Friday, August 02, 2013 12:56:09 PM Felipe Contreras wrote:
> On Fri, Aug 2, 2013 at 9:09 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote=
:
> > On Thursday, August 01, 2013 11:18:34 PM Felipe Contreras wrote:
> >> On Thu, Aug 1, 2013 at 8:55 PM, Aaron Lu <aaron.lwe@gmail.com> wro=
te:
> >> > On 08/02/2013 07:44 AM, Felipe Contreras wrote:
> >> >> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> >> >
> >> > Change log please.
> >>
> >> You mean a commit message?
> >
> > No.  He meant the part that goes between the subject and the signof=
f.
> > This is called a change log (or changelog).
>=20
> Not in Git lingo.
>=20
> % man git commit
>=20
> "Though not required, it=E2=80=99s a good idea to begin the commit me=
ssage
> with a single short (less than 50 character) line summarizing the
> change, followed by a blank line and then a more thorough
> description."

Please go and read this: https://lwn.net/Articles/560392/

Now, you may still argue that your patches fall into the "add missing i=
nclude
of foo.h" category, but it does several different things:
- fixes some whitespace,
- fixes a couple of static variable initializations,
- removes some braces,
- changes the placement of some lables (some of them unnecessarily).

It would be simply *nice* to write what it does in the changelog so tha=
t
people reading the git log don't have to look deeper to see what change=
s the
author meant as "trivial style cleanups".

That's just a matter of making it easier to work with you for other peo=
ple,
but maybe you just want to be difficult to work with in the first place=
?

Rafael


--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
