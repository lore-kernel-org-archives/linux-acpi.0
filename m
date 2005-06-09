From: Iacopo Iacopini <iacopo-saiBszjk4DZeoWH0uzbU5w@public.gmane.org>
Subject: ACPI problem for Acer Aspire 1680 serie definitively resolved
Date: Thu, 09 Jun 2005 11:53:35 +0200
Message-ID: <42A8119F.90803@whoopy.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

Problem with ACPI for Acer Aspire Laptops 1680 serire (1681WLCi) 
DEFINITIVELY RESOLVED

Yesterday night (09 Jun 2005) I resolved all my problem for this kind of 
laptop that use non standard DSDT. Befor I was unable to find anithing 
into the directory /proc/acpi/ac_adapter and /proc/acpi/battery and I 
was unable to see the status of my battery. Moreover I my ACPI doesn't 
work properly. I use SuSe 9.3 but I think with some modification this 
guide is usefull for every kind of distribution.
This is a version 1.0 of this guide, not definitive!! I'm writing it as 
fast as possible to give you the possibility to take in account this way 
to solve the problem. In the next days I will a more definitive guide at 
this address

www.whoopy.it/linux/

at this link you can find this document too and all the files that are 
requested in this document
Everyone who want to help me or contribute to this work is welcome < 
linux-saiBszjk4DZeoWH0uzbU5w@public.gmane.org >


I hope this is usefull to you
Iacopo_I
linux-saiBszjk4DZeoWH0uzbU5w@public.gmane.org



Patch to Kernel for SuSe 9.3

1) Download acpi_patch.tar.gz:
   This kind of Laptops has another problem over the bugged DSDT, there 
is a missing ECDT. The ECDT is used to provide some minimal information 
about the Embedded Controller to the ACPI drivers before the Embedded 
Controller region has actually been parsed from the DSDT. This is 
frequently necessary before initializing the battery and ac adapter, so 
if you have errors in dmesg from the battery, adapter or 
EmbeddedControl, the ECDT is the likely culprit. The problem was that 
after booting, my /proc/acpi/ac_adapter and /proc/acpi/battery 
directories were empty.
   To resolve this problem there is a patch at this address 
http://bugzilla.kernel.org/attachment.cgi?id=1690&action=view . This 
patch restore the missing ECDT-related functionality. It may be applied 
to both the 2.4 and 2.6 kerenl source. If you are using Suse 9.3 it 
does't work, because the sources file name change, but the code is the 
same. In the file acpi_patch.tar.gz you can find all the corrected files 
you need, you have only to copy them into the appropriate directory of 
your sistem (after a back-up of existing files!! - Naturally! ;P ).

   Files to modify:
   #################################

   1) PATH_TO_KERNEL/drivers/acpi/ec.c
   2) PATH_TO_KERNEL/drivers/acpi/events/evregion.c
   3) PATH_TO_KERNEL/drivers/acpi/executer/exregion.c
   4) PATH_TO_KERNEL/drivers/acpi/utilities/utglobal.c
   5) PATH_TO_KERNEL/include/acpi/acglobal.h
   6) PATH_TO_KERNEL/include/acpi/acinterp.h

   Probably you have to change the "PATH_TO_KERNEL" with 
"/usr/src/linux", but is better tha you follow your system documentation.

2) Download dsdtAspire1680.tar.gz:
   This file contain the correct DSDT file for the Acer laptops of serie 
1680 (as 1681, 1681Wlmi, 1681Wlci, 1682.. etc..). The other two files 
are the patch you need to use the Smart Battery that this kind of 
laptops use. At this address https://sourceforge.net/projects/sbs-linux/ 
you can find the SourceForge project dedicate to this. Here you can find 
the offcial patch, but it doesn't work on 1680 if you don't modify 
before the dsdt. In the file you find the work done, you have only to 
untar the archive and follow next steps.

3) Download iasl:
   You have to install somewere in your path the compiler iasl of Intel, 
you can find last version at this address 
http://developer.intel.com/technology/iapc/acpi/downloads.htm it is 
necessary to compile the correct DSDT for your system.

4) Recompile dsdt:
   Go into the directory where you have extract the 
dsdtAspire1680.tar.gz file.
   iasl -td dsdt.dsl
   this will create two files dsdt.hex and DSDT.aml, they ae usefull for 
next steps

5) Fixing the dsdt:
   If there are some errors douring step 4 you need to correct them. But 
I think there aren't. Looks at Google for fixing the problem, as soon as 
possible I will put on-line a guide to correct some errors.

6) Incorporatng fixed DSDT into the Kernel
   If you are using SuSe there are non problems
       6a) copy the compiled DSDT.aml file e.g. to /etc
        6b) add the path pointing to e.g. /etc/DSDT.aml to 
/etc/sysconfig/kernel
            ACPI_DSDT="/etc/DSDT.aml"
   If you are not using Suse visit 
http://forums.gentoo.org/viewtopic.php?t=122145 on thi forum you can 
find at chapter 9 some useful ways to do this.

7) Make sure you have done the step 1, 2, 3, 4, 5, 6

8) Recompile your kernel
   8a) cd /usr/src/linux
   8b) make
   8c) make modules_install
   8d) make install

9) Reboot


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
