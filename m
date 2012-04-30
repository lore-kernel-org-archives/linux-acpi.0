From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI / PCI: Make _SxD/_SxW check follow ACPI 4.0a spec
Date: Mon, 30 Apr 2012 23:32:37 +0200
Message-ID: <201204302332.38009.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1204301348180.1558-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:46247 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756418Ab2D3V1y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Apr 2012 17:27:54 -0400
In-Reply-To: <Pine.LNX.4.44L0.1204301348180.1558-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, linux-pci@vger.kernel.org, "Oleksij Rempel (fishor)" <bug-track@fisher-privat.net>, LKML <linux-kernel@vger.kernel.org>, Andrey Rahmatullin <wrar@wrar.name>, Steven Rostedt <rostedt@goodmis.org>

On Monday, April 30, 2012, Alan Stern wrote:
> On Mon, 30 Apr 2012, Bjorn Helgaas wrote:
>=20
> > On Sun, Apr 29, 2012 at 2:44 PM, Rafael J. Wysocki <rjw@sisk.pl> wr=
ote:
> > > From: Oleksij Rempel <bug-track@fisher-privat.net>
> > >
> > > This patch makes _SxD/_SxW check follow the ACPI 4.0a specificati=
on
> > > more closely and fixes suspend bug found on ASUS Zenbook UX31E.
> > >
> > > Some OEM use _SxD fileds do blacklist brocken Dx states.
> > > If _SxD/_SxW return values are check before suspend as appropriat=
e,
> > > some nasty suspend/resume issues may be avoided.
> > >
> > > References: https://bugzilla.kernel.org/show_bug.cgi?id=3D42728
> > > Signed-off-by: Oleksij Rempel <bug-track@fisher-privat.net>
> > > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > > ---
> > >
> > > Bjorn, Len,
> > >
> > > This is -stable material and therefore v3.4 as well, IMO. =EF=BF=BD=
Please let me
> > > know if one of you can take it or whether you want me to handle i=
t all the
> > > way to Linus.
> >=20
> > I'm OK with this from a PCI perspective.  Most of the change is in
> > ACPI, so I propose that either you or Len take care of it.
> >=20
> > The second paragraph of the changelog has several typos
> > (fileds/fields, do/to, brocken/broken, etc).
>=20
> It also turns out that the normal wakeup mechanism doesn't work for t=
he
> devices in question.  Can this be detected by ACPI?  We don't want to=
=20
> tell userspace that wakeup works when in fact it doesn't.

No, we don't, but if there's _PRW and/or _DSW/_PSW for the device, we r=
eally
have to assume that the device is able to wake up the system.  Moreover=
, if
those methods don't return error codes, we have no way to say there's a=
nything
wrong.

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
