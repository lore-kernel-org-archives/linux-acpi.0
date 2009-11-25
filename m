From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: Avoid C2/C3 idle state
Date: Wed, 25 Nov 2009 09:05:37 +0100
Message-ID: <20091125080537.GA31368@isilmar.linta.de>
References: <20091124222953.GA5983@isilmar.linta.de> <796045.7445.qm@web26501.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from isilmar.linta.de ([213.133.102.198]:40975 "EHLO linta.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750773AbZKYIFe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Nov 2009 03:05:34 -0500
Content-Disposition: inline
In-Reply-To: <796045.7445.qm@web26501.mail.ukl.yahoo.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex <ambroxa@yahoo.it>
Cc: linux-acpi@vger.kernel.org

On Wed, Nov 25, 2009 at 06:53:14AM +0000, Alex wrote:
> --- Mar 24/11/09, Dominik Brodowski <linux@dominikbrodowski.net> ha s=
critto:
>=20
> > Da: Dominik Brodowski <linux@dominikbrodowski.net>
> > Oggetto: Re: Avoid C2/C3 idle state
> > A: "Alex" <ambroxa@yahoo.it>
> > Cc: linux-acpi@vger.kernel.org
> > Data: Marted=EC 24 novembre 2009, 23:29
> > Hey,
> >=20
> > you can set the maximum C-state to use using the
> > "processor.max_cstate=3D<value>" parameter. No need to
> > recompile.
>=20
> Thanks for your kind reply.
>=20
> A stupid qustion:
> <value> is a numeric value as 1 , 2 , 3  (i.e. processor.max_cstate=3D=
1 )
> or is a string like C1 , C2 , C3 (i.e. processor.max_cstate=3DC1 ) ?

It's the former. I'd suggest you try max_cstate=3D2 first, as that migh=
t save
power, reduce heat and still not interfere with the serial device.

Best,
	Dominik
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
