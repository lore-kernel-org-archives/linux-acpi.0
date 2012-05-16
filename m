From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Update][PATCH] ACPI / PCI / PM: Fix device PM regression related to D3hot/D3cold
Date: Wed, 16 May 2012 23:01:53 +0200
Message-ID: <201205162301.53607.rjw@sisk.pl>
References: <5165867.6kdtKH1k0B@penguin> <201205162250.11101.rjw@sisk.pl> <4FB4125C.6090808@opensuse.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:48941 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756931Ab2EPU47 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 May 2012 16:56:59 -0400
In-Reply-To: <4FB4125C.6090808@opensuse.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Cristian =?iso-8859-1?q?Rodr=EDguez?= <crrodriguez@opensuse.org>
Cc: Lekensteyn <lekensteyn@gmail.com>, rockorequin@hotmail.com, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Lin Ming <ming.m.lin@intel.com>, Linux PM list <linux-pm@vger.kernel.org>

On Wednesday, May 16, 2012, Cristian Rodr=EDguez wrote:
> El 16/05/12 16:50, Rafael J. Wysocki escribi=F3:
>=20
> > References: https://bugzilla.kernel.org/show_bug.cgi?id=3D43228
> > Reported-by: rocko<rockorequin@hotmail.com>
> > Reported-by: Cristian Rodr=EDguez<crrodriguez@opensuse.org>
> > Reported-and-tested-by: Peter<lekensteyn@gmail.com>
> > Signed-off-by: Rafael J. Wysocki<rjw@sisk.pl>
> > ---
> >
> > The previous patch was still insufficient due to the missing change
> > in drivers/acpi/scan.c.  Please test this one.
> >
> Thank you for taking a look at this, I will test this last patch late=
r=20
> today, sorry for the lag ;)

No problem, thanks!
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
