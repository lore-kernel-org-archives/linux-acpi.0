From: liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Subject: Re: Battery status reading problems
Date: Tue, 23 Sep 2003 20:11:38 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.58.0309232001000.1228@frog.athome>
References: <m2vfrpthxt.fsf@tnuctip.rychter.com>
 <Pine.LNX.4.58.0309192257480.1613@phoenix.kerstin.at>  <3F6EAADC.4020509@basmevissen.nl>
  <Pine.LNX.4.53.0309220954120.9385@dynast.gaugusch.at>
 <1064230622.8592.14.camel@dhcp23.swansea.linux.org.uk>  <3F703933.50604@basmevissen.nl>
 <1064334307.14784.92.camel@idoru.kc.de>
Reply-To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1064334307.14784.92.camel-65LrUGLyukAb1SvskN2V4Q@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nils Faerber <nils-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Cc: Bas Mevissen <ml-Y9IUUvl1dgU0Iwp8Nzs06g@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Markus Gaugusch <markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Salut Nils,

On Tue, 23 Sep 2003, Nils Faerber wrote:
> Am Di, 2003-09-23 um 14.14 schrieb Bas Mevissen:
> > Alan Cox wrote:
> > > Several vendors implement the actual battery reading logic as an SMI
> > > trap and disable interrupts during their slow chat with the battery.
> > > There isnt much anyone can do about that bit alas (except read it a lot
> > > less often)
> > (or does the AC/battery power work with an event? The my assumption
> > won't hold then)
I commented on that before!

> I could very well accept CPU load.
> I would even accept delays, given they are small.
> But I experienced kernel hangs, i.e. short periods of no I/O activity at
> all when querying the battery status. And even that could be acceptable.
> What was not acceptable were very bizarre happenings that lokked like
> lost interrupts!? Events that did not cause the reaction they should
> have. Less severe were lost mouse events but more severe was packet loss
> on network.
That are the things that follow from, what Alan is saying - interrupts are
disabled over some time.

> So for me it looks more like a bug in the ACPI code than just a
> performnce issue or hardware misdesign.
> The other thing that leads to this assumption is that so many of us see
> this happening, with various notebooks by various manufacturers. It is
> not bound to certain or limited number of "bad" machines.
Sorry to tell you, that I have no problems with my Acer TM630. I did try a
bash-loop with a uspleep 10, always querrying the battery-state, that did
not consume any interrupts on my maschine. May you collect, what various
notebooks you claim are affected?

cheers
  hartwig felger

Hartwig Felger informatics

- -- 
1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Key fingerprint = FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
For the pulic keys, please visit my page.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/cIzk9bBoTzOf1pMRAhgYAJ0ahmECCs2WUEBv+ahfJib4gunLiACgwfik
DKz65xiT5jrtei4LU7EGe9k=
=FEqF
-----END PGP SIGNATURE-----


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
