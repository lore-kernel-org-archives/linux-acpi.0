From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI/ECDT on gateway 200x notebook
Date: Wed, 14 Jan 2004 10:23:56 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8401720CCA@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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
To: Greg Sarjeant <greg-QNIYhHqVzB9kr2E5YSwMOQ@public.gmane.org>, Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Greg,

Thanks for your information. I think It's important to append your
conclusion to=20
bug 1744.  To any new issue, you can just file a new one, But it should
be
Linux ACPI bug.

Thanks,
Luming

> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
> [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
> Greg Sarjeant
> Sent: Tuesday, January 13, 2004 11:27 PM
> To: Ducrot Bruno
> Cc: Li, Shaohua; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Re: [ACPI] ACPI/ECDT on gateway 200x notebook
>=20
>=20
> Hi,
>=20
>    I just wanted to send along an update on this, rather than=20
> continue to clutter bug 1744 with potentially unrelated issues.
>=20
>    First off, the AE_BAD_PARAMETER issue is defiintely caused=20
> by the DWordAcc in the _GPE method. Using the bit_width patch=20
> from bug 1744 masks this error. Overriding the DSDT with the=20
> new Gateway 200X DSDT on acpi.sourceforge.net fixes it. Both=20
> of these options restore fan, thermal and button=20
> functionality. The lid is not fully supported with the=20
> bit_width patch, but the fixed DSDT restores the lid fully.=20
> The adapter and battery are still missing after applying=20
> either solution. This is apparently because of the missing ECDT.
>=20
>    To fix the ECDT problem, I have now tried both this patch=20
> and the fake_ecdt patch that can be found somewhere in this=20
> thread: =
http://sourceforge.net/mailarchive/message.php?msg_id=3D6514510
>=20
>    I have used them with kernel 2.4.23 and 2.4.24. As far as=20
> I know, neither will apply to 2.6.x. Both patches restore the=20
> ac adapter and the battery, which is terrific. The parameter=20
> to pass to the kernel for the fake_ecdt patch is:
>=20
>    ecdt_fake=3D0x66:0x62:0x1c:0x01:\_SB_.PCI0.LPCB.H_EC
>=20
>    There are two differences between the approaches. The=20
> fake_ecdt patch yields a single H_EC subdirectory under=20
> /proc/acpi/embedded_controller, while the bugzilla patch=20
> gives me two. However, using the fake_ecdt patch gives me an=20
> error in dmesg which is not present with the other patch. The=20
> relevant section is:
>=20
> ACPI: Faking ECDT
> schedule_task(): keventd has not started
> evregion-0249 [21] ev_address_space_dispa: no handler for=20
> region(df6d0188) [SystemMemory]
>  exfldio-0282 [20] ex_access_region      : Region=20
> SystemMemory(0) has no handler
>  psparse-1120: *** Error: Method execution failed=20
> [\_SB_.PCI0.LPCB.H_EC._REG] (Node c15dfae8), AE_NOT_EXIST
> ACPI: Could not use ECDT
>=20
>=20
>    Note that it says that it couldn't use the ECDT, but I do=20
> have my battery and adapter info, so I think it is. I'm not=20
> exactly sure what this error means, or if it is anything to=20
> be concerned about, since I dont see it with the other patch.=20
> Any ideas?
>=20
>    Also, please let me know if I should append this to bug=20
> 1744. I think that we already have two unrelated problems=20
> being covered there (buggy DSDT and missing ECDT), and I=20
> didn't want to introduce a third ;)
>=20
>    Thanks,
>     Greg
>=20
>=20
>=20
> On Wed, 7 Jan 2004 11:54:24 +0100
> Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org> wrote:
>=20
> > On Wed, Jan 07, 2004 at 09:04:25AM +0800, Li, Shaohua wrote:
> > > Yes, the patch may resolve some problems, but it is just=20
> a workaround. I guess a possible solution is if ECDT is=20
> lacked, scan namespace to get EC device's info, such as GPE,=20
> IO ports, then use these info to automatically make a fake=20
> ECDT. Because getting info doesn't involve any operating on=20
> EC device, it's feasible. A problem is if a system has more=20
> than 1 EC, how do we?
> > >=20
> >=20
> > Yes, exactly.  Anyway, io ports 0x62, 0x66 are the legacy access
> > for the "main" EC.  Perhaps checking those ports and initilializing
> > that one only may be OK?
> >=20
> > --=20
> > Ducrot Bruno
> >=20
> > --  Which is worse:  ignorance or apathy?
> > --  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
