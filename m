From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: Re: s3_late_bios
Date: Wed, 10 Nov 2004 08:25:19 -0800
Message-ID: <419240EF.7050709@root.org>
References: <20041108144947.GA31267@tate.loria.fr>	 <20041108213558.GB4607@elf.ucw.cz> <418FEAD5.1000007@root.org>	 <20041109125522.GA8015@tate.loria.fr> <419127E6.3000603@root.org>	 <20041110072003.GA13561@tate.loria.fr> <1100087772.6014.5.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1100087772.6014.5.camel@tyrosine>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Matthew Garrett wrote:
> On Wed, 2004-11-10 at 08:20 +0100, Emmanuel Thom=C3=A9 wrote:
>=20
>>On Tue, Nov 09, 2004 at 12:26:14PM -0800, Nate Lawson wrote:
>>
>>>I mostly work on FreeBSD and since it has clean vm86 support routines,=
=20
>>>it doesn't involve any inline assembly to do the lcall there.  I assum=
e=20
>>>Linux has something similar.  I think re-entering real mode and=20
>>>overloading the resume asm code to run just one instruction is a bit o=
f=20
>>>a hack.
>>
>>I don't think linux has a vm86 api at all.
>=20
> There's a vm86 api on i386 - see the vm86 manpage. It seems to have bee=
n
> introduced in 0.97.

I mean for the kernel and userland:
http://www.freebsd.org/cgi/cvsweb.cgi/src/sys/i386/i386/vm86.c?rev=3D1.56=
&content-type=3Dtext/x-cvsweb-markup
http://www.freebsd.org/cgi/cvsweb.cgi/src/sys/i386/i386/vm86bios.s?rev=3D=
1.30&content-type=3Dtext/x-cvsweb-markup
http://www.freebsd.org/cgi/cvsweb.cgi/src/sys/i386/include/vm86.h?rev=3D1=
.17&content-type=3Dtext/x-cvsweb-markup

If you import any of these, please respect the original copyright.

--=20
Nate


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
