From: Matthew Garrett <mgarrett-QGMSyCZBOSwv4zxTlrOuLwNdhmdF6hFW@public.gmane.org>
Subject: Re: ACPI buttons in 2.6.12-rc4-mm2
Date: Tue, 26 Jul 2005 20:55:37 +0100
Message-ID: <E1DxVWb-0002Sx-00@chiark.greenend.org.uk>
References: <b6d0f5fb0505220425146d481a@mail.gmail.com> <b6d0f5fb0505220425146d481a@mail.gmail.com> <1122407079.13241.4.camel@toshiba.lenb.intel.com>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1122407079.13241.4.camel-g3qfMnKXm6m1ouK1UO9oVVDQ4js95KgL@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> I deleted /proc/acpi/button on purpose,
> did you have a use for those files?

There are various cases where it's useful to know whether a laptop is
shut or not, and /proc/acpi/button seems to be the only place where that
information is made available at the moment.

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
