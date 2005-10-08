From: Phillip Susi <psusi-3tLf1voIkJTQT0dZR+AlfA@public.gmane.org>
Subject: Asus K8V Delux broken acpi tables?
Date: Sat, 08 Oct 2005 01:44:59 -0400
Message-ID: <43475CDB.6070204@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

As requested, I have attached the output of lspci, dmidecode, dmesg, and 
acpidump.   To keep the size down, they are in a tarball. 

There seems to be something wrong with the acpi tables in the bios 
because when I try to suspend or hibernate I see things like this:

[   32.830712]     ACPI-0508: *** Error: Method execution failed 
[\_SB_.PCI0.IDE C.RATA] (Node ffff81003f0da980), AE_AML_OPERAND_VALUE
[   32.830794]     ACPI-0508: *** Error: Method execution failed 
[\_SB_.PCI0.IDE C.CHN0.DRV0._GTF] (Node ffff81003f0d9100), 
AE_AML_OPERAND_VALUE

Hibernation seems to work anyhow, but suspend to ram does not.  When I 
wake back up from being suspended to ram, the sata disk driver 
complained that a register was in an incorrect state, and the system hung. 

Could someone help me figure out how to correct this?




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
