From: Joel Schopp <jschopp-V7BBcbaFuwjMbYB6QlFGEg@public.gmane.org>
Subject: Re: [Lhms-devel] Re: [PATCH] ACPI based Memory Hotplug	Driver
 Patch
Date: Tue, 14 Sep 2004 11:21:37 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <41471A91.5020004@austin.ibm.com>
References: <FEB6C4E97F6CAF41978FB2059D5454180F37E8@bgsmsx402.gar.corp.intel.com>	 <20040910230200.73eb0374.tokunaga.keiich@jp.fujitsu.com>	 <1094837554.32531.1997.camel@nighthawk>	 <20040913172318.791db349.tokunaga.keiich@jp.fujitsu.com>	 <1095064865.4671.5.camel@localhost>	 <20040914115844.1e12203d.tokunaga.keiich@jp.fujitsu.com> <1095135104.10726.8.camel@localhost>
Reply-To: jschopp-V7BBcbaFuwjMbYB6QlFGEg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1095135104.10726.8.camel@localhost>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dave Hansen <haveblue-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Cc: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>, naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Matthew E Tolentino <matthew.e.tolentino-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lhms <lhms-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> Although, I do wonder if we can have memory laid out in the firmware/
> directory in some kind of firmware-agnostic way.  
> 
> What I want is to make sure that any hotplug memory application that is
> written can use the same directories no matter whether it is a ppc
> machine using OpenFirmware or an x86/ia64 machine using ACPI.  

Noble goal, here is what we represent on ppc64 for a logical memory block.

bigbirdlp2:/proc/device-tree # ls ./memory\@10000000/
.  ..  device_type  ibm,my-drc-index  linux,phandle  name  reg
bigbirdlp2:/proc/device-tree/memory@10000000 # xxd ./reg
0000000: 0000 0000 1000 0000 0000 0000 1000 0000  ................
bigbirdlp2:/proc/device-tree/memory@10000000 # cat ./device_type
memory
bigbirdlp2:/proc/device-tree/memory@10000000 # xxd ./ibm,my-drc-index
0000000: 0000 0001                                ....
bigbirdlp2:/proc/device-tree/memory@10000000 # cat name
memory

I'm pretty sure the reg property is just a starting address, size pair. 
  The device type and name are pretty boring.  The drc-index is not 
guaranteed to correspond to anything (though it usually is start address 
/ size), you could call it arch-identifier or something.

> 
> Instead of just laying thing out in firmware/acpi, can we have another
> directory that mirrors this information in the system/devices/
> directory, but is identical across architectures?  

I'd do something like this for each LMB:

start-addr
size
arch-identifier


-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
