From: Adrian Turcu <adriant_ie-YSGFQ8SKJZVDPfheJLI6IQ@public.gmane.org>
Subject: Re: ACPI on the Compaq Presario 735CA
Date: Tue, 07 Jan 2003 09:43:55 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E1AA15B.2010104@myrealbox.com>
References: <200207120750.g6C7oMBc007838@webmail.dowco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: colinh-RZoC8ttgCzkAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, iw3grx-u0TjAE20a3NeoWH0uzbU5w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi guys,

I have a Compaq 724EA (AMD Duron 1.2G, VIA chipset  VT8363/8365 
[KT133/KM133]) and a while ago I managed to make it work in linux 
finally with a bit of struggle. At the beginning I was using the kacpid 
patch as someone suggested and 2.4.18 kernel. It was doing the job quite 
well (the laptop was able to boot fine, the fan was somehow 
'controlled', but the whole thing was freezing after I'd say 8-10 hours 
of working). Then, I found starting with kernel 2.4.19 and the latest 
iasl from Intel that I don't need anymore kacpid patch. I still get the 
error during the boot ("SCI issues C2 disabled" and Compaq revisions and 
.... bla bla bla, which I don't like them but I didn't find yet how to 
get rid of them), but at least is working just fine. So, what I was 
doing, because tales and stories everyone can say:

- vanilla kernel 2.4.20 (www.kernel.org)
- acpi patch version 20021212 (http://sourceforge.net/projects/acpi/)
- iasl compiler - source code 
(http://www.intel.com/technology/iapc/acpi/downloads.htm)

Now:

- unpack kernel source code and apply acpi patch
- unpack iasl source tree, go to compiler subdirectory, and run make. 
You'll get iasl binary.
- cat /proct/acpi/dsdt > dsdt.dat
- ./iasl -d dsdt.dat . You'll get dsdt.dsl
- ./iasl -tc dsdt.dsl. You'll probably get some errors (at the end is a 
broken dsdt table you have to correct it). It seems that warnings are 
not too bad [gee... some one probably want to kill me for this :)]
- read through http://progs.fleischer.hu/dsdt/acpi-howto.html and 
correct the errors above (modify dsdt.dsl file)
- ./iasl -tc dsdt.dsl and copy dsdt.hex to 
<your_linux2420_source_tree>/drivers/acpi/tables/acpi_dsdt.c
- compile your kernel with:
        CONPIG_PM=Y
        CONFIG_APM=N
        CONFIG_ACPI=Y
            CONFIG_ACPI_AC=Y
            CONFIG_ACPI_BAT=Y
            CONFIG_ACPI_BUTTON=Y
            CONFIG_ACPI_FAN=Y
            CONFIG_ACPI_PROCESSOR=Y
            CONFIG_ACPI_THERMAL=Y
            CONFIG_ACPI_DEBUG=Y
- install your kernel and boot it up with 'pci=noacpi'

That's it. I hope you'll make your Compaqs work in linux. You'll have a 
lot of fun.

Cheers,
Adrian



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
