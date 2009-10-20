From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH 5/7] acpi: fix a bunch of style issues on 'actypes.h'
Date: Tue, 20 Oct 2009 08:53:19 +0300
Message-ID: <1256017999.29856.46.camel@localhost>
References: <1255906474-25091-1-git-send-email-felipe.contreras@gmail.com>
	 <1255906474-25091-6-git-send-email-felipe.contreras@gmail.com>
	 <alpine.LSU.2.00.0910191616290.8582@wotan.suse.de>
	 <94a0d4530910190757y139c7e20xe6a58f0cbf13a79d@mail.gmail.com>
	 <alpine.LSU.2.00.0910191658260.8582@wotan.suse.de>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:31465 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781AbZJTFyc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Oct 2009 01:54:32 -0400
In-Reply-To: <alpine.LSU.2.00.0910191658260.8582@wotan.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, linux-acpi@vger.kernel.org

On Mon, 2009-10-19 at 17:03 +0200, Jiri Kosina wrote:
> On Mon, 19 Oct 2009, Felipe Contreras wrote:
>=20
> > > I have never been in favor of merging whitespace-only patches (in=
 a=20
> > > sense that the sole purpose of them being to change whitespaces, =
but=20
> > > no else value added).
> > If somebody tries to send a patch for that file that doesn't fix th=
e
> > white-space, checkpatch will complain, and people will complain tha=
t
> > checkpatch complains, which is precisely what happened,=20
>=20
> Oh, well ... checkpatch warning about this is somewhat controversial.=
 My=20
> preferred way would be that it warns about whitespace only if there a=
re=20
> also some other (non-whitespace) changes.
>=20
> > and I was requested to write this patch by Daniel Walker (final mai=
l=20
> > wasn't on the ml):
> >=20
> > http://lkml.org/lkml/2009/9/14/183
>=20
> This is something slightly different -- he asks you to fixup whitespa=
ce=20
> issue in the code you are newly introducing, right?
>=20
> > > And after today's discussion on kernel summit on this topic, I wo=
uldn't
> > > expect any maintainer to merge it, sorry :)
> > What are you talking about?
>=20
> Seems like many kernel maintainers are just tired of=20
> 'whitespace-cleanup-only' patches that bring no real added value=20
> otherwise.

May be some are tired, but others just say thanks and apply them,
because it is easier to apply than complain, and because they do not
mind if their subsystem becomes a tiny bit cleaner. Sometimes it may
cause troubles, but hey, development is not easy and we are accustomed
to fix conflict and amend patches. But the include/acpi/actypes.h does
not seem to be changing very often anyway.

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
