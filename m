From: Norbert Preining <preining-DX+603jRYB8@public.gmane.org>
Subject: Re: Call for help: list of machines with working S3
Date: Thu, 17 Feb 2005 20:08:15 +0100
Message-ID: <20050217190815.GC4925@gamma.logic.tuwien.ac.at>
References: <20050214211105.GA12808@elf.ucw.cz> <42121EC5.8000004@gmx.net> <20050215170837.GA6336@gamma.logic.tuwien.ac.at> <200502152038.00401.stefandoesinger@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
In-Reply-To: <200502152038.00401.stefandoesinger-RbZlAiThDcE@public.gmane.org>
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

On Die, 15 Feb 2005, Stefan D=F6singer wrote:
> > - DRI must be disabled I guess?! Even with newer X server (x.org)?
> Do you use the fglrx driver? This doesn't work with any type of suspend=
 so=20
> far. If you use the radeon driver try a driver update.

Ok, I installed xlibmesa-gl1-dri-trunk, xserver-xfree86-dri-trunk and
compiled linux-2.6.11-rc4 and drm modules from drm-trunk-module-src, all
from http://www.nixnuts.net/files/

But I had no success whatsoever. With this (Xorg server, current dri/drm
stuff, ..) the laptop not even wakes up from sleep!

Now I am back at debian XFree 4.3.0.1 and DRI disabled and suspend works
again.

I don't know wether this is a problem with the kernel or the drm, so to
sum up:

- kernel 2.6.11-rc3-mm2, XFree 4.3.0.1 (debian/sid), no dri
	works

- kernel 2.6.11-rc4, Xorg 6.8.1.99 (debian sid + nixnuts), drm cvs, drm=20
  activated
	no resume (thus also no test for X)


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
SWANIBOST (adj.)
Complete shagged out after a hard day having income tax explained to
you.
			--- Douglas Adams, The Meaning of Liff


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
