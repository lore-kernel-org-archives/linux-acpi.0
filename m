From: "Cagle, John (ISS-Houston)" <john.cagle-VXdhtT5mjnY@public.gmane.org>
Subject: RE: acpi-20030328-2.4.21-pre6.diff on Toshiba hard locks
Date: Wed, 23 Apr 2003 19:14:20 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C50AB9511EE59B49B2A503CB7AE1ABD10476C30B@cceexc19.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Rob Hughes <rob-d2NfoQ5nhImakBO8gow8eQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Rob - that wasn't the full "dmesg" log (it's missing all the ACPI
related logging).  Can you send out the last boot log from
/var/log/messages?

Also, the contents of /proc/interrupts would be useful to the ACPI
developers.  Send two versions: from your prior installation and the
new, non-working one.

Thanks,
John

> -----Original Message-----
> From: Rob Hughes [mailto:rob-d2NfoQ5nhImakBO8gow8eQ@public.gmane.org]=20
> Sent: Wednesday, April 23, 2003 5:03 PM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Re: [ACPI] acpi-20030328-2.4.21-pre6.diff on Toshiba=20
> hard locks
>=20
>=20
> On Tue, 2003-04-22 at 22:38, Rob Hughes wrote:
> > Got the acpi-20030328 patch, applied it to a vanilla=20
> 2.4.21-pre6 and=20
> > compiled. Everything went cleanly, but I'm having a problem=20
> with the=20
> > sound hardware. I've tried both the oss and alsa intel=20
> sound modules,=20
> > and both produce hard locks on my Tos 5005-S504. I'm not=20
> able to break=20
> > to a debug prompt, and there is no oops. Dmesg produces no useful=20
> > output at boot, or at least, it's not any different in content from=20
> > previous patches where this configuration was working. Adding=20
> > "pci=3Dnoacpi" prevents the lock, but also keeps all sound=20
> modules from=20
> > loading as the hardware isn't initialized. Any hints on where I=20
> > could/should start looking? Other than the above, I'm not sure what=20
> > other info to include here, as I'm not entirely sure what's=20
> relevant.
> >=20
> > Thanks,
> > Rob
>=20
> Hate replying to my own posts, but I did find something. It=20
> appears to be a problem with IRQ sharing on this system, as=20
> most devices are being assigned IRQ 10. I'll go ahead and=20
> attach what I hope are the relevant info, that being the=20
> dsdt, dmesg output and output from lspci -vv.
>=20
> This system does run using another OS, and again, ran fine=20
> with earlier kernels, so I strongly suspect that IRQ sharing=20
> on this system has been broken somehow.
>=20
> Rob


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
