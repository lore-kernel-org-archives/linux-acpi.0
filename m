From: Ow Mun Heng <Ow.Mun.Heng-Sjgp3cTcYWE@public.gmane.org>
Subject: Re: acpi patch for 2.6.7
Date: Wed, 08 Sep 2004 09:15:30 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1094606130.9577.41.camel@neuromancer.home.net>
References: <200409061331.28311@geromy>  <20040907135637.GC3647@fuchi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040907135637.GC3647@fuchi>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Acpi-List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2004-09-07 at 21:56, Sebastian Henschel wrote:
> hello S=C3=B6nke..
>=20
> * S=C3=B6nke <s.huels-hi6Y0CQ0nG0@public.gmane.org> [2004-09-07 15:29 +0200]:
> >=20
> > I'm looking for the last acpi patch for kernel 2.6.7=20
> > (acpi-20040715-2.6.7-diff), but I could not find it on the kernel.org f=
tp=20
> > server.=20
> > Could anyone please tell me to a location to download it, if it is stil=
l=20
> > availiable somewhere?
>=20
> i fear, it is not officially available anymore. you could try to
> integrate the ACPI stuff from 2.6.8 into your 2.6.7. or ping me again
> next week when i will have access to my backup harddisk which should
> have a copy of the patch on it.

The patch to 2.6.7 would be desireable since 2.6.8 and 2.6.9 doesn't
work reliably enough.

I've got another thread started that shows that  I have irq_disabled
errors in 2.6.8.1 and 2.6.9-rc1-mm1 causes filesystem curruption,
rm1-mm2, suspend code/something causes a need for a keyboard press to
start writing to swap. -rc1-mm3 does not compile at "make
modules_install"

>=20
> bye,
>  sebastian

--=20
Ow Mun Heng
Fedora GNU/Linux Core 2 on D600 1.4Ghz CPU kernel
2.6.7-2.jul1-interactive=20
Neuromancer 09:13:30 up 2:03, 5 users, load average: 0.87, 0.95, 0.99=20


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
