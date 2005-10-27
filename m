From: john <sorosj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: Acer Extensa 3002 WLMi: DSDT fixed but system misses keyboard and mouse events
Date: Thu, 27 Oct 2005 20:41:48 +0200
Message-ID: <200510272041.52323.sorosj@gmail.com>
References: <435D43BB.2080702@rrz.uni-koeln.de> <200510271842.37571.sorosj@gmail.com> <loom.20051027T195942-349@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4420568.d5REL94JZ1";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <loom.20051027T195942-349-eS7Uydv5nfjZ+VzJOa5vwg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--nextPart4420568.d5REL94JZ1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

thanx! but i aint got any probs with acpi-sbs, exept sometimes i get a whol=
e=20
lot of keypesses when i only press a key=20
onceeeeeeeeeeeeeeeeeeeeeeeeeeeee...oops, and i had to delete some - well=20
that's a good example :D - suspend-to-ram is same for me, the unfriendly=20
black screen and no reactions, no luck. hope they'll update their bios, or=
=20
better, hope linux-bios gets something going on for i855 series motherboard=
s.
cheers
john

>On Thursday 27 October 2005 20:13, Radoslaw Chyra wrote:
> john <sorosj@...> writes:
> > i've got the same notebook (tm4001LMI - 512mb ram - ati9600 - ipw2200).
> > I'm still using acpi-sbs kernel modules to read my battery, but this
> > doesn't enable me to suspend-to-ram. if fixing the DSDT does, can you
> > send your fixed dsdt as attachement? would be great to turn on-off the
> > machine in a snap!
>
> No, fixing DSDT only enables me to drop acpi-sbs kernel modules (which in
> turn cause problem with disappearing battery entries from /proc/acpi for
> me). Suspend-to-ram neither works with acpi-sbs nor with patched/fixed
> DSDT. Laptop suspends to ram but after pressing Power Button or any of the
> keys there is only disk spin-up but screen stays dark and USB power is do=
wn
> (mouse and external keyboard stay dark) and touching Caps Lock does
> nothing.
>
> So, with acpi-sbs modules I had problem with disappearing battery, but
> keyboard worked OK. With patched/fixed DSDT battery is OK, but keyboard
> behaves bad. With the two I chose the latter and attached external USB
> keyboard which works OK.
>
> If you are still interested I can send you my patched/fixed DSDT, just dr=
op
> me private message.
>
> Regards,
>
> Radoslaw
>
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by the JBoss Inc.
> Get Certified Today * Register for a JBoss Training Course
> Free Certification Exam for All Training Attendees Through End of 2005
> Visit http://www.jboss.com/services/certification for more information
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel

--nextPart4420568.d5REL94JZ1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDYR9wgRmtYySq9WARApwBAKC5GKOkDORSzHISsPFDeiPb0OXHJACeMD+t
wq6xQs3dPCHb7fpX3BdDR50=
=YDYK
-----END PGP SIGNATURE-----

--nextPart4420568.d5REL94JZ1--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
