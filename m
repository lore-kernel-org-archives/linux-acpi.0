From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [ACPI] [PATCH 1/2] 2.6: use scaling_available_freqs in
	acpi-cpufreq-ioport driver
Date: Thu, 26 Feb 2004 22:50:06 +0100
Sender: cpufreq-bounces@www.linux.org.uk
Message-ID: <20040226215006.GB397@elf.ucw.cz>
References: <20040220083149.GA10215@dominikbrodowski.de>
	<20040224125628.GA438@elf.ucw.cz>
	<20040224210040.GA8166@dreamcraft.com.au>
	<20040224221642.GB9145@elf.ucw.cz>
	<20040226172823.GJ2869@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20040226172823.GJ2869@poupinou.org>
List-Unsubscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=unsubscribe>
List-Archive: <http://www.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq@www.linux.org.uk>
List-Help: <mailto:cpufreq-request@www.linux.org.uk?subject=help>
List-Subscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=subscribe>
Errors-To: cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk
To: Bruno Ducrot <ducrot@poupinou.org>
Cc: Tomasz Ciolek <tmc@dreamcraft.com.au>, acpi-devel@lists.sourceforge.net, cpufreq@www.linux.org.uk
List-Id: linux-acpi@vger.kernel.org

On =C4=8Ct 26-02-04 18:28:23, Bruno Ducrot wrote:
> On Tue, Feb 24, 2004 at 11:16:42PM +0100, Pavel Machek wrote:

> > >  have a loook at the "userpace frequency governer" under 2.6.x=20
> >=20
> > That's not the same. frequency governor can select frequency *from th=
e
> > set provided by BIOS*. I want to override frequency/voltage table fro=
m
> > bios.
>=20
> It need to be done IMO in a driver, definitely not in cpufreq core, and
> worst that may need to be adapted to the acpi perflib certainly (when
> all pending patches for will go to mainstream I guess).

Well, it still looks pretty generic to me. Having same code in k7
and k8 drivers does not sound right.

Anyway, lets see what happens. If acpi mostly solves it, it is not
necessary.

> For now, you can adapt with something like the powernow-k7 override
> patches at http://www.poupinou.org/cpufreq/powernow-k7/ if really
> needed.

> Also, you should check that in fact the acpi perflib stuff will give
> you more accurate results.  For the powernow-k7 case, unfortunately, it
> sound like that acpi perflib whereas giving good results still could be
> problematics for some acer IIRC due to a bad VID for one entry, and the=
n
> it may be usefull for them to get the override patch merged IMO.

Hmm, if there's really only _one_ machine to fix, perhaps DMI
blacklist is the right solution.
							Pavel
--=20
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
