From: Alex <ambroxa@yahoo.it>
Subject: Re: Avoid C2/C3 idle state
Date: Wed, 25 Nov 2009 06:53:14 +0000 (GMT)
Message-ID: <796045.7445.qm@web26501.mail.ukl.yahoo.com>
References: <20091124222953.GA5983@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from web26501.mail.ukl.yahoo.com ([217.146.176.38]:32518 "HELO
	web26501.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752276AbZKYGxJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Nov 2009 01:53:09 -0500
In-Reply-To: <20091124222953.GA5983@isilmar.linta.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-acpi@vger.kernel.org

--- Mar 24/11/09, Dominik Brodowski <linux@dominikbrodowski.net> ha scr=
itto:

> Da: Dominik Brodowski <linux@dominikbrodowski.net>
> Oggetto: Re: Avoid C2/C3 idle state
> A: "Alex" <ambroxa@yahoo.it>
> Cc: linux-acpi@vger.kernel.org
> Data: Marted=EC 24 novembre 2009, 23:29
> Hey,
>=20
> you can set the maximum C-state to use using the
> "processor.max_cstate=3D<value>" parameter. No need to
> recompile.

Thanks for your kind reply.

A stupid qustion:
<value> is a numeric value as 1 , 2 , 3  (i.e. processor.max_cstate=3D1=
 )
or is a string like C1 , C2 , C3 (i.e. processor.max_cstate=3DC1 ) ?





     =20
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
