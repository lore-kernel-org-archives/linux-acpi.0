From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH v4] dell-wmi: Support new hotkeys on the XPS 13 9350
 (Skylake)
Date: Sat, 30 Jan 2016 09:56:40 -0800
Message-ID: <20160130175640.GA1862@malice.jf.intel.com>
References: <a343d7d11816d86d04c51505f6e33c5b99086ff6.1453244706.git.luto@kernel.org>
 <20160120194050.GL7192@pali>
 <CALCETrUqH7FLPyHasx020vyjZNtTdVSk+0LJKcGjXyj+iwE8Dw@mail.gmail.com>
 <20160130170411.GB1749@malice.jf.intel.com>
 <CALCETrVZ06EpseG9Rkr59rB4QboAJhMEremQrQ1oLxxNrDTKWA@mail.gmail.com>
 <20160130174545.GD9269@malice.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160130174545.GD9269@malice.jf.intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Andy Lutomirski <luto@kernel.org>, platform-driver-x86@vger.kernel.org, Mario Limonciello <mario_limonciello@dell.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Jon Eyolfson <jon@eyl.io>
List-Id: linux-acpi@vger.kernel.org

On Sat, Jan 30, 2016 at 09:45:45AM -0800, Darren Hart wrote:
> On Sat, Jan 30, 2016 at 09:17:47AM -0800, Andy Lutomirski wrote:
> > On Sat, Jan 30, 2016 at 9:04 AM, Darren Hart <dvhart@infradead.org>=
 wrote:
> > > On Wed, Jan 20, 2016 at 12:46:23PM -0800, Andy Lutomirski wrote:
> > >> On Wed, Jan 20, 2016 at 11:40 AM, Pali Roh=E1r <pali.rohar@gmail=
=2Ecom> wrote:
> > >> > On Tuesday 19 January 2016 15:07:47 Andy Lutomirski wrote:
> > >> >> The XPS 13 9350 sends WMI keypress events that aren't enumera=
ted in
> > >> >> the DMI table.  Add a table listing them.  To avoid breaking =
things
> > >> >> that worked before, these un-enumerated hotkeys won't be used=
 if the
> > >> >> DMI table maps them to something else.
> > >> >>
> > >> >> FWIW, it appears that the DMI table may be a legacy thing and=
 we
> > >> >> might want to rethink how we handle events in general.  As an
> > >> >> example, a whole lot of things map to KEY_PROG3 via the DMI t=
able.
> > >> >>
> > >> >> So far, this doesn't send keypress events for any of the new
> > >> >> events.  Depnding on whether we figure out exactly what needs=
 to
> > >> >> happen to get the wireless button working in time for Linux 4=
=2E5,
> > >> >> we might want to temporarily handle it in dell-wmi.
> > >> >>
> > >> >> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> > >> >
> > >> > Looks good,
> > >> >
> > >> > Reviewed-by: Pali Roh=E1r <pali.rohar@gmail.com>
> > >>
> > >> Darren, if/when you apply this, can you fix up the last paragrap=
h of
> > >> the commit message?
> > >>
> > >>     This doesn't send keypress events for any of the new
> > >>     events, as no models appear to require it.
> > >>
> > >> I wrote the old text before intel-hid landed.
> > >>
> > >> --Andy
> > >
> > > This had some problems applying to 4.5-rc1 (refactoring of handle=
_dmi_...). I've
> > > done the merge, it builds, but I can't test it. Please have a loo=
k at the
> > > dell-wmi branch and let me know if this is correct and working as=
 expected.
> > >
> >=20
> > It's probably okay, but I think you applied it out of order.  This
> > patch was intended to be applied after the handle_dmi_xyz fixes.  I=
f
> > you back this one out, apply those, and then re-apply this, it shou=
ld
> > apply cleanly.
> >=20
> > --Andy
>=20
> Ah, thanks. Sometimes that gets lost in the INBOX, I was starting to =
think the
> same thing as I went through the patchwork list though. I'll back it =
out and do
> that. Thanks!

Turns out I wasn't Cc'd on the dependent dmi fixes series. Please inclu=
de me on
Cc for patches where I show up as a maintainer.

--=20
Darren Hart
Intel Open Source Technology Center
