From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Battery info given in mW, should be mA
Date: Sat, 5 Jul 2003 16:40:08 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030705154008.GA18878@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

/proc/acpi/battery/BAT1/info gives me, amongst other things:

design capacity:         3500 mWh
last full capacity:      3500 mWh

According to the manufacturer, it's supposed to have a capacity of 
3.4mAh. Running at 10V, that gives somewhat more than 3500mWh. The 
numbers being returned look like they should be in mAh. Looking at 
battery.c, the code for choosing which unit to display looks reasonable. 
In my dsdt, I have:

            Name(PBIF,Package(0x0D){
                0x01,
                0xFFFFFFFF,
                0xFFFFFFFF,
                0x01,
                0xFFFFFFFF,
                0x96,
                0x7E,
                0x04,
                0x04,
                "BAT1",
                " ",
                " ",
                " "
            })

which would suggest that the "default" for the dsdt is to provide this 
in Watts. I'm guessing that the information in this is supposed to be 
overwriten by information from the battery (since I do get reasonable 
values), but I'm not sure where that's happening or what information is 
actually being provided by the battery. Is there any way I can verify 
that the battery itself claims to be measuring capacity in Watts, or 
track down where it's getting this idea? Is the current code behaving 
sanely elsewhere?

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
