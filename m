From: Florian-Daniel Otel <otel-lB76kahZbiyci/EUP2OQSw@public.gmane.org>
Subject: Compilation failure (acpi-20030523-2.4.21-rc3 + 2.4.21)
Date: Mon, 16 Jun 2003 07:47:04 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <16109.23000.292802.377210@solen.ce.chalmers.se>
Reply-To: Florian-Daniel Otel <otel-lB76kahZbiyci/EUP2OQSw@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



After cleanly applying acpi-20030523-2.4.21-rc3.diff on top a vanilla
2.4.21, the compilation failed with:


gcc -D__KERNEL__ -I/nfs/__No_NFS/playground/linux-2.4.21-pre8-laptop1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=0 -malign-jumps=0 -malign-loops=0 -DMODULE -DMODVERSIONS -include /nfs/__No_NFS/playground/linux-2.4.21-pre8-laptop1/include/linux/modversions.h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=acpiphp_glue  -c -o acpiphp_glue.o acpiphp_glue.c
acpiphp_glue.c: In function `find_host_bridge':
acpiphp_glue.c:815: warning: passing arg 2 of `acpi_get_object_info_R4d2dc830' from incompatible pointer type
acpiphp_glue.c:821: subscripted value is neither array nor pointer
acpiphp_glue.c:826: incompatible type for argument 1 of `strcmp'
gmake[2]: *** [acpiphp_glue.o] Error 1
gmake[2]: Leaving directory `/nfs/__No_NFS/playground/linux-2.4.21-pre8-laptop1/drivers/hotplug'
gmake[1]: *** [_modsubdir_hotplug] Error 2
gmake[1]: Leaving directory `/nfs/__No_NFS/playground/linux-2.4.21-pre8-laptop1/drivers'
gmake: *** [_mod_drivers] Error 2


The relevant (?) parts from the .config: 

[...]

CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=y
CONFIG_CARDBUS=y
# CONFIG_TCIC is not set
CONFIG_I82092=y
CONFIG_I82365=y

#
# PCI Hotplug Support
#
CONFIG_HOTPLUG_PCI=m
# CONFIG_HOTPLUG_PCI_COMPAQ is not set
# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
CONFIG_HOTPLUG_PCI_ACPI=m

[....]



The compilation was done on a P4/Knoppix v3.2 (Debian unstable and egcs-2.95):

gcc -v 
Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.4/specs
gcc version 2.95.4 20011002 (Debian prerelease)



Any ideas ?  Other info avail on request.


TIA,


Florian
 
 
P.S. Pls Cc: me on the replies, I'm not on this list.

> 


-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
