From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Fix wake GPE enabling
Date: Thu, 8 Apr 2004 09:32:35 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <37F890616C995246BE76B3E6B2DBE0554F1A3B@orsmsx403.amr.corp.intel.com>
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
To: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Takayoshi Kochi <kochi-S783fYmB3Ccdnm+yROfE0A@public.gmane.org>
Cc: linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


Found something in the ACPI Specification:

Section 5.6.2.2.1, "Wake Events" (Under "General-Purpose Event Handling)

"Events that wake may not be intermixed with non-wake events on the same
GPE input. Also, all wake events not exclusively tied to a GPE input
(for example, one input is shared for multiple wake events) need to have
individual enable and status bits in order to properly handle the
semantics used by the system."

Bob


> -----Original Message-----
> From: Moore, Robert
> Sent: Thursday, April 08, 2004 9:01 AM
> To: 'Takayoshi Kochi'
> Cc: linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org; Brown, Len; acpi-
> devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Grover, Andrew
> Subject: RE: [ACPI] Fix wake GPE enabling
>=20
>=20
> Comments below.
>=20
> > -----Original Message-----
> > From: Takayoshi Kochi [mailto:kochi-S783fYmB3Ccdnm+yROfE0A@public.gmane.org]
> > Sent: Thursday, April 08, 2004 6:50 AM
> > To: Moore, Robert
> > Cc: linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org; Brown, Len; acpi-
> > devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Grover, Andrew
> > Subject: Re: [ACPI] Fix wake GPE enabling
> >
> > Hi,
> >
> > From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > Subject: RE: [ACPI] Fix wake GPE enabling
> > Date: Wed, 7 Apr 2004 14:34:43 -0700
> >
> > >
> > > No, this does not fit the model correctly.
> > >
> > > It is the responsibility of the upper software to selectively
enable
> the
> > > devices which are to be used for wakeup.  This is one of the
functions
> > > of the AcpiGpeEnable interface.  The ACPI CA core cannot just
blindly
> > > enable all "wake" GPEs.
> > >
> > > The ACPI CA core simply identifies the "wake" GPEs in order to
leave
> > > them disabled during runtime.
> >
> > Hm, I might be misunderstanding, but my understanding is as follows
> > (this almost agrees with Dominik's second post):
> >
> > 1. Wake GPEs and runtime GPEs are _not_ exclusive but overwrapping
> >    by default.
> >    (Is it _explicitly_ stated in the spec that Wake GPE and runtime
> >     GPEs are exclusive?)
> >
> > 2. All GPEs should be enabled by default.
> >    Because in many AMLs Non-Wake GPEs are also used as runtime
> >    GPEs and we can't ignore them.  Are there *any magic* by which
> >    OSPM can know which Wake GPE is also runtime GPE?
>=20
> Not that I know of.  Wake and runtime GPEs should not be shared on the
> same GPE, see below.
>=20
> >    Should we list all the combination of every existing BIOS
> >    and wake-and-runtime GPE? :)
> >    Providing an interface of specifying which Wake GPE is actually
> >    runtime GPE sounds very silly idea (as you know, most people are
> _not_
> >    acpi savvy and even ACPI hackers has to disassemble and
understand
> >    which GPE does what for it).
>=20
>=20
> I'm not sure if this is explicitly stated in the spec.  However, here
are
> quotes from Microsoft (WinHec 2000)
>=20
> General Purpose Event (GPE) Routing For The Windows Operating System
>=20
> Jake Oshins
> Windows NT Base Development Lead
> Windows Division
> Microsoft Corporation
>=20
> GPE Architecture
> Golden rule
>     Wake events and runtime events must not be shared on the same GPE
>=20
>=20
> Processing Power Management Events
> In Windows 2000
>=20
> Stephane Plante
> Windows NT Base Developer
> Windows Division
> Microsoft Corporation
>=20
> Windows 2000 will only enable GPE when OS has a device that is enabled
for
> wake-up
>=20
> If the GPE is shared with RTC, Power, Sleep, or Lid switch the GPE
will
> always be enabled
>=20
> Otherwise, GPE will only be enabled if there are devices that are
enabled
> for wake-up
>=20
>=20
> >
> > 3. Upon entering sleep state, all GPEs should be disabled except
> >    Wake GPEs for appropriate levels of sleep.  Current
implementation
> >    ignores the second parameter of _PRW and thus it is considered
> >    incomplete, anyway.
> >
>=20
> I believe that the second parameter of _PRW should be used by the
upper
> OSPM software, not the ACPI CA core subsystem.  The core only uses
_PRW to
> "identify" wake GPEs.
>=20
> >    There might be APIs to set or reset the Wake flag (as well as
> >    lowest power state) of a GPE, in case one wants to set
> >    the flag manually, although the flag should be set
> >    automatically by parsing _PRW and these APIs are not needed
usually.
> >
> >    The ACPI_EVENT_WAKE_ENABLE flag for the AcpiEnableGpe()
> >    is unnecessary.
> >
>=20
> The purpose of ACPI_EVENT_WAKE_ENABLE is to allow the upper OSPM
software
> to enable individual wake GPEs for individual devices -- as per this
> quote:
>=20
> " Otherwise, GPE will only be enabled if there are devices that are
> enabled
> for wake-up"
>=20
> > So from my understanding, the current implementation of
> > _PRW and Wake GPEs needs revamp.
> >
>=20
> Linux needs a user interface and some additional OSPM software to
identify
> and program the wake devices, as well as handle the other information
in
> the _PRW methods.
>=20
> Again, the core subsystem will only identify wake vs. runtime GPEs.
>=20
> > Anyway, let's clarify what's wake GPEs and how to handle wake GPEs
> > first.
> >
> > Dominik, thanks for throwing this issue into discussion.
> >
> > ---
> > Takayoshi Kochi


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
