From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: Re: various problems with Acer TM654, suspend, ACAD, radeon
Date: Tue, 24 Aug 2004 23:31:53 -0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040824233153.GA15474@message-id.gmane0305.slipkontur.de>
References: <20040820161911.GA24510@gamma.logic.tuwien.ac.at> <20040823070534.GD24853@message-id.gmane0305.slipkontur.de> <20040823103515.GH8635@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040823103515.GH8635-DqSSrKF0TaySnEC3TeqHn5dqbFPxfnh/@public.gmane.org>
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

On Mon, Aug 23, 2004 at 12:35:15PM +0200, Norbert Preining wrote:
> Hi Stefan! Hi list!
> 
> > > With the newer kernels resuming does not work anymore, there are many
> > 
> > cat /sys/power/disk ??
> 
> sys mem disk

no, that's /sys/power/state.

> > does "echo -n shutdown > /sys/power/disk" prior to suspending help?
> 
> no, not really. And I found that it may be the b44 driver, because this
> one Ooops when resuming. I will try to capture the syslog output ..

Ah, i thought you tried it with init=/bin/bash. Read the swsusp parts of
Documentation/power/ and start testing with a minimal configuration. But
yes, the b44 made trouble for me, too. Unloading it before and reloading
after suspen worked around these.
 
> I also see that the writing process of data to swap is much slower than
> prior to the pmdisk/swsusp merge.

which one did you use before? pmdisk or swsusp? I used swsusp before
and have seen no regressions so far.

> Thanks to the previous posters I fixed this and posted a fixed dsdt
> table to acpi.sf.net. See also www.logic.at/people/preining/acer

Ok, i have to try this out on the new acer prototype i have, maybe we
can kick their BIOS engineers' butts to finally ship a non-broken BIOS.
-- 
Stefan Seyfried



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
