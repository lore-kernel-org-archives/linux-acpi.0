From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Re: [Swsusp-devel] ACPI A/C adaptor status not updated upon resume
Date: Thu, 17 Jul 2003 13:49:51 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A847E9704C@orsmsx401.jf.intel.com>
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
To: Nigel Cunningham <ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org>, EricAltendorf-gZ4DH+Stb0k@public.gmane.org
Cc: swsusp-devel <swsusp-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Well we actually are calling the _PSR control method to implement the
"state" proc entry. Of course, that's just calling a control method so
who knows what the control method does -- I'd have to see what _PSR
looks like...can you get your dsdt from /proc/acpi/dsdt, disassemble
with iasl -d and post what _PSR is?

Thanks -- Regards -- Andy

> -----Original Message-----
> From: Nigel Cunningham [mailto:ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org]=20
> Sent: Thursday, July 17, 2003 1:20 PM
> To: EricAltendorf-gZ4DH+Stb0k@public.gmane.org
> Cc: swsusp-devel; ACPI List
> Subject: [ACPI] Re: [Swsusp-devel] ACPI A/C adaptor status=20
> not updated upon resume
>=20
>=20
> That's ACPI, not swsusp - it must be toggling the state based=20
> on events,
> not actually detecting it.
>=20
> Regards,
>=20
> Nigel
>=20
> On Fri, 2003-07-18 at 08:06, Eric Altendorf wrote:
> > I'm still running an old version swsusp so I apologize if this has=20
> > already been addressed, but I figured I'd just make mention of it.
> >=20
> > If the laptop is resumed with a different A/C adaptor state (online=20
> > vs. offline) than when it was suspended, the /proc entry is=20
> incorrect=20
> > upon resume.  E.g., plug laptop in, suspend, unplug laptop, resume,
> > /proc/acpi/ac_adapter/ADP1/state  reports still online until a=20
> > subsequent plug/unplug event.
> >=20
> > Eric
> >=20
> >=20
> > -------------------------------------------------------
> > This SF.net email is sponsored by: VM Ware
> > With VMware you can run multiple operating systems on a=20
> single machine.
> > WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual=20
> machines at the
> > same time. Free trial click here:=20
> http://www.vmware.com/wl/offer/345/0
> >=20
> _______________________________________________
> > swsusp-devel mailing list
> > swsusp-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/swsusp-devel
> --=20
> Nigel Cunningham
> 495 St Georges Road South, Hastings 4201, New Zealand
>=20
> You see, at just the right time, when we were still powerless,
> Christ died for the ungodly.
> 	-- Romans 5:6, NIV.
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.net email is sponsored by: VM Ware
> With VMware you can run multiple operating systems on a=20
> single machine.
> WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual=20
> machines at the
> same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>=20


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
