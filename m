From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: acpi on new gateway laptops
Date: Mon, 17 Nov 2003 10:25:00 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031117102219.O60721@root.org>
References: <20031112232315.GD430@masanjin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031112232315.GD430-xW3KcqxHEMnk1uMJSBkQmQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: William Morgan <wmorgan-acpi-devel-xW3KcqxHEMnk1uMJSBkQmQ@public.gmane.org>
Cc: Casey Harkins <charkins-TFaeeA7fOO6Gwcnyzrk3/w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 12 Nov 2003, William Morgan wrote:
> It seems like having an ECDT is an optional feature? If that's so, then
> what's the problem? Why isn't Linux simply "discovering and enumerating"
> the "Embedded Controller device in the AML namespace"?

Yes, it's optional.

> > The reason is BIOS of Gateway 400VTX lacks ECDT table.  And before
> > initialize EC device, DSDT use ec space region when execute some ASL
> > init methods. This will cause that battery can't be initializing.
>
> So, what I *think* is happening, based on that, and on pp.203--204, is:
>
> There's an Embedded Controller region (In the BIOS? In the DSDT?). One

in the DSDT

> cannot access a region until registering it, by calling
> _REG(RegionSpace, 1). There's an exception to this, however, when using
> an ECDT, which describes "controllers" (?) to access the Embedded
> Controller region. If you have an ECDT you can then access this region
> before registering it. So I think that's what the DSDT is doing, but
> without providing an ECDT?
>
> So. This implies that rather than provide an ECDT, we can alternately
> try and fix the DSDT. Since it's buggy anyways, that might conserve some
> effort, and has the nice advantage of not forcing an upgrade to ACPI 2.0.
> (Assuming I am ACPI 1.0 like you.)

Your DSDT attempts to access regions before there is an attached EC to
service the calls to that space, yes.  So the two approaches are to
provide an ECDT or change the DSDT to not reference those spaces early in
boot.  The problem with the latter option is that those accesses may be
crucial to initializing your laptop.  So if you remove them, it may start
up in a partially initialized state.  It's probably cleaner to provide an
ECDT.

-Nate


-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
