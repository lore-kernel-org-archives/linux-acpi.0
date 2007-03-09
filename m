From: Mattia Dongili <malattia@linux.it>
Subject: Re: [RFC] sonypi acpi implementation and the future
Date: Fri, 9 Mar 2007 18:02:37 +0100
Message-ID: <20070309170237.GG4229@inferi.kami.home>
References: <20070308141316.GA4229@inferi.kami.home> <1173456602.12833.46.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aa014msr.fastwebnet.it ([85.18.95.74]:32883 "EHLO
	aa014msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767426AbXCIRCt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Mar 2007 12:02:49 -0500
Content-Disposition: inline
In-Reply-To: <1173456602.12833.46.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stelian Pop <stelian@popies.net>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Fri, Mar 09, 2007 at 05:10:02PM +0100, Stelian Pop wrote:
> Le jeudi 08 mars 2007 =E0 15:13 +0100, Mattia Dongili a =E9crit :
>=20
> > What's already there:
> > - enable the device using acpi tables information and methods
> > - input layer event reporting
> > - acpi event reporting
> > my current code is here: http://www.linux.it/~malattia/sony-pic/
>=20
> Ok, I guess you solved the missing interrupt problems then.

yes!

=2E..
> > 7- motion eye camera support
=2E..
> > 7: could be added as is and actually modifying it would break the m=
eye
> > driver (is it really still maintained?) but sonypi and sony-laptop
> > can't export the same symbol.
>=20
> The meye driver only supports a very old Vaio picturebook camera
> (C1VE/C1VN series). I don't have the hardware any longer, and there
> aren't probably a lot of users for this driver.

so 7 can probably quietly sit in sonypi until someone asks for it (funn=
y
thing is it may be me who asks... lol)

Ok, I'll start merging into sony-laptop.
--=20
mattia
:wq!
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
