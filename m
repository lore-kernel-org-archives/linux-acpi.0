From: liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Subject: Re: Success with kernel-swsusp and Nvidia-closed-source
Date: Thu, 4 Nov 2004 17:36:35 +0100 (CET)
Message-ID: <Pine.LNX.4.60.0411041729180.4727@frog.athome>
References: <Pine.LNX.4.60.0411031215260.1187@frog.athome>
 <200411031958.47910.christian.hesse@linuxob.de>  <Pine.LNX.4.60.0411032322410.4984@frog.athome>
 <1099534267.3991.52.camel@desktop.cunninghams> <Pine.LNX.4.60.0411041242210.1565@frog.athome>
Reply-To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.60.0411041242210.1565-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
Cc: Nigel Cunningham <ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>, Christian Hesse <christian.hesse-5lmcC6f56PSELgA04lAiVw@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Salut Christian,
On Thu, 4 Nov 2004 liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org wrote:
>>> Salut Christian,
>>> On Wed, 3 Nov 2004, Christian Hesse wrote:
>>>> I'm using software suspend 2.1. For me suspend works fine, but the 
>>>> system
>>>> freezes as soon as it is resumed, I only see a black screen then. 
>>>> Driver nv
>>>> works without any problems. Any hints what could be the cause?
I played a bit with my X setup. When I force X to use the ali-agp instead 
of the "NVIDIA internal" I get a nearly lockedup machine on resume. This 
is obviously some bug in the linux-agp-driver-tree. Also if I change to a 
runlevel without X I may rmmod the nvidia module but not the agp-modules. 
So they are really buggy (at least the ali-agp, which I would have to 
use). The workaround, if I get such a lockedup machine is to login over 
the network and
  killall -9 X
because kill alone will not be enought. So you may want to try
      Option      "NvAGP" "1"
in your /etc/X11/XF86Config.

Let us know if this gets you any further. When I find time, I will give 
swsusp 2.1 another try myself!

Cheers
   hartwig felger

Hartwig Felger informatics

- -- 
1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Key fingerprint = FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
For the pulic keys, please visit my page.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFBilqb9bBoTzOf1pMRAsHwAKDoowrQMXCOB6trvObNNufIxwmdtgCgh9nj
O+UsJxDEuvujti5IfyWheuA=
=x2FD
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
