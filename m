From: Christian Neubauer <neu-XoJDOot2J3yELgA04lAiVw@public.gmane.org>
Subject: Compaq Evo800c: s4bios, s3, s4 anybody got this running?
Date: Wed, 12 Mar 2003 06:54:22 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E6ECB8E.4090706@iis.fhg.de>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I use a Compaq Evo800c with 2.4.21-pre5-acpi280303 with patch DSDT 
tables. Battery, AC, etc. are showing up in /proc/acpi. The system 
claims to support S3, S4 and S4BIOS. So far so good.

I tried S4BIOS with the kernel-option acpi_sleep=s4bios as well as the 
os_name kernel switches (dont remember the excat names of these options ;-)

As soon I do echo 4 >/proc/acpi/sleep the system clears the console, 
backlight stays on and the machine hangs.

Any ideas how to trace this down, or is the behavior known ?

Is anybody out there who got suspend or standby running on this machine 
or an presario laptop which is hardware compatibe ?

Best regards
Christian

-- 
Dr. Christian Neubauer                          Phone: +49 9131 776-355
FhG-IIS A, Audio & Multimedia                   Mobil: +49  160 5840467
Am Wolfsmantel 33, D-91058 Erlangen, Germany    Fax:   +49 9131 776-398



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
