From: Stefan =?iso-8859-15?q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: Call for help: list of machines with working S3
Date: Thu, 17 Feb 2005 21:58:54 +0100
Message-ID: <200502172158.56721.stefandoesinger@gmx.at>
References: <20050214211105.GA12808@elf.ucw.cz> <200502152038.00401.stefandoesinger@gmx.at> <20050217190815.GC4925@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20050217190815.GC4925-DqSSrKF0TaySnEC3TeqHn5dqbFPxfnh/@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Norbert Preining <preining-DX+603jRYB8@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, seife-l3A5Bk7waGM@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Am Donnerstag, 17. Februar 2005 20:08 schrieb Norbert Preining:
> On Die, 15 Feb 2005, Stefan D=F6singer wrote:
> > > - DRI must be disabled I guess?! Even with newer X server (x.org)?
> >
> > Do you use the fglrx driver? This doesn't work with any type of suspend
> > so far. If you use the radeon driver try a driver update.
>
> Ok, I installed xlibmesa-gl1-dri-trunk, xserver-xfree86-dri-trunk and
> compiled linux-2.6.11-rc4 and drm modules from drm-trunk-module-src, all
> from http://www.nixnuts.net/files/
>
> But I had no success whatsoever. With this (Xorg server, current dri/drm
> stuff, ..) the laptop not even wakes up from sleep!
Sorry, no Idea. What about 2.6.11-rc3-mm2 + Xorg 6.8.1.99? Did you test thi=
s=20
combination?
Am I right with assuming that resumeworked after the X upgrade if X wasn't=
=20
started before suspend?

Stefan


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
