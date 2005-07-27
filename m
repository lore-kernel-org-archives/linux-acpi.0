From: Voluspa <voluspa-zq6IREYz3ykAvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: acpidump replaces acpidmp
Date: Wed, 27 Jul 2005 14:56:54 +0200
Message-ID: <20050727145654.24666ac8.voluspa@telia.com>
References: <20050726192423.216b4be8.voluspa@telia.com>
	<42E76A79.2040702@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <42E76A79.2040702-l3A5Bk7waGM@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 27 Jul 2005 13:05:29 +0200 Thomas Renninger wrote:
> Voluspa wrote:
> > On 2005-07-23 0:35:38 Len Brown wrote:
> > make[1]: *** [acpidump] Error 1
> > make[1]: Leaving directory
> > `/home/net/acer/acpi/len_brown/pmtools-20050722/acpidump'
> > make: *** [all] Error 2
> > 
> ../include/acpi/actypes.h:115
> Replace s64 with u64 and it at least compiles.

Heh, when I saw the s64 that was my first thought. But being a newbie to
C it seemed like a wild goose chase. Yes, compiles after that edit.

> I tried it out on two (x86_64) machines.
> On the one I got no output at all, on the other I got a segfault in
> acpidump.c:104.

I get a segfault with "./acpidump --table DSDT" after quit a bit of
output (down to 5e40: 57 12 06 02 0a 00 0a 03). No .c linenumber.
Straight "./acpidump" completes, but how do I know it _is_ complete...
A diff between /proc/acpi/dsdt and the output of "./acpidump --binary"
differ, and not by a small amount:

24 -r--------  1 root root  24136 Jul 27 14:47 dsdt
28 -rw-r--r--  1 root root  24743 Jul 27 14:52 dsdt.acpidump

Mvh
Mats Johannesson
--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
