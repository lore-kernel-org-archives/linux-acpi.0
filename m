From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: can't switch CPU frequency while running on batterypower
Date: Wed, 7 Jan 2004 08:42:12 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <571ACEFD467F7749BC50E0A98C17CDD8E84E7A@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
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
To: Defiant <mail-4AGA6j5e2AhmdDG0eupGX0B+6BGkLq7r@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

When switching between AC and battery, _PPC method may return a =
different P-state limit. Please verify if 'cat =
/proc/acpi/processor/CPU0/limit' is different under the two situations.

Thanks,
Shaohua


> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Defiant
> Sent: 2004=C4=EA1=D4=C27=C8=D5 2:08
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: RE: [ACPI] can't switch CPU frequency while running on
> batterypower
>=20
> >> CONFIG_X86_ACPI_CPUFREQ=3Dy
> >> CONFIG_X86_ACPI_CPUFREQ_PROC_INTF=3Dy
> >
> > Please try patch filed at
> > http://bugzilla.kernel.org/show_bug.cgi?id=3D1489
>=20
> Tried the patch, but it didn't solved the Problem.
>=20
> Well at least I found out some more Info about.
> My full speed is 1600, low speed is 1200Mhz:
>=20
> When running on AC Adapter, I can switch the speed as often as I want.
> So If I set it to 1200 and then disconnect the AC, I can also switch
> between both speeds under battery power. Now If it is 1200 and I =
connect
> the AC I can not set it back to 1600.
> Well like I said in my preceding post it is the same: Running with AC,
> speed set to 1600, disconnecting the AC, I can not set the speed down =
to
> 1200.
>=20
> Hope that this wasn't that complicated (in my bad English),
> Erik Andresen
>=20
> --
>=20
> All I ask is a tall ship, and a star to steer her by
> > defiant.homedns.org <
>  -cause Experience is Knowledge
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.net email is sponsored by: IBM Linux Tutorials.
> Become an expert in LINUX or just sharpen your skills.  Sign up for =
IBM's
> Free Linux Tutorials.  Learn everything from the bash shell to sys =
admin.
> Click now! =
http://ads.osdn.com/?ad_id=3D1278&alloc_id=3D3371&op=3Dclick
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
