From: Goulven Guillard <lecotegougdelaforce@free.fr>
Subject: Re: 2.6.22-rc1-mm1 [cannot change thermal trip points]
Date: Tue, 22 May 2007 11:28:24 +0200
Message-ID: <4652B7B8.9030503@free.fr>
References: <200705202350.45145.lenb@kernel.org> <20070521121048.GA8332@elf.ucw.cz> <20070521132711.GA7540@srcf.ucam.org> <20070521132948.GD8332@elf.ucw.cz> <20070521133608.GB7540@srcf.ucam.org> <20070521134046.GE8332@elf.ucw.cz> <20070521134553.GA7911@srcf.ucam.org> <20070521224200.GF10714@elf.ucw.cz> <20070522003153.GA18162@srcf.ucam.org> <20070522090636.GO10714@elf.ucw.cz> <20070522091631.GA23309@srcf.ucam.org>
Reply-To: lecotegougdelaforce@free.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ires.in2p3.fr ([193.48.86.184]:47811 "EHLO IReS.in2p3.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755234AbXEVJ3p (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 May 2007 05:29:45 -0400
In-Reply-To: <20070522091631.GA23309@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>, trenn@suse.de, Chuck Ebbert <cebbert@redhat.com>, len.brown@intel.com, Maciej Rutecki <maciej.rutecki@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, torvalds@linux-foundation.org

Le 05/22/2007 11:16 AM, Matthew Garrett a d=E9clar=E9 :
> On Tue, May 22, 2007 at 11:06:36AM +0200, Pavel Machek wrote:
>=20
>> We need to ignore trip point updates from BIOS, and we need to poll
>> thermals when use overrides trip points. That's expected. Plus I've
>> yet to see platform actually updating the trip points.
>=20
> Try any recent HP bios.
>=20

man cron... ;-)





--=20
    ~~
   |Oo|   La banquise fond !!! Adoptez un pingouin...
  /|\/|\
   |__|            =3D> http://doc.ubuntu-fr.org/
   ^__^
~~~|  |~~~








-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
