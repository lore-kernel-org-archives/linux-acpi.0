From: =?ISO-8859-1?Q?Richard_K=F6rber?= <shred-lDxpuoTbsqf2eFz/2MeuCQ@public.gmane.org>
Subject: ACPI and Fedora Core 2?
Date: Tue, 07 Sep 2004 12:01:32 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <413D86FC.1040404@despammed.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello!

I am trying to use Cool'n'Quiet on my Athlon 64 system running Fedora 
Core 2 and a 2.6.7 kernel. Anyhow it seems that ACPI behaves strangely 
on my system.

As far as I found out, there should be nothing more to do than a 
"modprobe powernow-k8". Anyhow, I will always get the error message "No 
such device".

I think it's also strange that there is a /proc/acpi/ directory, but 
quite all of the directories in there are empty (e.g. there actually is 
a /proc/acpi/thermal_zone/ directory, but it is empty).

Booting the kernel with the "acpi=on apm=off" options set, didn't help 
either.

The ACPI module is compiled into the Fedora kernel by default, along 
with the Fan, Processor and Thermal Zone module. The other modules (AC 
Adapter, Battery, Button, ASUS and Toshiba laptop extras) are compiled 
as modules. The modules ac, battery and button are also shown in lsmod.

Strange enough, the asus_acpi module is loaded as well. It actually is 
an Asus mainboard, but it's not a notebook computer.

APM is also compiled into the kernel, but dmesg says it has been 
disabled on user request.

It's an AMD Athlon 64 3000+, Asus K8V SE Deluxe, and Fedora Core 2 (i386 
installation, I will wait for FC3 before I switch to x86_64).

I appreciate any advice how I could get ACPI and Cool'n'Quiet work 
properly. Thanks in advance!

Regards
-- 
Richard Körber -~- shred-lDxpuoTbsqf2eFz/2MeuCQ@public.gmane.org -~-



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
