From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: /sys/firmware/acpi (Re: [PATCH/RFC 4/4]An experimental
	implementation for IDE bus)
Date: 09 Nov 2004 00:35:39 -0500
Message-ID: <1099978538.5519.28.camel@d845pe>
References: <1099887081.1750.249.camel@sli10-desk.sh.intel.com>
	 <20041108152450.GB32374@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041108152450.GB32374-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>
Cc: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>, Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>, Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2004-11-08 at 10:24, Matthew Wilcox wrote:
> ... Are we ever going to do anything
> with /sys/firmware/acpi/namespace/ or will it just stay around
> consuming inodes and dentries for no good reason?

When I suggested deleting /sys/firmware/acpi, Patrick replied that his
intention was that real devices would have symbolic links into that
tree.

I think this is not the best way to go.  Two simple reasons come to
mind:

The ACPI device hierarchy reflects the actual layout of the system
devices better than the current /sys/devices/ tree, linking into it from
/sys/devices doesn't fix /sys/devices.  Instead we need to consult ACPI
during the actual construction of /sys/devices/.

While the layout reflects reality, the device names in
/sys/firmware/acpi are arbitrary internal BIOS names, and so there will
never be any consistency between systems such that a human or a program
could have an easy time navigating the tree structure.

The argument in favor of exposing the tree has been for things like Alex
Williamson's patch to invoke ACPI methods by reading /sysfs.  But this
is a really neat solution looking for a problem.  if and when such a
problem is found, the same technique can always be made available under
the real /sys/devices tree.

-Len




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
