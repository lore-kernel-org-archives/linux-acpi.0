From: tundras-SmH/eyArkOtWk0Htik3J/w@public.gmane.org
Subject: Re: CALL FOR TESTING
Date: Mon, 23 Sep 2002 15:46:51 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020923194650.GA1171@nnenews.com>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DE80@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD0236DE80-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Quoting Grover, Andrew <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>:
> I wanted to make a special request for testing of the 2.4 patch (or should I
> say, MEGA-patch).
> 
> Marcelo has asked for widespread testing of it, in anticipation of likely
> 2.4 mainline inclusion. I will be posting a call for testing to linux-kernel
> soon, but am posting this here first to hopefully weed out any really bad
> bugs that may have crept in.
> 
> The main issues of importance are:
> 
> - DOES IT BOOT?

Yes, the machine boots.

Machine: HP Pavilion 501n
OS: Kernel 2.4.20-pre7 w/ ACPI 20020918. No other patches.

> - DOES IT ASSIGN INTERRUPTS PROPERLY?

No. My earlier report on this machine was with AE_STACK_UNDERFLOW. Now it
reports Error: Acpi_load_tables: Could not load namespace: AE_AML_INTERNAL

/proc/acpi doesn't exist.

> 
> Failure to do so either indicates a bug that we need to fix (fast) or a
> system that should go on the blacklist. dmesg now includes the DSDT
> signature to aid blacklisting.

Is this the DSDT sig information you need?

ACPI: RSDP (v000 PTLTD                      ) @ 0x000f6670
ACPI: RSDT (v001 PTLTD    RSDT   01540.00000) @ 0x07cf7082
ACPI: FADT (v001 INTEL  Whitney  01540.00000) @ 0x07cfbf0a
ACPI: MADT (v001 PTLTD           APIC   01540.00000) @ 0x07cfbf7e
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 01540.00000) @ 0x07cfbfd8
ACPI: DSDT (v001  INTEL  Whitney 01540.00000) @ 0x00000000
ACPI: BIOS passes blacklist




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
