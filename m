From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Fix wake GPE enabling
Date: Thu, 8 Apr 2004 09:43:07 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <37F890616C995246BE76B3E6B2DBE0554F1A53@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Comments below.

> -----Original Message-----
> From: Dominik Brodowski [mailto:linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org]
> Sent: Wednesday, April 07, 2004 11:45 PM
> To: Moore, Robert
> Cc: Brown, Len; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Grover, Andrew
> Subject: Re: [ACPI] Fix wake GPE enabling
>=20
> On Wed, Apr 07, 2004 at 02:34:43PM -0700, Moore, Robert wrote:
> >
> > No, this does not fit the model correctly.
> >
> > It is the responsibility of the upper software to selectively enable
the
> > devices which are to be used for wakeup.  This is one of the
functions
> > of the AcpiGpeEnable interface.  The ACPI CA core cannot just
blindly
> > enable all "wake" GPEs.
>=20
> However, the ACPI subsystem, and I do not care whether it is the CA
core
> or
> any other part, currently does not enable any(!) wake GPEs.
>=20

Linux needs a user interface and some additional OSPM software to
identify and program the wake devices, as well as handle the other
information in the _PRW methods.

The ACPI CA core subsystem will only identify wake vs. runtime GPEs.

> -> wake_enable is not touched directly,
> -> events/evgpeblk.c does not care, and according to your opinion,
should
>    not care.
> -> acpi_enable_gpe is _only_ called by drivers/acpi/ec.c, which means
it
> is
>    _not_ called for buttons, which are very clearly needed in most
cases
> to
>    wake up a system.
>=20
> At least for buttons, the ACPI subsystem should enable their wake
> functionality, e.g. the wake GPEs, unconditionally. Having to manually
> enter
> "echo powerbutton > /proc/acpi/wakeup_devices", as the patch in bug
#1415
> suggests, seems to be overly complicated. However, having this file as
> override might be a valid option, I agree.
>=20

The ACPI CA core subsystem does NOT scan for particular devices (via the
_HID, _UID, etc.)  The upper OSPM software already does this and is thus
responsible for enabling individual devices and GPEs for wake-up,
including the power button, lid button, etc.  This code apparently still
needs to be written.


> > The ACPI CA core simply identifies the "wake" GPEs in order to leave
> > them disabled during runtime.
> >
> > Therefore, in (1) and (2) below, this is the correct behavior.  No
> > "wake" GPEs are enabled.
>=20
> IMHO, (2) is not correct behavior. It is a different thing to
> - disable wake GPEs during runtime,
> and
> - mark wake GPEs as runtime GPEs, which is what the current code does.
>=20

The purpose of the global flag is to either enable the differentiation
between wake/runtime GPEs or just ignore the difference and enable ALL
GPEs with a corresponding _Lxx or _Exx method at runtime (The latter is
the original behavior of the CA subsystem).

Probably the global could be named better, however.


> Also, as it has been experienced by Linus, for example[*], some "wake"
> GPEs are also useful to
> have during runtime, so the code in acpi_enable_gpe() which disables a
GPE
> marked as "wake" is flawed. IMO it should be able to set it to both
> RUNTIME and
> WAKE, if it's runtime, enable it during runtime, if it's wake, enable
it
> for
> wakeup.

>From the ACPI Specification 2.0C:

Section 5.6.2.2.1, "Wake Events" (Under "General-Purpose Event Handling)

"Events that wake may not be intermixed with non-wake events on the same
GPE input."

>=20
> [*] And that's the reason the acpi_disable_wake_gpes_during_runtime
flag
> is
> _not_ set to true in Linux 2.6.5, in contrast to the original ACPI
patch
> sent out. And I'm glad it is this way: with this flag set, my
notebook's
> keyboard stops functioning...
>=20
> 	Dominik


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
