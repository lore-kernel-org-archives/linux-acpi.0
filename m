From: Norbert Preining <preining-DX+603jRYB8@public.gmane.org>
Subject: Re: Call for help: list of machines with working S3
Date: Fri, 18 Feb 2005 11:46:33 +0100
Message-ID: <20050218104633.GA28246@gamma.logic.tuwien.ac.at>
References: <20050214211105.GA12808@elf.ucw.cz> <200502152038.00401.stefandoesinger@gmx.at> <20050217190815.GC4925@gamma.logic.tuwien.ac.at> <200502172158.56721.stefandoesinger@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
In-Reply-To: <200502172158.56721.stefandoesinger-RbZlAiThDcE@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stefan =?iso-8859-15?Q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, seife-l3A5Bk7waGM@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Don, 17 Feb 2005, Stefan D=F6singer wrote:
> > Ok, I installed xlibmesa-gl1-dri-trunk, xserver-xfree86-dri-trunk and
> > compiled linux-2.6.11-rc4 and drm modules from drm-trunk-module-src, =
all
> > from http://www.nixnuts.net/files/
> >
> > But I had no success whatsoever. With this (Xorg server, current dri/=
drm
> > stuff, ..) the laptop not even wakes up from sleep!
> Sorry, no Idea. What about 2.6.11-rc3-mm2 + Xorg 6.8.1.99? Did you test=
 this=20
> combination?

I tried:
	2.6.11-rc3-mm2 + Xorg + DRI disabled
and this works.

I cannot enable dri/drm with the cvs version of the drm modules, because
the drm modules do not compile for -mm kernels, since there is the patch
for multiple agp bridges included (that's the reason why I tried -rc4
without mm) and the drm modules from drm-trunk-module-src are not
prepared to the change of the api. I even tried to incorporate the
changes to the api but gave up.

I *can* active dri but with the builtin kernel drm modules, which makes
the kernel freeze while resuming.

> Am I right with assuming that resumeworked after the X upgrade if X was=
n't=20
> started before suspend?

NO!!! Most interestingly: Doing a suspend from single user mode makes
the machine freeze (not even sysrq!)

I suspect that it has to do with the restoring of graphics state with
vbetool from a data set which was taken *while* running X: My
suspend2ram script looks like this (as suggested here):

statedir=3D/root/s3/state
/usr/bin/chvt 1
cat /dev/vcsa >$statedir/vcsa
sync
echo 3 > /proc/acpi/sleep
sync
vbetool post
vbetool vbestate restore <$statedir/vbe
cat $statedir/vcsa >/dev/vcsa
...

but $statedir/vbe was taken once for XFree86 running. Can this be the
reason for the freeze?


Best wishes

Norbert

-------------------------------------------------------------------------=
------
Norbert Preining <preining AT logic DOT at>                 Universit=E0 =
di Siena
sip:preining-5G14tY4QmKiDqU6vP1vexV6hYfS7NtTn@public.gmane.org                             +43 (0) 59966-=
690018
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C=
5 B094
-------------------------------------------------------------------------=
------
MAVIS ENDERBY (n.)
The almost-completely-forgotten girlfriend from your distant past for
whom your wife has a completely irrational jealousy and hatred.
			--- Douglas Adams, The Meaning of Liff


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
