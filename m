From: "Rockefeller, Harry" <harryr-UjZhlPPWhclBDgjK7y7TUQ@public.gmane.org>
Subject: RE: Battery alarm ->  was General Questions:
Date: Fri, 4 Feb 2005 14:20:58 -0600
Message-ID: <B774920D825C2D4880A3C1B0D6EF94180341518F@ssdmx.ssd.fsi.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-TtF/mJH4Jtrk1uMJSBkQmQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

We all need a good laugh once in a while.
Just in case the humor is missed ...

[Grin] and another [Grin]

> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
> [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
> Jeremy Moles
> Sent: Friday, February 04, 2005 12:14 PM
> To: acpi-devel-TtF/mJH4Jtrk1uMJSBkQmQ@public.gmane.org
> Subject: Re: [ACPI] Battery alarm -> was General Questions:
>=20
> I'm not trying to hijack or anything, but since I posted=20
> "part" of whats
> being pinged, I thought I might try and jump in on the good offers!
>=20
> I have two _BPT, one per battery. This is the Method:
>=20
> Method (_BTP, 1, NotSerialized) {
>   SX10 ()
>   SX30 (0x03)
>   SX30 (0x01)
>   SX32 (Arg0)
>   SX11 ()
>   SX12 ()
>   Sleep (0xFA)
> }
>=20
> I have the spec PDF, I just haven't had time to really read=20
> through it.
> Can anyone tell offhand what is wrong w/ mine that would=20
> cause it to not
> generate noise when the battery is low? :)
>=20
> I'm sure I'll get around to eventually, though. I plan on printing the
> spec PDF this weekend, 4 pages per page, double sided. :)
>=20
> > Rockefeller, Harry wrote:
> >=20
> > <snip>
> >=20
> > >=20
> > > My notebook, Uniwill N351S1, is - supposedly - both APM=20
> and ACPI 2.0
> > > supported.  Would something as important as battery alarm=20
> simply not
> > > be implemented in ACPI?
> >=20
> > Certainly. Many manufacturers have broken ACPI=20
> implementations; as far=20
> > as they're concerned, if it works with Windows, then it=20
> "works". It's=20
> > probably the case that Windows polls the battery, rather=20
> than relying on=20
> > the alarm, so that broken implementations will still function.
> >=20
> > > FWIW, /proc/acpi/battery/BAT0/info gives both design=20
> capacity warning
> > > and low data.
> >=20
> > These are fixed (non-settable) quantities, that have little=20
> to do with=20
> > the alarm.
> >=20
> > >=20
> > > A 'grep BTP dsdt.dsl' turns up:      BTP0,     16,
> >=20
> > But no _BTP, which means no alarm.
> >=20
> > >=20
> > > Can I modify dsdt.dsl to add this ACPI function myself?
> >=20
> > In principle, yes. If you like, I can have a look at your=20
> DSDT to see=20
> > how easy it would be to add in _BTP.
> >=20
> > cheers,
> >=20
> > Rich

[snip]
=20
> Jeremy L. Moles
> EmperorLinux
> 1-888-651-66
> www.EmperorLinux.com
> jeremy-LdSqz1EEwCk7YuNMryXyOw@public.gmane.org

[snip]

Go ahead and help Jeremy, his job may depend on it. ;-)


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
