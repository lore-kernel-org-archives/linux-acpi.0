From: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Subject: Re: SuSE AMD x86-64 bits installation issue
Date: Fri, 7 Nov 2003 12:13:39 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031107111339.GA4877@wotan.suse.de>
References: <6A7AB4426712514F9E2AB28C407285FA04EBB91B@exchtp02.taipei.via.com.tw> <1068202635.2682.972.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1068202635.2682.972.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: HurryLin-6hSdJfI2Hxp9nmWX13WWKA@public.gmane.org, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, DreamKu-6hSdJfI2Hxp9nmWX13WWKA@public.gmane.org, StephenChen-6hSdJfI2Hxp9nmWX13WWKA@public.gmane.org, PearHuang-6hSdJfI2Hxp9nmWX13WWKA@public.gmane.org, NormanChung-6hSdJfI2Hxp9nmWX13WWKA@public.gmane.org, KenCho-6hSdJfI2Hxp9nmWX13WWKA@public.gmane.org, Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

[some comments, although I'm not Hurry]

On Fri, Nov 07, 2003 at 05:57:15AM -0500, Brown, Len wrote:
> If the issue is specific to the SuSE kernel, then you want to file
> it at http://bugzilla.suse.de  More likely this issue is not unique
> to SuSE, and so you should file the bug against the baseline kernel(s).

I believe it is generic (although I haven't retested with latest
2.6 with IO-APIC enabled, older 2.6 showed it)

> 
> How to file a bug against ACPI:
> 
> http://bugzilla.kernel.org/
> Category: Power Management
> Component: ACPI
> 
> Please attach the output from dmidecode, available in /usr/sbin/, or
> here:
> http://www.nongnu.org/dmidecode/

I don't think dmi blacklisting would do any good. The problem seems
to occur over a wide range of VIA chips with BIOS/motherboards from
multiple vendors. On the x86-64 kernel I actually ended up with checking 
for every bridge from VIA to disable the IO-APIC.

> 
> Please attach the output from acpidmp, available in /usr/sbin/, or in
> here
> http://www.intel.com/technology/iapc/acpi/downloads/pmtools-20010730.tar.gz
> 
> Please attach /proc/interrupts and the dmesg output showing the failure,
> if possible.

The symptom is when IO-APIC is enabled the system does not boot and 
hangs early in some device driver like IDE. With IO-APIC disabled you obviously
get a very different /proc/interrupts.

-Andi



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
