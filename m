From: "P. Christeas" <p_christ-U04EIuiosng@public.gmane.org>
Subject: Re: Testing: NVidia closed driver fails.
Date: Thu, 19 Sep 2002 15:38:16 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200209191241.g8JCfN303320@pfn1.pefnos>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DE80@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-7"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD0236DE80-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> I wanted to make a special request for testing of the 2.4 patch (or should
> I say, MEGA-patch).
>
>
> - DOES IT BOOT?
> - DOES IT ASSIGN INTERRUPTS PROPERLY?
>

I have tried the 2.4.20-pre7 + acpi-20020918 patch on a single Athlon XP 
1.7+, VIA VT8637 KT266 chipset. The system boots and displays some ACPI info 
that looks fine.
However, the proprietary NVidia video driver (I have a Geforce 2 MX card and 
the newest 1.0.3123 proprietary driver) fails to start the X system. I 
strongly suspect (although I don't have enough debug info yet) that the acpi 
patch is the one that makes NVidia fail. The 2.4.19 worked until the acpi 
patch was applied to it.

The situation arising is quite strange. I want the current ACPI to be 
included in the next mainline kernel. However, all NVidia users will be 
disappointed if the stable 2.4.20 comes out before NVidia releases a suitable 
driver.

I suggest: merge the ACPI and tell NVidia to start testing. Put a warning 
label at both sides make sure a correct NVidia driver is out before 2.4.20 
reaches final release (there is plenty of time).


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
