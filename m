From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: Re: s3_late_bios
Date: Tue, 09 Nov 2004 12:26:14 -0800
Message-ID: <419127E6.3000603@root.org>
References: <20041108144947.GA31267@tate.loria.fr> <20041108213558.GB4607@elf.ucw.cz> <418FEAD5.1000007@root.org> <20041109125522.GA8015@tate.loria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041109125522.GA8015-xkTd+U360DcAs8EywTwl9A@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?ISO-8859-1?Q?Emmanuel_Thom=E9?= <Emmanuel.Thome-MZpvjPyXg2s@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Emmanuel Thom=E9 wrote:
> On Mon, Nov 08, 2004 at 01:53:25PM -0800, Nate Lawson wrote:
>>Why the switch to real mode to run the BIOS call?  Can't this be done=20
>>from vm86 mode?
>=20
> Yes it can, at least I think so. You're welcome to tweak this to do it =
in
> a vm86 mode if you like.

I mostly work on FreeBSD and since it has clean vm86 support routines,=20
it doesn't involve any inline assembly to do the lcall there.  I assume=20
Linux has something similar.  I think re-entering real mode and=20
overloading the resume asm code to run just one instruction is a bit of=20
a hack.

--=20
Nate


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
