From: "Ow Mun Heng" <ow.mun.heng-Sjgp3cTcYWE@public.gmane.org>
Subject: RE: problems with acpi (sleep states) on vaio notebook z1sp
Date: Wed, 24 Dec 2003 09:47:56 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C386328088ED7F4E9F81AFBABDDF60DA03B3670B@wdmyexch02.my.asia.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Micha Feigin <michf-+lLcF8/aw9x6auLlOhE+pQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Micha Feigin [mailto:michf-+lLcF8/aw9x6auLlOhE+pQ@public.gmane.org]
> Sent: Wednesday, December 24, 2003 12:31 AM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Re: [ACPI] problems with acpi (sleep states) on vaio notebook
> z1sp
>=20
> On Tue, Dec 23, 2003 at 03:43:23PM +0800, Ow Mun Heng wrote:
> > Only problem is my Date&Time is screwed up. It keeps the Time&Date =
at
the
> > time of sleep!!! I'm not sure if that's due to ACPI or something =
else..
> >=20
>=20
> Its probably because the system keeps its own time and on=20
> syncs it with the hardware clock on bootup and shutdown (maybe a cron =
job,
don't
> know). Try suspend using
>=20
> acho 3 /proc/acpi/sleep && hwclock --hctosys


I think you are right.. I will check it out..=20

Each time I reboot/shutdown, I notice that it syncs with the hardware =
clock.

I will look into the startup/shutdown scripts.

I will try your suggestion..

Thanks


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
