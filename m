From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: gpe-handler / acpi on ASUSL2400D
Date: Wed, 26 Mar 2003 13:42:53 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A847E96D6E@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
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
To: Sebastian Thias <post-OXl1b/uZKHizQB+pC5nmwQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Have you tried the patch against 2.5.65 at sf.net/projects/acpi ?

I'm thinking this is another symptom of our ignoring of GPE1, which =
that
patch fixes.

-- Andy

> -----Original Message-----
> From: Sebastian Thias [mailto:post-OXl1b/uZKHizQB+pC5nmwQ@public.gmane.org]=20
> Sent: Wednesday, March 26, 2003 1:31 PM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Re: [ACPI] gpe-handler / acpi on ASUSL2400D
>=20
>=20
> Am Mittwoch 26 M=E4rz 2003 19:57 schrieben Sie:
> > > From: Sebastian Thias [mailto:post-OXl1b/uZKHizQB+pC5nmwQ@public.gmane.org]
> > > i'm a newbie on both acpi- and kernel-programming.
> > > I've got an ASUSL2400D-laptop and kenel 2.5.65.
> >
> > Sounds like you're a quick learner. :)
>=20
> Well, to be honest I started yesterday at noon. After a=20
> couple of dozens of
> kernel-crashes things started to get working :-)
>=20
> >
> > > Upon pressing one of my laptops hotkeys, I receive an error
> > > message about
> > > a missing gpe-handler.
> > > After fiddling a bit, I wrote a module that installs a
> > > gpe-handler for 0x1D
> > > (the one triggered by my hotkeys). The handler calls
> > > "\_GPE._L1D" (using
> > > acpi_evaluate_object ...). Only then can I receive=20
> notify-events for
> > > "\_SB_.HOTK" and only then buttons like switching
> > > LCD-Backlights off or
> > > changing the brightness work.
> > >
> > > My question: Why do I have to install a gpe-handler by myself
> > > if there is
> > > a mehod "\_GPE._L1D" in dsdt. Is that the usual way to do=20
> such things?
> >
> > Is the button driver installed?
>=20
> Yes. Powerbutton works. I compiled all drivers into the=20
> kernel. Lid state is=20
> also reported correctly, but I don't receive Lid events. If I=20
> try to install=20
> a notify-handler for the lid, I get returned, that there is=20
> already a handler=20
> present.
>=20
> >
> > The usual way is that you have a driver (e.g. for the lid=20
> button) that
> > registers for notifications on the lid device. When the lid=20
> button is
> > pressed, it generates a GPE, which the lid driver finds out about
> > because the core calls the GPE method associated with the GPE (e.g.
> > _L1D) and that method does a Notify() on the lid device.=20
> The lid device
> > gets the notification and tells power policy via /proc/acpi/event.
> >
> > I'm not quite clear what is happening in your case. Can you=20
> elaborate
> > further?
> >
> > Regards -- Andy
>=20
> As I said before, the only "button-like" thing that is=20
> working, is the=20
> power-button. Any other button produces:
>    "acpi_ev_gpe_dispatch[...] No handler present for GPE[00],=20
> disabling=20
> event."
> (the gpe number is incorrect. The dispatch code always tells=20
> "00", regardless=20
> which gpe has really been triggered)
>=20
> If I install my gpe-handler that calls _L1D "manually", I can=20
> also receive=20
> sleep-button events in /proc/acpi/events. The other hotkeys=20
> also work then=20
> (when a "\_SB_.HOTK" notify-handler is installed). Lid-events=20
> are still not
> reported.
>   If I interpret your answer correctly, it seems that the=20
> core does NOT call
> the _L1D method. What could be the reason for this? Do you want to =
see
> my dsdt?
>=20
> Greetings
>       Sebastian
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.net email is sponsored by:
> The Definitive IT and Networking Event. Be There!
> NetWorld+Interop Las Vegas 2003 -- Register today!
> http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>=20


-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
