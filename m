From: Phillip Susi <psusi-3tLf1voIkJTQT0dZR+AlfA@public.gmane.org>
Subject: Asus K8V Deluxe VIA SATA RAID power management problem
Date: Mon, 14 Nov 2005 16:18:02 -0500
Message-ID: <4378FF0A.4070301@cfl.rr.com>
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

I have noticed that when I suspend my system, on resume the via_sata 
driver complains about an unexpected status of 0x80 in register 0xE000, 
then seems to fail the first IO request to the disk, then times out, and 
then seems to recover.  Usually this causes the resume script to fail to 
execute, as the failed IO seems to fill the buffer cache with zeros 
instead of retrying the operation, and the kernel fails to execute a 
binary that starts with zeros.  I have noticed that if I manually echo 
mem > /sys/power/state, when the system resumes and no IO is performed 
for a few seconds, these errors do not happen.

This leads me to believe that the sata controller simply needs a bit of 
time after the resume to completely reset before it can be accessed. 
The question is, where does this delay belong?  From reading the ACPI 
specifications, it looks like it is up to the driver to call _GTF to get 
the state of the controller before suspending, and then to restore that 
state after resume.  Does the via_sata driver call some code to do this, 
and should the delay be after restoring the registers?  Or is there an 
ASL routine in the DSDT that is called when restoring that I should add 
a delay to?



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
