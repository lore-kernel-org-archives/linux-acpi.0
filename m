From: Dave Hansen <haveblue-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Lhms-devel] Re: [PATCH] ACPI based Memory Hotplug
	Driver Patch
Date: Tue, 14 Sep 2004 10:12:16 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1095181936.3686.29.camel@localhost>
References: <FEB6C4E97F6CAF41978FB2059D5454180F37E8@bgsmsx402.gar.corp.intel.com>
	 <20040910230200.73eb0374.tokunaga.keiich@jp.fujitsu.com>
	 <1094837554.32531.1997.camel@nighthawk>
	 <20040913172318.791db349.tokunaga.keiich@jp.fujitsu.com>
	 <1095064865.4671.5.camel@localhost>
	 <20040914115844.1e12203d.tokunaga.keiich@jp.fujitsu.com>
	 <1095135104.10726.8.camel@localhost>
	 <20040914182956.49c9381d.tokunaga.keiich@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040914182956.49c9381d.tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Cc: naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Matthew E Tolentino <matthew.e.tolentino-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lhms <lhms-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, jschopp-V7BBcbaFuwjMbYB6QlFGEg@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 2004-09-14 at 02:29, Keiichiro Tokunaga wrote:
> On Mon, 13 Sep 2004 21:11:44 -0700 Dave Hansen wrote:
> > What I want is to make sure that any hotplug memory application that is
> > written can use the same directories no matter whether it is a ppc
> > machine using OpenFirmware or an x86/ia64 machine using ACPI.  
> 
> That's an ideal solution that I like:)
> 
> > Instead of just laying thing out in firmware/acpi, can we have another
> > directory that mirrors this information in the system/devices/
> > directory, but is identical across architectures?  
> 
> That's an interesting idea.  I think that not all of the stuffs could
> be identical across architectures, so we would lay architecture
> specific sutffs only in architecture specific directory (e.g. /sys/firmware/acpi/),
> and general stuffs (like physical address) in both the archtecture
> specific directory and the mirror directory.  This sounds reasonable
> to me.  By the way, where do you think would be a candidate for
> the mirror directory?

Well, in retrospect, I think that /sys/devices/system/memory is probably
a bad place for the hotplug controls to go.  It's really just a logical
view of the memory from Linux's perspective, and that somewhat takes a
back seat to the physical layout presented by the hardware.

So, perhaps the physical layout should go in /sys/devices/system/memory,
and we can put the hotplug controls in
/sys/devices/system/logical/memory, or something similar.  

-- Dave



-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
