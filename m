From: Pavel Machek <pavel@ucw.cz>
Subject: Re: C4 non-strangeness [was: C4 strangeness [was Re: [PATCH]
	i386 No Idle HZ aka dynticks 051221]
Date: Tue, 27 Dec 2005 17:13:59 +0100
Message-ID: <20051227161359.GF1822@elf.ucw.cz>
References: <200512210310.51084.kernel@kolivas.org>
	<20051225171617.GA6929@thunk.org> <20051226025525.GA6697@thunk.org>
	<20051226203806.GC1974@elf.ucw.cz>
	<20051226225246.GA9915@thunk.org>
	<20051226232712.GH1974@elf.ucw.cz>
	<20051227140325.GA1620@elf.ucw.cz>
	<20051227142238.GA1696@elf.ucw.cz>
	<20051227153330.GA32545@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <ck-bounces@vds.kolivas.org>
Content-Disposition: inline
In-Reply-To: <20051227153330.GA32545@isilmar.linta.de>
List-Unsubscribe: <http://bhhdoa.org.au/mailman/listinfo/ck>,
	<mailto:ck-request@vds.kolivas.org?subject=unsubscribe>
List-Archive: <http://bhhdoa.org.au/pipermail/ck>
List-Post: <mailto:ck@vds.kolivas.org>
List-Help: <mailto:ck-request@vds.kolivas.org?subject=help>
List-Subscribe: <http://bhhdoa.org.au/mailman/listinfo/ck>,
	<mailto:ck-request@vds.kolivas.org?subject=subscribe>
Sender: ck-bounces@vds.kolivas.org
Errors-To: ck-bounces@vds.kolivas.org
To: Dominik Brodowski <linux@dominikbrodowski.net>, Theodore Ts'o <tytso@mit.edu>, Con Kolivas <kernel@kolivas.org>, linux kernel mailing list <linux-kernel@vger.kernel.org>, Daniel Petrini <d.pensator@gmail.com>, Tony Lindgren <tony@atomide.com>, vatsa@in.ibm.com, ck list <ck@vds.kolivas.org>, Adam Belay <abelay@novell.com>, Zwane Mwaikambo <zwane@arm.linux.org.uk>, ACPI mailing list <acpi-devel@lists.sourceforge.net>, ipw2100-admin@linux.intel.com
List-Id: linux-acpi@vger.kernel.org

On =DAt 27-12-05 16:33:30, Dominik Brodowski wrote:
> Hi,
>=20
> On Tue, Dec 27, 2005 at 03:22:38PM +0100, Pavel Machek wrote:
> > So... I guess I found out what is going on.
> >=20
> > When power is unplugged, X32 adds C4 state. When power is plugged, X3=
2
> > removes C4 state (behaviour Ted seen). When I load ipw2200, this
> > behaviour stops, and I see everything up-to C4. Strange. I remember
> > ipw had some problems with C3 and C4, perhaps this is related?
>=20
> Nothing strange at all. The C-States are exported by the BIOS to the OS
> using the _CST method/object/whatever. This can change on runtime. When=
 the
> BIOS recognizes it is on battery power, the _CST contains the C4 state,=
 if
> it is on AC power, the _CST doesn't contain it. The ACPI code follows w=
hat
> it is told by the BIOS, for it has no chance to know about this additio=
nal
> C-State if on AC power, and it wouldn't be wise to second-guess the BIO=
S.
>=20
> Ipw does limit the max_cstate setting dynamically if it recognizes prob=
lems;
> however I haven't seen _any_ such things lately on my own system. Might=
 be
> related to dyntick being _enabled_, though ;-)

This was without dynticks... But why C4 availability no longer changes
(between AC and battery power) with ipw2200 loaded? I'd understand
higher C states being unavailable...
								Pavel
--=20
Thanks, Sharp!
