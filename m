From: Pavel Troller <patrol@sinus.cz>
Subject: Re: Writing to the EC
Date: Sun, 4 Nov 2007 22:31:13 +0100
Message-ID: <20071104213113.GA6064@tangens.sinus.cz>
References: <472E23BC.2010909@gmail.com> <1194211388.2866.12.camel@hughsie-laptop>
Reply-To: Pavel Troller <patrol@sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tangens.sinus.cz ([195.39.17.8]:48387 "EHLO tangens.sinus.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753199AbXKDVvI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 4 Nov 2007 16:51:08 -0500
Content-Disposition: inline
In-Reply-To: <1194211388.2866.12.camel@hughsie-laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Hughes <hughsient@gmail.com>
Cc: Erik =?iso-8859-2?Q?Andr=E9n?= <erik.andren@gmail.com>, linux-acpi@vger.kernel.org

> On Sun, 2007-11-04 at 20:55 +0100, Erik Andr=E9n wrote:
> > The bad part is that writing to the EC using the ec_write function
> > doesn't work at all. Sure it completes the operation, but when prob=
ing
> > the register afterwards, no change of value is seen.
>=20
> This sounds the same as my Lenovo 3000 N100. If you find out how to d=
o
> it - yell - and it's worth many beers.
>=20
> Richard.
>=20
Hi!
 Exactly the same happens with my Clevo D610SU. There is a register whi=
ch
should (probably) activate the Message LED, which is otherwise non-func=
tional.
I've tried my best to write the register, but neither the value can be =
changed
(always 0), nor the LED does anything special.
  With regards, Pavel Troller
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
