From: "Andrew D. Keyser" <andrewdk-Wuw85uim5zDR7s880joybQ@public.gmane.org>
Subject: Re: DSDT Change (Compaq Presario 2100)
Date: Wed, 02 Jun 2004 13:46:43 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <c9l7ao$79u$1@sea.gmane.org>
References: <200405280621.29874.andre@eisenbach.com> <c9am7j$nng$1@sea.gmane.org> <200405291345.51712.andre@eisenbach.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200405291345.51712.andre-+hZUvIEKc2q1Z/+hSey0Gg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Although, if you update the BIOS, the problem seems to fix itself...
Anywho, I find it ironic that HP touts "AMD with PowerNOW" yet they 
don't actually use the powernow and instead use the crappy DSDT.

Andrew

Andre Eisenbach wrote:
> Am Samstag Mai 29 2004 11:53 schrieb Erik Meitner:
> 
>>>Well, tonight, while recompiling the DSDT a few times to remove warnings
>>>and errors, I stumbled across this (in method SMSL
>>>
>>>If (0x01)
>>>{
>>>	Store (\_SB.PCI0.ISA.EC0.TTDC, TRDC)
>>>	Store ("AC remove! Set Throttle Duty Cycle ---: ", Debug)
>>>	Store (TRDC, Debug)
>>>	Store (0x01, TREN)
>>>}
>>
>>The DSDT for my laptop has the exact same code.
> 
> 
> That piece of code is the state cange code (i.e. when you unplug the AC cord). 
> There is another place you need to change, which initializes the behaviour 
> when you boot with the power cable already unplugged.
> 
> The method is _REG. Here is the code
> 
>                                 Store (0x01, \_SB.PCI0.PMU.CRUN)
>                                 If (0x01)
>                                 {
>                                     Store (\_SB.PCI0.ISA.EC0.TTDC, TRDC)
>                                     Store (0x01, TREN)
>                                 }
> 
> Once again change "If (0x01)" to "If (0x00)".
> 
> 
>>>In any case, I changed "If (0x01)" to "If (0x00)" and voila, I am typing
>>>this email from KDE with the power cord unplugged - no slowdown at all.
>>
>>I have verified that this works for my machine also.
> 
> 
> Thats great news!
> 
> 
>>Am I correct in assuming that TREN is "Throttle Enable"(boolean value)
>>and TRDC is "Throttle Duty-cycle"? What other TRDC values might make
>>sense other than 0x0 ?
> 
> 
> I think you're right about TREN and TRDC. 
> That method of throttling the CPU is not a good method apparently. It also 
> doesn't save battery (at least for me). Instead, use "PowerNOW" if you have 
> an AMD chip. It's built into the 2.6+ kernels (cpufreq) and works like a 
> champ for me.  And unlike the DSDT based throtteling, you can control it!
> 
> Cheers,
>     André



-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
