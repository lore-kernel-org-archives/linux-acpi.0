From: Len Brown <lenb@kernel.org>
Subject: Re: Laptop overheating problem
Date: Sun, 3 Jun 2007 00:29:21 -0400
Message-ID: <200706030029.22130.lenb@kernel.org>
References: <519554c10706021144p1206ca76u58de14068dddfbbb@mail.gmail.com> <8f8ff01d0706021257n1216a981m81beca6135986fde@mail.gmail.com> <466214F4.5060008@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51630 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751690AbXFCE3d convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Jun 2007 00:29:33 -0400
In-Reply-To: <466214F4.5060008@free.fr>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lecotegougdelaforce@free.fr
Cc: Alexey Starikovskiy <aystarik@gmail.com>, Tolga Onbay <tolgaonbay@gmail.com>, linux-acpi@vger.kernel.org

On Saturday 02 June 2007 21:10, Goulven Guillard wrote:
> Alexey Starikovskiy a =E9crit :
> > Please take a look at bugzilla.kernel.org #5534, 2.6.21 or later
> > kernels should not have this problem.
> >>
> >> I installed Ubuntu 7.04 to my hp nc6120 laptop. After working with=
 the
> >> laptop for a while  (changing with the load on the system)  for
> >> example archiving an ~700MB directory, the system is overheating (=
i
> >> mean really hot) and shutting down automatically.
> >>
> >> I searched the problem on the Ubuntu forums, Linux kernel mailing
> >> list, Linux acpi mailing list, ... There have been so many questio=
ns
> >> and bug entries for this problem since 2005. But i can't find the
> >> solution yet. Is there any solution to solve the overheating probl=
em?
>=20
> Didn't try 2.6.21 kernel (2.6.20 only). Don't know if you've read thi=
s :
> https://launchpad.net/ubuntu/+bug/22336 =3D> Ubuntu's overheating is =
a=20
> known problem since at least 09/2005, but doesn't seem important enou=
gh=20
> so Ubuntu's developpers accord much interest on it... (Must be
> disparaging... ;-) )

I've read it, and commented:
https://launchpad.net/ubuntu/+bug/22336/comments/162
7 of the submitters had the problem go away when they cleaned
the dust out of their fan.

However, it seems clear that Linux isn't dealing with
a clogged fan as well as Windows does.

BTW, the Ubuntu developers are on record as thinking it is important,
they just didn't know how to address it.

-Len
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
