From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: Re: s3_late_bios
Date: Wed, 10 Nov 2004 11:56:12 +0000
Message-ID: <1100087772.6014.5.camel@tyrosine>
References: <20041108144947.GA31267@tate.loria.fr>
	 <20041108213558.GB4607@elf.ucw.cz> <418FEAD5.1000007@root.org>
	 <20041109125522.GA8015@tate.loria.fr> <419127E6.3000603@root.org>
	 <20041110072003.GA13561@tate.loria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041110072003.GA13561-xkTd+U360DcAs8EywTwl9A@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 2004-11-10 at 08:20 +0100, Emmanuel Thom=C3=A9 wrote:
> On Tue, Nov 09, 2004 at 12:26:14PM -0800, Nate Lawson wrote:
> > I mostly work on FreeBSD and since it has clean vm86 support routines,=20
> > it doesn't involve any inline assembly to do the lcall there.  I assume=
=20
> > Linux has something similar.  I think re-entering real mode and=20
> > overloading the resume asm code to run just one instruction is a bit of=
=20
> > a hack.
>=20
> I don't think linux has a vm86 api at all.

There's a vm86 api on i386 - see the vm86 manpage. It seems to have been
introduced in 0.97.

--=20
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
