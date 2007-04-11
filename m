From: Danny Kukawka <dkukawka@suse.de>
Subject: Re: [PATCH 1/1] ACPI: asus_acpi, support F2JE model
Date: Wed, 11 Apr 2007 20:32:11 +0200
Message-ID: <200704112032.11772.dkukawka@suse.de>
References: <22473653910004885@karneval.cz> <461CE6AA.6050806@gmail.com> <200704112018.31026.dkukawka@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:36100 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753594AbXDKSdi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Apr 2007 14:33:38 -0400
In-Reply-To: <200704112018.31026.dkukawka@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, corentincj@iksaif.net, sziwan@users.sourceforge.net

On Mittwoch, 11. April 2007, Danny Kukawka wrote:
> Jiri Slaby wrote:
> > Corentin CHARY napsal(a):
> >> Le Wednesday 11 April 2007 11:33:48 Jiri Slaby, vous avez =C3=A9cr=
it :
> >>> asus_acpi, support F2JE model
> >> Just use the new asus-laptop driver =3D)
> >> (see acpi4asus-0.40)
> >=20
> > code seems good, but this is not so good:
> > #if LINUX_VERSION_CODE >=3D KERNEL_VERSION(2,6,20)
> > #warning "This module does not support 2.6.20 yet, wait for a new r=
elease
> > #=3D)" endif
> >
> > When do you plan to support latest kernels and merge it to mainline=
?
>=20
> This patch fixes acpi4asus-0.40 for me at least with 2.6.20 on a ASUS=
 R1F.

Btw. looks as if a new version of the driver (v0.41) is already in the =
mm-tree.

Danny
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
