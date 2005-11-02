From: Alejandro Bonilla Beeche <abonilla-N/cRWR3FREN3ZuITGxAgx9i2O/JbrIOy@public.gmane.org>
Subject: ACPI Errors, battery info is lost.
Date: Tue, 01 Nov 2005 20:51:14 -0700
Message-ID: <436837B2.6020408@linuxwireless.org>
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
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

    I have an IBM T42 Debian Sid, with latest BIOS and correct options 
(had old BIOS before and still same problem) Sometimes, when I'm running 
on Battery power, I get this problem, it might also occur when charging 
the battery.

I had opened a bug about it in bugzilla, but I never got an answer. I 
provided the acpidump and so on.

This so far with 2.6.13 and 2.6.14 dunno if also with older kernels.

Nov  1 19:27:12 localhost kernel:     ACPI-0292: *** Error: Looking up 
[SERN] in namespace, AE_ALREADY_EXISTS
Nov  1 19:27:12 localhost kernel:     ACPI-0508: *** Error: Method 
execution failed [\_SB_.PCI0.LPC_.EC__.GBIF] (Node c14cd600), 
AE_ALREADY_EXISTS
Nov  1 19:27:14 localhost kernel:     ACPI-0213: *** Error: Method 
reached maximum reentrancy limit (255)
Nov  1 19:27:14 localhost kernel:     ACPI-0508: *** Error: Method 
execution failed [\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node c14cd4c0), 
AE_AML_METHOD_LIMIT
Nov  1 19:27:16 localhost kernel:     ACPI-0213: *** Error: Method 
reached maximum reentrancy limit (255)


.Alejandro


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
