From: Joshua Wise <joshua-NtISFavHD68j5TC/SZClsA@public.gmane.org>
Subject: Re: ACPI on hp tc1100
Date: Sun, 05 Dec 2004 16:03:42 -0500
Message-ID: <41B377AE.7080108@joshuawise.com>
References: <41B2912D.8020105@joshuawise.com> <Pine.LNX.4.60.0412051210070.990@frog.athome>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.60.0412051210070.990-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Cc: jamey.hicks-VXdhtT5mjnY@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> regarding the nvidia problem, I would recomend you searching the 
> november posts to this list for a thread called "Success with 
> kernel-swsusp and Nvidia-closed-source" started by me.
Okay, I read through that.

> Just to repeat two things:
> I was not sucessfull with the latest nvidia driver. I needed to use the 
> nvidia agpgart with 'Option "NvAGP" "1"', as with my Acer ali-agp it 
> would crash on resume.
Hm. First, I tried just setting Option "NvAGP" "1" in my XF86Config 
without downgrading, and that seemed to do the trick! I am running the 
latest NVidia drivers: 6629. However, when the system 'comes back to 
life', the wireless is non-functional, as described below. The 
wacom-acpi driver also seems to need to be reloaded: on resume, dmesg 
reports that ttyS4 failed the LSR safety check. If I get a chance, I'll 
see if I can't write a patch for that to kill off and reload the serial 
  on suspend and resume, respectively. (This shouldn't go in 
suspend/resume scripts because we need to maintain continuity across a 
suspend - X doesn't know how to re-open the device when it gets 
unexpectedly closed.)

> If you login through the network and run "top" you would see, that X is 
> claiming nearly 100% of CPU-cycles..., that happens, when you switch to 
> the virtual-console, where the nvidia-binary-only driver is running (or 
> if it is resumed to this console...) and the AGP-bus is not initialised.
Ah. In fact, when this system resumes from suspend, the wireless card 
refuses to work. Errors in dmesg:
<system power on>
ipw2100: eth0: ipw2100_verify failed: -5
ipw2100: eth0: Failed to power on the adapter.
ipw2100: eth0: Failed to start the firmware.
Restarting tasks... done
<I try to reload the driver>
ipw2100: Intel(R) PRO/Wireless 2100 Network Driver, 1.0.1
ipw2100: Copyright(c) 2003-2004 Intel Corporation
ACPI: PCI interrupt 0000:02:05.0[A] -> GSI 15 (level, low) -> IRQ 15
ipw2100Device not found via register read.

I will see if removing the driver before bringing the system down helps.

> As you may read often on this list, start with suspend to disk, as it is 
> the easiest to get running. Then go for S1 and S3 (the S0 you mentioned 
> is S1). Just always think of doing a sync before trying to suspend; then 
> fsck has a lot better chances to put things together after a crash.
Yup. Sync before suspend has saved me repeatedly. I actually just got S3 
mostly working, as described previously. I will try swsusp in a while to 
see if that fixes my ipw2100 problems.

> Cheers
>   hartwig felger
joshua


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
