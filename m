From: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Suspend-to-RAM on Sony Vaios
Date: Thu, 4 Nov 2004 10:02:34 +0100
Message-ID: <20041104090233.GD28895@wotan.suse.de>
References: <88056F38E9E48644A0F562A38C64FB60033E4DDC@scsmsx403.amr.corp.intel.com> <20041103155217.GH24195@wotan.suse.de> <yzosm7q97q2.fsf@cern.ch> <20041103172120.GB18092@wotan.suse.de> <yzo654mowci.fsf@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <yzo654mowci.fsf-vJEk5272eHo@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ole.rohne-vJEk5272eHo@public.gmane.org
Cc: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>, "Pallipadi, Venkatesh" <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Emmanuel Thom?? <Emmanuel.Thome-MZpvjPyXg2s@public.gmane.org>, Jon Valvatne <jon-hc6/xhmWZxdWk0Htik3J/w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Nov 04, 2004 at 09:24:29AM +0100, ole.rohne-vJEk5272eHo@public.gmane.org wrote:
> There is absolutely no guarantee that the machine comes "fresh out of
> suspend"! Here is my recollection of what the ACPI specs says: The

I don't see who should cause busmaster in flight operations
before suspend wakeup.

> code is not done from specs, but rather empirically based on overly
> forgiving firmware implementations. Specifically, the code seems to
> assume the hardware as it comes out of a boot, but there is no such
> guarantee.

Yes, that is the big bug of the ACPI specification. They should
have required the BIOS to post all hardware at least to the 
same state as it happens after initial power on. But Windows
chose to do it differently and now it is too late.

I think the best we can do is to use the BIOS infrastructure to
do this BIOS POST manually while still in real mode.

> 
> Andi> early printk to serial or vga if you're in text mode should
> Andi> always work.
> 
> You mean "should always work" as in "not hanging the machine"?
> Maybe...  It certainly doesn't "work" in the sense of displaying text
> on the screen.

Of course you cannot display anything on the screen when the video
card is not posted yet. I feel you're intentionally trying to misundertand
me.  If you want to debug the POST process you need some other debug
channel, like serial output or the usb debug console.

-Andi


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
