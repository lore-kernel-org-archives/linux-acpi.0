From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: CALL FOR TESTING
Date: Thu, 19 Sep 2002 10:13:41 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DE8C@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: 'Francesco Mosca' <askmosca-nc/lrvXPQ4s@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Francesco Mosca [mailto:askmosca-nc/lrvXPQ4s@public.gmane.org] 
> no, i've an asus notebook (am1354d), this is what i can see on screen
> when it hangs: 
> <snip>
> 
> PCI: Using configuration type 1
>  tbxface-0099 [03] Acpi_load_tables     :ACPI Tables 
> successfully loaded
> Parsing Methods: 
> .......................................................
> ..............................................................
> ..........
> ..............................................................
> ..........
> ..................
> Table [DSDT] - 563 Objects with 46 Devices 237 Methods 13 Regions
> ACPI Namespace successfully loaded at root c03ad9dc
>  evxfevent-0074 [04] Acpi_enable         :Transition to ACPI mode
> successfull
> Executing all Device _STA and_INI 
> methods:...<3>schedule_task():keventd
> has not started
> ..........
> 
> <hangs here>

OK, please send me (or the list) the DSDT line from dmesg so we can
blacklist it in the interim, and your DSDT so we can see what the AML is
doing when executing the _INI methods.

Regards -- Andy


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
