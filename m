From: Luca <kronos-0Y2hHv2PMqFeoWH0uzbU5w@public.gmane.org>
Subject: Re: pci device resume too early?
Date: Wed, 28 Jul 2004 23:06:02 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040728210602.GA26087@dreamland.darkstar.lan>
References: <200407281953.39159.stefandoesinger@gmx.at> <1091038485.15464.9.camel@tyrosine> <200407282118.52624.stefandoesinger@gmx.at>
Reply-To: kronos-0Y2hHv2PMqFeoWH0uzbU5w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: Quoted-Printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200407282118.52624.stefandoesinger-RbZlAiThDcE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stefan =?iso-8859-1?Q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Il Wed, Jul 28, 2004 at 09:18:52PM +0200, Stefan D=F6singer ha scritto:=20
> I moved device_resume(); in suspend_finish to be called after=20
> pm_ops->finish(state); and my system resumes MUCH nicer.
> Sound resume works, usb-uhci resume works, ehci pci restore works. My s=
uspend=20
> script will shink a lot.
>=20
> That's what suspend_finish looks like:
>=20
> static void suspend_finish(u32 state)
> {
> 	if (pm_ops && pm_ops->finish)
> 		pm_ops->finish(state);
> 	device_resume();	/*Call it after pm_ops->finish*/=09
> 	thaw_processes();
> 	pm_restore_console();
> }

Well, it may work but it's not correct. ->finish is meant to be called
to finalize the wakeup procedure *after* devices are waked up.

ACPI finish calls acpi_leave_sleep_state() and restore the waking
vectore. I'm not an ACPI guru but my guess is that what you need is
in acpi_leave_sleep_state().

If that's the case we may want to split the finish callback (say
prepare_wake and finish_wake).

Luca
--=20
Home: http://kronoz.cjb.net
"In linea di principio sarei indifferente al natale, se solo il natale
 ricambiasse la cortesia e mi lasciasse in pace." -- Marco d'Itri


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
