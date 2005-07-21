From: Volker Braun <volker.braun-DqRHhl98DdeAKZTfuerNgRvVK+yQ3ZXh@public.gmane.org>
Subject: Re: C2, C3 and bus master activity
Date: Thu, 21 Jul 2005 12:08:58 -0400
Message-ID: <pan.2005.07.21.16.08.58.174249@physik.hu-berlin.de>
References: <200507192050.28343.pumpkin@gmx.de> <200507192359.56553.pumpkin@gmx.de> <42DD85F3.9050300@tzi.de> <200507201921.43576.pumpkin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

> - and why is the radeon driver causing ffffffff-Activity ?

Disable dri (comment out the 'Load  "dri"' in xorg.conf). Then the radeon
driver will no longer make pointless bus master transfers. I have no idea
why dri causes the bus master activity, but it should not.=20

Volker

PS: My CPU switches to C3/C4 even with ipw2200 running (2915a/b/g card).





-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dclic=
k
