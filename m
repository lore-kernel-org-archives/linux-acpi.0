From: Bas Mevissen <ml-Y9IUUvl1dgU0Iwp8Nzs06g@public.gmane.org>
Subject: Re: Using INITRDDSDT:  was Re: Changing IRQ`s at DSDT
Date: Wed, 01 Oct 2003 13:50:41 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3F7ABF91.208@basmevissen.nl>
References: <3F780D1A.20908@paceblade.com> <200309291937.53825.adq_dvb@lidskialf.net> <3F793B88.60104@paceblade.com> <200309301215.13202.adq_dvb@lidskialf.net> <3F7A57B0.6040906@paceblade.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3F7A57B0.6040906-fPtsKRK0pHxl57MIdRCFDg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Robert Woerle <robert-fPtsKRK0pHxl57MIdRCFDg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Robert Woerle wrote:

> 
> Suggestion :  Why dont you guys put the "Read DSDT from initrd " into 
> the core ACPI source .. so that it gets
> merged to the vanilla kernel at one point .

The patch that floats around works quite well, but it is a hack. It 
would be better to make a module that can be loaded from initrd at boot 
time. With some modprobe.conf smartness, you can select the proper table 
module to be loaded.

But I'm not sure if the ability to load modules doesn't come availabe 
too late in the boot process for ACPI as ACPI has influence on the 
interrupt routing.

> I really like idea to be able to load fixed DSDT`s . This can also be 
> extended by the big distributions then to implement a routine
> in their hardware scan so if a known Mainboard with  a buggy BIOS 
> version ( is there a tool to check the version string of a BIOS ?? ) is
> found they can load a fixed DSDT ....
> This would be a great thing which ACPI enable`s us and so make Linux run 
> even better on more units ...
> 

I agree only in part. Main problem is that you need the fix for exactly 
the same revision as in the BIOS to be sure you don't introduce 
problems. So that means that distribution makers need to maintain a huge 
collection of fixed DSDT's and need a fully reliable way to detect the 
BIOS version to be safe.

I think the best solution for the present time is to relax the ACPI 
interpreter syntax checking even more. But it should warn at boot time 
when it does work around syntax errors to attend the user that it's DSDT 
is actually wrong, but readable to the interpreter.


Bas.





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
