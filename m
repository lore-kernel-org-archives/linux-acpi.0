From: "Andrew D. Keyser" <andrewdk-Wuw85uim5zDR7s880joybQ@public.gmane.org>
Subject: Re: Oops during startup
Date: Wed, 02 Jun 2004 22:43:47 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <c9m6pp$e41$1@sea.gmane.org>
References: <3ACA40606221794F80A5670F0AF15F840483B1C4@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F840483B1C4-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
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

I tried all of them, none of them made any difference (except the edge 
parameter makes it say "ACPI: IRQ9 SCI: Level Trigger set to Egde mode." 
or something).

Andrew

Yu, Luming wrote:
>  Please try kernel option: acpi_sci={ level | edge | high | low }
> 
> --Luming
> 
> 
>>-----Original Message-----
>>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org 
>>[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of 
>>Andrew D. Keyser
>>Sent: Wednesday, June 02, 2004 10:48 AM
>>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>>Subject: [ACPI] Re: Oops during startup
>>
>>Your problem seems similar to mine; I can't boot any kernel newer than 
>>2.6.6-mm4 without using acpi=off. When the kernel boots, it gets to 
>>"ACPI: IRQ9 SCI: Level Trigger." and stops. I have an HP ze4560us. The 
>>stranger thing though is that I can't even load the Gentoo LiveCD 
>>without acpi=off, so something must be broken either in my laptop 
>>(however that happened) or in both of the kernel versions...
>>Might not be related but the symptoms are similar so I figured I might 
>>as well add on.
>>
>>Andrew
>>
>>Ethan Glasser-Camp wrote:
>>
>>>2.6.6 oopses on startup for me. acpi=off seems to work OK.
>>>
>>>My Thinkpad T-30 has served me faithfully for about 1.5 
>>
>>years, but was
>>
>>>needing some service so I took it to the shop today. They gave me a
>>>replacement laptop (same model, still a T-30), but when I tried to
>>>boot up, I got a kernel oops. 2.6.5 boots up fine, and so does 2.6.6
>>>when given the boot parameter acpi=off. The machines are basically
>>>identical except for the CD-ROM drive. Might this cause a problem? Or
>>>should I be pointing a finger at the ACPI tables and other firmware?
>>>
>>>Since the kernel oopses before it finishes booting up, I can't even
>>>scroll up to the top of it to see what the oops message is. 
>>
>>I can copy
>>
>>>the callback if it helps. How can I help to diagnose the problem?
>>>
>>>Ethan Glasser-Camp
>>
>>
>>
>>-------------------------------------------------------
>>This SF.Net email is sponsored by the new InstallShield X.
> 
>>From Windows to Linux, servers to mobile, InstallShield X is the one
> 
>>installation-authoring solution that does it all. Learn more and
>>evaluate today! http://www.installshield.com/Dev2Dev/0504
>>_______________________________________________
>>Acpi-devel mailing list
>>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>>
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by the new InstallShield X.
> From Windows to Linux, servers to mobile, InstallShield X is the one
> installation-authoring solution that does it all. Learn more and
> evaluate today! http://www.installshield.com/Dev2Dev/0504



-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
