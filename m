From: Keld =?iso-8859-1?Q?J=F8rn?= Simonsen <keld-6PR53cSIHaE@public.gmane.org>
Subject: Re: problem with cpu eating too much power, prize given if solved
Date: Fri, 25 Jun 2004 19:06:32 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040625170632.GB16151@rap.rap.dk>
References: <20040624153513.GB19545@rap.rap.dk> <opr930o2uv4evsfm@smtp.pacific.net.th> <20040625124637.GA14795@rap.rap.dk> <opr95qdzjj4evsfm@smtp.pacific.net.th>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <opr95qdzjj4evsfm-TBR8pM7LtsqkE96DxU8f+dAkNl5+tjhE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Michael Frank <mhf-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
Cc: Keld =?iso-8859-1?Q?J=F8rn?= Simonsen <keld-6PR53cSIHaE@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Jun 25, 2004 at 11:52:37PM +0800, Michael Frank wrote:
> On Fri, 25 Jun 2004 14:46:38 +0200, Keld J=F8rn Simonsen <keld-6PR53cSIHaE@public.gmane.org=
>=20
> wrote:
>=20
> >On Fri, Jun 25, 2004 at 01:40:04AM +0800, Michael Frank wrote:
> >>On Thu, 24 Jun 2004 17:35:13 +0200, Keld J=F8rn Simonsen <keld-8HOPs2i1G8k@public.gmane.org=
dk>
> >>wrote:
> >>
> >>>Dear ACPI developers,
> >>>I have a problem with my Acer Travelmate 233.
> >>>Many times I just want to read the screen, eg emails or documents,
> >>>and then still the cpu will be in idle mode, where
> >>>it uses 7.5 W out of the about 15 W that the whole machine uses.
> >>>I have found out from Intel data sheets that my
> >>>Mobile Intel Celeron 2.0 GHz CPU consumes 7.5 W in idle loop/
> >>>stop grant/sleep states, (and 5.0 W i deep sleep state).
> >>>So I would like to have the CPU stopped completely (consuming 0 W)
> >>>while I still could read the screen. In that way I should
> >>>be able to have about double the lifetime on the battery,
> >>>going to about 7 hours from the 3.5 hours I have now.
> >>>I would like the machine to wake up again by any keystroke
> >>>on the keyboard or mouse input. I would like the input to be
> >>>reacted upon (not just used to wake up the system, and
> >>>then forgotten).
> >>>I do not have the skills to program this myself, so
> >>>instead I offer a prize of USD 1000 to the person(s) that
> >>>can give me a patch for kernel 2.6 and appropiate documentation
> >>>that can solve the above problem. The patch needs to be GPL,
> >>>and demonstrably run on my laptop. I need the patch before
> >>>2004-10-01, after what date the prize offer expires.
> >>>I would like that the patch was written in a general way to cover fo=
r
> >>>CPUs that burn considerable power in idle loop and other states, so =
that
> >>>other users can benefit from it. Also I would prefer that the patch =
be
> >>>rolled into the normal ACPI kernel source tree, but the latter reque=
st
> >>>is not a condition for the prize.
> >>>
> >>
> >>Nice idea but it wont be possible to program it as your hardware powe=
rs
> >>the CPU which takes 5w while it is powered. There is no partitioning
> >>which allows you to remove power from the CPU while running the rest
> >>and I am not aware of any system or standards which provide this kind
> >>of partitioning...
> >
> >Well, I don't know so much about ACPI, but I thought that you in S2
> >could shut down devices individually, and then at the end for my
> >purpose shut down the CPU completely, like a suspend to memory.
> >But maybe this is not doable.
> >
>=20
> Again it's a nice idea.
>=20
> Again, It is a HW issue not ACPI issue because ACPI can only do
> what the HW supports.

I don't know if the HW supports it, or it is the BIOS or what needs to
be done. But I know that the SW can shut down the CPU, and then be
awaken by keyboard keystrokes.

> What you are asking is to put the CPU into S2 while the system
> does not notice.  You want CPU to respond to IO like keystrokes and
> mouse, the cursor should blink (I assume you don't need play videos),
> the kernels clock gets updated, all without using electricity when
> it's truly idle.

It does not matter if the screen does not blink.

> The keystrokes and mouse could be handled by 8042 equivalent,
> starting the CPU, but what about the cursor driven by X and other
> interrupts and DMA by peripherials which are active?

My idea was that new keystrokes or mouse movements would be considered=20
ACPI events that - after the CPU has been shut down - can awake the
system again.

I dont know what other DMA activities should be honored, for my purpose
I believe DMA can be ignored - or maybe treated as an ACPI event.
In the first try on this, it could be ignored.

The cursor - why should it move - if no program is running?

> Your CPU Powersupply would have to go from 0V to normal conditions
> for every action required and CPU state would have to be restored the
> little job done and state saved and CPU powered down again.

Yes, I think that should be done.

> Todays  HW _can_not_ do this at all. Theoretical best case latency of
> core  power supplies will be several milliseconds from 0V, which is
> too slow to handle individual interrupts.

Maybe in the wakeup phase there will be no other interrupts?
For my use, just reading the screen, and then taking to the keyboard or
the mouse, I would not expect other interrupts. It would be acceptable
to me if other interrupts were not handled during the startup of the
CPU. I think startup would last 50 - 100 ms, which is acceptable
to me, I think I would still save considerable power.


> Perhaps one day they fix the leakage problems (they do better all the
> time) or come up with a multi core CPU which has an slow core doing
> 100s of MHz to keep things idling along and a facility to decouple the
> multi GHz core(s) for power down unless really needed.

Yes, but that would not improve things on my current laptop.

Best regards
Keld


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
