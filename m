From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Fix wake GPE enabling
Date: Thu, 8 Apr 2004 13:38:32 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <37F890616C995246BE76B3E6B2DBE0554F1C5F@orsmsx403.amr.corp.intel.com>
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
To: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Cc: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Nate,

Yes, the code below looks good.  This is the model that we have in mind
for the ACPI CA code, OSPM, and individual drivers.

Bob


> -----Original Message-----
> From: Nate Lawson [mailto:nate-Y6VGUYTwhu0@public.gmane.org]
> Sent: Thursday, April 08, 2004 10:48 AM
> To: Moore, Robert
> Cc: Dominik Brodowski; Brown, Len; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org;
> Grover, Andrew
> Subject: RE: [ACPI] Fix wake GPE enabling
>=20
> On Thu, 8 Apr 2004, Moore, Robert wrote:
> > Linux needs a user interface and some additional OSPM software to
> > identify and program the wake devices, as well as handle the other
> > information in the _PRW methods.
> >
> > The ACPI CA core subsystem will only identify wake vs. runtime GPEs.
> >
> > > -> wake_enable is not touched directly,
> > > -> events/evgpeblk.c does not care, and according to your opinion,
> > should
> > >    not care.
> > > -> acpi_enable_gpe is _only_ called by drivers/acpi/ec.c, which
means
> > it
> > > is
> > >    _not_ called for buttons, which are very clearly needed in most
> > cases
> > > to
> > >    wake up a system.
> > >
> > > At least for buttons, the ACPI subsystem should enable their wake
> > > functionality, e.g. the wake GPEs, unconditionally. Having to
manually
> > > enter
> > > "echo powerbutton > /proc/acpi/wakeup_devices", as the patch in
bug
> > #1415
> > > suggests, seems to be overly complicated. However, having this
file as
> > > override might be a valid option, I agree.
> > >
> >
> > The ACPI CA core subsystem does NOT scan for particular devices (via
the
> > _HID, _UID, etc.)  The upper OSPM software already does this and is
thus
> > responsible for enabling individual devices and GPEs for wake-up,
> > including the power button, lid button, etc.  This code apparently
still
> > needs to be written.
>=20
> You mean like this code snippet?
>=20
> -Nate
>=20
> acpi_button_attach(device_t dev)
> {
>     if (sc->fixed) {
>         AcpiClearEvent(event);
>         status =3D AcpiInstallFixedEventHandler(event,
>                         acpi_button_fixed_handler, sc);
>     } else {
>         status =3D AcpiInstallNotifyHandler(sc->button_handle,
>                         ACPI_DEVICE_NOTIFY,
acpi_button_notify_handler,
> sc);
>     }
>=20
>     acpi_device_enable_wake_capability(sc->button_handle, 1);
> }
>=20
> acpi_button_suspend(device_t dev)
> {
>     struct acpi_button_softc    *sc;
>=20
>     sc =3D device_get_softc(dev);
>     acpi_device_enable_wake_event(sc->button_handle);
>     return (0);
> }
>=20
> acpi_device_enable_wake_capability(ACPI_HANDLE h, int enable)
> {
>     /*
>      * All Power Resources referenced by elements 2 through N
>      * of the _PRW object are put into the ON state.
>      */
>=20
>     (void)acpi_SetInteger(h, "_PSW", enable);
> }
>=20
> acpi_device_enable_wake_event(ACPI_HANDLE h)
> {
>     status =3D AcpiEvaluateObject(h, "_PRW", NULL, &prw_buffer);
>     if (ACPI_FAILURE(status))
>         return;
>=20
>     switch (res->Package.Elements[0].Type) {
>     case ACPI_TYPE_INTEGER:
>         /*
>          * If the data type of this package element is numeric, then
this
>          * _PRW package element is the bit index in the GPEx_EN, in
the
>          * GPE blocks described in the FADT, of the enable bit that is
>          * enabled for the wake event.
>          */
>         status =3D AcpiEnableGpe(NULL, res-
> >Package.Elements[0].Integer.Value,
>                                ACPI_EVENT_WAKE_ENABLE);
> }


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
