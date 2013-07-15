From: joeyli <jlee@suse.com>
Subject: Re: [PATCH] ACPI:remove panic in case hardware has changed after S4
Date: Mon, 15 Jul 2013 21:59:33 +0800
Message-ID: <1373896773.6260.28.camel@linux-s257.site>
References: <1373544870-15135-1-git-send-email-oliver@neukum.org>
	 <6802146.fKe43BS873@skinner.arch.suse.de>
	 <1373618715.7539.106.camel@linux-s257.site>
	 <5742401.D3Ye1zZPh5@linux-5eaq.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:40114 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756735Ab3GON7f (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Jul 2013 09:59:35 -0400
In-Reply-To: <5742401.D3Ye1zZPh5@linux-5eaq.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: Thomas Renninger <trenn@suse.de>, lenb@kernel.org, rjw@sisk.pl, linux-acpi@vger.kernel.org

=E6=96=BC =E4=B8=80=EF=BC=8C2013-07-15 =E6=96=BC 13:29 +0200=EF=BC=8COl=
iver Neukum =E6=8F=90=E5=88=B0=EF=BC=9A
> On Friday 12 July 2013 16:45:15 joeyli wrote:
>=20
> > Per information from OEM, Windows 8 didn't really block S4 resume w=
hen
> > hardware_signature not match, I think as Oliver's patch.
>=20
> Is that confidential information?
> =20
> If it is indeed true, introducing a blacklist makes no sense. And I
> see no alternative to my patch. Should I resubmit with an improved
> comment?
>=20
> 	Regards
> 		Oliver
>=20

It's not confidential but non-official from OEM.

I looking for a additional DRAM module to test this behavior on my Acer
machine.=20


Thank
Joey Lee


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
