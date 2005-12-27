From: Pavel Machek <pavel@ucw.cz>
Subject: C4 strangeness [was Re: [PATCH] i386 No Idle HZ aka dynticks
	051221]
Date: Tue, 27 Dec 2005 15:22:38 +0100
Message-ID: <20051227142238.GA1696@elf.ucw.cz>
References: <200512210310.51084.kernel@kolivas.org>
	<20051225171617.GA6929@thunk.org> <20051226025525.GA6697@thunk.org>
	<20051226203806.GC1974@elf.ucw.cz>
	<20051226225246.GA9915@thunk.org>
	<20051226232712.GH1974@elf.ucw.cz>
	<20051227140325.GA1620@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <ck-bounces@vds.kolivas.org>
Content-Disposition: inline
In-Reply-To: <20051227140325.GA1620@elf.ucw.cz>
List-Unsubscribe: <http://bhhdoa.org.au/mailman/listinfo/ck>,
	<mailto:ck-request@vds.kolivas.org?subject=unsubscribe>
List-Archive: <http://bhhdoa.org.au/pipermail/ck>
List-Post: <mailto:ck@vds.kolivas.org>
List-Help: <mailto:ck-request@vds.kolivas.org?subject=help>
List-Subscribe: <http://bhhdoa.org.au/mailman/listinfo/ck>,
	<mailto:ck-request@vds.kolivas.org?subject=subscribe>
Sender: ck-bounces@vds.kolivas.org
Errors-To: ck-bounces@vds.kolivas.org
To: Theodore Ts'o <tytso@mit.edu>, Con Kolivas <kernel@kolivas.org>, linux kernel mailing list <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Daniel Petrini <d.pensator@gmail.com>, Tony Lindgren <tony@atomide.com>, vatsa@in.ibm.com, ck list <ck@vds.kolivas.org>, Adam Belay <abelay@novell.com>, Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: ACPI mailing list <acpi-devel@lists.sourceforge.net>, ipw2100-admin@linux.intel.com
List-Id: linux-acpi@vger.kernel.org

On =DAt 27-12-05 15:03:25, Pavel Machek wrote:
> On =DAt 27-12-05 00:27:12, Pavel Machek wrote:
> > On Po 26-12-05 17:52:48, Theodore Ts'o wrote:
> > > On Mon, Dec 26, 2005 at 09:38:06PM +0100, Pavel Machek wrote:
> > > > Stupid IBM. I've seen it appearing/disappearing, but did not work=
 out
> > > > when.
> > > >=20
> > > > No-C4-on-AC is bad -- if you just disconnect AC and walk away, yo=
u are
> > > > running without benefits of C4. Bad. Changing benchmarks dependin=
g on
> > > > you booting on AC or battery also look nasty.
> > >=20
> > > The moment you disconnect AC, it C4 automagically appears.  When yo=
u
> > > reconnect to the AC mains, the C4 state disappears again, at least
> > > from the listing displayed by /proc/acpi/processor/CPU0/power.  So =
the
> > > first issue you brought up isn't a problem.
> >=20
> > It does not seem to work like that here. I'm not sure what the exact
> > rules are, but I know that I sometimes have C4 and sometimes not. I
> > have C4 now, and it is used, even when I'm on AC power. Thinkpad
> > X32.
>=20
> Well, today it _does_ behave like Theodore described (slightly
> different kernel, and I'm using power supply, not docking
> station). Strange.

So... I guess I found out what is going on.

When power is unplugged, X32 adds C4 state. When power is plugged, X32
removes C4 state (behaviour Ted seen). When I load ipw2200, this
behaviour stops, and I see everything up-to C4. Strange. I remember
ipw had some problems with C3 and C4, perhaps this is related?

								Pavel
--=20
Thanks, Sharp!
