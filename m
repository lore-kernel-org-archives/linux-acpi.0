From: Damien Sandras <damien.sandras-zdNq1GPRXr2akBO8gow8eQ@public.gmane.org>
Subject: Re: Re: Tell user when ACPI is killing machine
Date: Thu, 04 Dec 2003 11:01:16 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1070532076.1645.42.camel@golgoth01>
References: <3ACA40606221794F80A5670F0AF15F8401720BFD@pdsmsx403.ccr.corp.intel.com>
	 <20031204095454.GC6911@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031204095454.GC6911-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Aaron Lehmann <aaronl-nCTQwlqzmeJBDgjK7y7TUQ@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

I have a similar problem since test10 and test11 (2.4.23 is ok, test9 is
ok too). ACPI reports bogus temperatures and powers the machine down.

If you have a patch that could fix that problem, I'm ready to try it and
report success or failure ;)

Le jeu 04/12/2003 =E0 10:54, Pavel Machek a =E9crit :
> Hi!
>=20
> > >cpufreq is not connected to acpi thermal subsystem. Dominik has some
> > >patches to change that, IIRC.
> > Is it merged into ACPI ?
>=20
> Not yet, IIRC. It is pretty big patch.
> 								Pavel
--=20
 _      Damien Sandras
(o-    =20
//\     It-Optics s.a.
v_/_    GnomeMeeting: http://www.gnomemeeting.org/
        FOSDEM 2004:  http://www.fosdem.org
        H.323 phone:  callto:ils.seconix.com/dsandras-AvcYnRpcIedBDgjK7y7TUQ@public.gmane.org



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
