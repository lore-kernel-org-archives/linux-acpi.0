From: Francesco Mosca <askmosca-nc/lrvXPQ4s@public.gmane.org>
Subject: Re: CALL FOR TESTING
Date: 19 Sep 2002 19:03:39 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1032455020.773.8.camel@sputnik>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DE80@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Il gio, 2002-09-19 alle 08:27, Grover, Andrew ha scritto:
<snip>
> 
> - DOES IT BOOT?

no, i've an asus notebook (am1354d), this is what i can see on screen
when it hangs: 
<snip>

PCI: Using configuration type 1
 tbxface-0099 [03] Acpi_load_tables     :ACPI Tables successfully loaded
Parsing Methods: .......................................................
........................................................................
........................................................................
..................
Table [DSDT] - 563 Objects with 46 Devices 237 Methods 13 Regions
ACPI Namespace successfully loaded at root c03ad9dc
 evxfevent-0074 [04] Acpi_enable         :Transition to ACPI mode
successfull
Executing all Device _STA and_INI methods:...<3>schedule_task():keventd
has not started
..........

<hangs here>


this similar to what i was experiencing with previous patches
> - DOES IT ASSIGN INTERRUPTS PROPERLY?

wonder how they will look like.. :)

> 
<snip>


i hope this helps,

Francesco



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
