From: Alex <ambroxa@yahoo.it>
Subject: Re: Avoid C2/C3 idle state
Date: Wed, 25 Nov 2009 12:05:50 +0000 (GMT)
Message-ID: <592341.31696.qm@web26506.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from web26506.mail.ukl.yahoo.com ([217.146.176.43]:23239 "HELO
	web26506.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758747AbZKYMFp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Nov 2009 07:05:45 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-acpi@vger.kernel.org

> > > Hey,
> > >=20
> > > you can set the maximum C-state to use using the
> > > "processor.max_cstate=3D<value>" parameter.
> No need to
> > > recompile.
> >=20
> > Thanks for your kind reply.
> >=20
> > A stupid qustion:
> > <value> is a numeric value as 1 , 2 , 3=A0
> (i.e. processor.max_cstate=3D1 )
> > or is a string like C1 , C2 , C3 (i.e.
> processor.max_cstate=3DC1 ) ?
>=20
> It's the former. I'd suggest you try max_cstate=3D2 first, as
> that might save
> power, reduce heat and still not interfere with the serial
> device.


MMhh , there is a problem in my kernel 2.6.24 (Ubuntu 8.04.3 original)

[=A0 =A0 0.000000] Kernel command line: root=3DUUID=3D27d1e179-62d3-499=
6-878e-e4a456bd45f4 ro quiet splash acpi=3Dforce processor.max_cstate=3D=
2
[=A0 =A0 0.000000] Unknown boot option `processor.max_cstate=3D2': igno=
ring

This is a known problem related to Ubuntu 8.04, solved here:
http://www.inliniac.net/blog/2008/07/25/fixing-noise-on-ubuntu-hardy-80=
4-aka-setting-max_cstate.html

Really my idea is that my serial problems are involved with C3 state: 8=
00 microsec. latency and cache loss.
So I agree with your suggestion to use max_cstate=3D2.
But it doesn't work: serial overrun still there.
max_cstate=3D1 works fine : no overrun at all.
C2 state is buggy too.
I don't know if it's a hardware problem or acpi code problem, but with =
C1 it works fine and I'm happy :-)





     =20
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
