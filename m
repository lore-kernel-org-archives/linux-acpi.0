From: margitsw-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org (Margit Schubert-While)
Subject: ACPI 20030109 breaks kernel compile
Date: Sun, 12 Jan 2003 10:50:21 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4.3.2.7.2.20030112104633.00b64a90@pop.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,
	On 2.4.21-pre3 kernel compile fails as below.

	Margit

acpiphp_glue.c:233: parse error before '*' token
acpiphp_glue.c:234: warning: function declaration isn't a prototype
acpiphp_glue.c: In function `decode_acpi_resource':
acpiphp_glue.c:235: `acpi_resource_address16' undeclared (first use in this 
function)
acpiphp_glue.c:235: (Each undeclared identifier is reported only once
acpiphp_glue.c:235: for each function it appears in.)
acpiphp_glue.c:235: `address16_data' undeclared (first use in this function)
acpiphp_glue.c:236: `acpi_resource_address32' undeclared (first use in this 
function)
acpiphp_glue.c:236: `address32_data' undeclared (first use in this function)
acpiphp_glue.c:237: `acpi_resource_address64' undeclared (first use in this 
function)
acpiphp_glue.c:237: `address64_data' undeclared (first use in this function)
acpiphp_glue.c:253: `resource' undeclared (first use in this function)
acpiphp_glue.c:255: parse error before ')' token
acpiphp_glue.c:267: parse error before ')' token
acpiphp_glue.c:279: parse error before ')' token
acpiphp_glue.c:299: `acpi_resource' undeclared (first use in this function)
acpiphp_glue.c:299: parse error before ')' token
acpiphp_glue.c:312: `bridge' undeclared (first use in this function)
acpiphp_glue.c: In function `decode_hpp':
acpiphp_glue.c:395: `acpi_buffer' undeclared (first use in this function)
acpiphp_glue.c:395: parse error before "buffer"
acpiphp_glue.c:398: `acpi_object' undeclared (first use in this function)
acpiphp_glue.c:398: `package' undeclared (first use in this function)
acpiphp_glue.c:420: `buffer' undeclared (first use in this function)
acpiphp_glue.c:428: parse error before ')' token
acpiphp_glue.c: In function `add_host_bridge':
acpiphp_glue.c:500: `acpi_buffer' undeclared (first use in this function)
acpiphp_glue.c:500: parse error before "buffer"
acpiphp_glue.c:538: `buffer' undeclared (first use in this function)
acpiphp_glue.c: In function `find_host_bridge':
acpiphp_glue.c:810: `acpi_device_info' undeclared (first use in this function)
acpiphp_glue.c:810: parse error before "info"
acpiphp_glue.c:812: `acpi_buffer' undeclared (first use in this function)
acpiphp_glue.c:812: parse error before "buffer"
acpiphp_glue.c:815: `info' undeclared (first use in this function)
acpiphp_glue.c:827: `buffer' undeclared (first use in this function)
acpiphp_glue.c: In function `power_off_slot':
acpiphp_glue.c:875: `acpi_object_list' undeclared (first use in this function)
acpiphp_glue.c:875: parse error before "arg_list"
acpiphp_glue.c:876: `acpi_object' undeclared (first use in this function)
acpiphp_glue.c:907: `arg_list' undeclared (first use in this function)
acpiphp_glue.c:908: `arg' undeclared (first use in this function)
acpiphp_glue.c: In function `handle_hotplug_event_bridge':
acpiphp_glue.c:1104: `acpi_buffer' undeclared (first use in this function)
acpiphp_glue.c:1104: parse error before "buffer"
acpiphp_glue.c:1109: `buffer' undeclared (first use in this function)
acpiphp_glue.c: In function `handle_hotplug_event_func':
acpiphp_glue.c:1155: `acpi_buffer' undeclared (first use in this function)
acpiphp_glue.c:1155: parse error before "buffer"
acpiphp_glue.c:1158: `buffer' undeclared (first use in this function)
make[2]: *** [acpiphp_glue.o] Error 1
make[2]: Leaving directory `/usr/linux-2.4.21/drivers/hotplug'
make[1]: *** [_modsubdir_hotplug] Error 2
make[1]: Leaving directory `/usr/linux-2.4.21/drivers'
make: *** [_mod_drivers] Error 2



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
