From: =?iso-8859-1?Q?Ois=EDn_Mac_Fheara=ED?= <destynova-iUB+o6dfpG8i1yMB4YHZDQ@public.gmane.org>
Subject: Re: Acer Aspire 1601LC tempertature & ACPI
Date: Fri, 2 Apr 2004 19:52:07 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <004501c418e3$994b2ca0$7ce9fea9@SHERKA>
References: <200404021654.00101.nate@paranoici.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nate Grey <nate-XtQPfPCVGG7srOwW+9ziJQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

With my Acer Aspire 1705SMi, thermal zone would report temperature as 255C
repeatedly during bootup and reboot.
I disabled the thermal zone module, as the BIOS will supposedly shut down
the laptop if the temperature is really too high.

Oisín
----- Original Message ----- 
From: "Nate Grey" <nate-XtQPfPCVGG7srOwW+9ziJQ@public.gmane.org>
To: <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sent: Friday, April 02, 2004 5:53 PM
Subject: [ACPI] Acer Aspire 1601LC tempertature & ACPI


> Hello,
> this is my first post, I'm sorry for my English (I'm Italian).
>
> Well, my laptop during compilations that take long times shutdown with a
> kernel message that say "Critical Temperature 86 °C" or poweroff whitout
> messages.
> I use Gentoo distribution (but the problem happened firstly on FreeBSD,
this
> the reason I switch on Linux).
>
> I got two questions:
>
> 1) Is this problem due to ACPI? (My friend Google lead me here)
> 2) What can I do?
>
> I paste some system information:
>
> CPU = model name      : Intel(R) Pentium(R) 4 CPU 2.40GHz
> Linux 2.6.4 (ACPI patch)
> ---------------------------------------
> [/proc/acpi][root-hr27OG2WxIw@public.gmane.org] # cat info
> version:                 20040311
> ---------------------------------------
> [/proc/acpi/thermal_zone/THRS]
> [root-hr27OG2WxIw@public.gmane.org] # cat *
> <not supported>
> <polling disabled>
> state:                   ok
> temperature:             52 C
> critical (S5):           85 C
> ---------------------------------------
> [/proc/acpi/processor/CPU0]
> [root-hr27OG2WxIw@public.gmane.org] # ls
> info  limit  power  throttling
> [/proc/acpi/processor/CPU0]
> [root-hr27OG2WxIw@public.gmane.org] # cat *
> processor id:            0
> acpi id:                 0
> bus mastering control:   yes
> power management:        yes
> throttling control:      no
> limit interface:         no
> <not supported>
> active state:            C2
> default state:           C1
> bus master activity:     00000000
> states:
>     C1:                  promotion[C2] demotion[--] latency[000]
> usage[00459840]
>    *C2:                  promotion[--] demotion[C1] latency[099]
> usage[04028062]
>     C3:                  <not supported>
> <not supported>
> ----------------------------------------
>
>
> Probably you need more infos, just ask. It's very important, sometimes I
> cannot see a DVD because system goes down... :°(  Ah, last info, this
problem
> doesn't not appear on WinXP (when it was installed).
>
> Thanks in advance. Bye Bye
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id70&alloc_id638&opÌk
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>
>



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
