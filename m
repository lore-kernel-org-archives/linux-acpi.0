From: liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Subject: Re: Battery status wrong from 2.6.7 when running on batteries
Date: Sat, 30 Oct 2004 13:28:09 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.60.0410301303050.1003@frog.athome>
References: <16768.60745.952949.338093@aber.ac.uk> <16769.6764.210990.366655@aber.ac.uk>
 <Pine.LNX.4.60.0410282005580.4042@frog.athome> <16769.64228.751344.828301@aber.ac.uk>
 <Pine.LNX.4.60.0410291255100.1318@frog.athome> <16770.21398.497934.189008@aber.ac.uk>
Reply-To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; FORMAT=flowed
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <16770.21398.497934.189008-4CLdheC3Iye1Qrn1Bg8BZw@public.gmane.org>
Content-ID: <Pine.LNX.4.60.0410301326011.1003-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Fred Labrosse <ffl-4CLdheC3Iye1Qrn1Bg8BZw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Salut Fred,
first I would ask you that we should take this discussion off the list. 
Maybe we should open a bugzilla-case for that issue: http://bugme.osdl.org

To get on with our search, you might want to send the .config you used 
(i.e. mine, which you changed by two items???), and I would try to 
reproduce you problems. You talked about a different NIC. I thought, that 
it is all the time a RTL-8139 chip CONFIG_8139 which is built into TM 63x 
notebooks, but maybe it is just the modus (module vs. buil-in)?
On the other hand, you might need to build every major-release of Linux, 
to find out, where exactly the regression for you begun. Then if you have 
the adjaccent pair, you might go on and build every pre-, rc- releases in 
between the two, to find the exact minor-release step. Just hope, that the 
patch was small, because you then need to guess an try to only apply parts 
of the offending patch, till you found, which part of the patch caused 
your troubles. This is really time-consuming. Be sure, to sync your 
harddisks and have a backup of it, just in case you find something more 
severe...

On Fri, 29 Oct 2004, Fred Labrosse wrote:
> liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org writes:
> > I attached you my config.gz. So you might want to give it a try. I would
> > be nice, if this brings you forward, to dig down the differences in your
> > current config and mine and elaborate later on the list.
> >
>
> Since my last email, my machine froze, which hadn't happened for a very
> long time.  I rebooted it, recompiled my kernel with your config file
> (slightly modified because apparently my network card is not the same as
> yours and because I need devfs (for gentoo).  I had to manually insert the
> acpi modules (I have them in the kernel).  I unplugged the laptop from the
> mains and about 2 minutes after, it froze...
>
> Rebooted and redid the experiment: booting while plugged in, then unplug
> from the mains.  After a few minutes, both temperatures show 46 and ... THE
> BATTERY SHOWS 46% CHARGED...
>
> /sbin/halt displays "Power down" but doesn't power down...
>
> That's with the same config as yours (Hartwig) apart from devfs on,
> /dev/pts off and 8139too as a module (network card).
>
> Does that help?
>
> Fred

Cheers
   hartwig felger

Hartwig Felger informatics

- -- 
1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Key fingerprint = FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
For the pulic keys, please visit my page.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFBg3rN9bBoTzOf1pMRAscSAKDjWksZehqGAxavxyc4BWgBUbBqPgCdHsGQ
BMc7UpT8MWivTD2V0iN+5HQ=
=Eyey
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
