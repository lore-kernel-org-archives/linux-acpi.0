From: Marci <voloterreno-nc/lrvXPQ4s@public.gmane.org>
Subject: [Fwd: ACPI error when trying entring in Sleep Mode]
Date: Mon, 17 Mar 2003 13:50:46 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E75C4A6.6000507@tin.it>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020901040504080809040101"
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

This is a multi-part message in MIME format.
--------------020901040504080809040101
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

No Ideas?

Please :(

I need this

Thanks again

--------------020901040504080809040101
Content-Type: message/rfc822;
 name="ACPI error when trying entring in Sleep Mode"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ACPI error when trying entring in Sleep Mode"

Message-ID: <3E74DD8D.1090602-nc/lrvXPQ4s@public.gmane.org>
Date: Sun, 16 Mar 2003 21:24:45 +0100
From: Marci <voloterreno-nc/lrvXPQ4s@public.gmane.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030311 Debian/1.2.1-10
X-Accept-Language: en
MIME-Version: 1.0
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: ACPI error when trying entring in Sleep Mode
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi all, here my configuration :

MSI KT4 Ultra

Athlon XP 2400+

Nvidia Geforce 3 Ti200


I have this problem:

When I try to enter in S1 sleep mode appears in the screen these errors:

Mar 16 21:08:17 magisystem kernel:  exfldio-0129 [31] ex_setup_region 
     : Field [U1PE] access width (2 bytes) too large for region [UBP1] 
(length 1)
Mar 16 21:08:17 magisystem kernel:  exfldio-0140 [31] ex_setup_region 
     : Field [U1PE] Base+Offset+Width 0+0+2 is beyond end of region 
[UBP1] (length 1)
Mar 16 21:08:17 magisystem kernel:  dswexec-0421 [23] ds_exec_end_op 
     : [Store]: Could not resolve operands, AE_AML_REGION_LIMIT
Mar 16 21:08:17 magisystem kernel:  psparse-1121: *** Error: Method 
execution failed [\_PTS] (Node c15bc5e8), AE_AML_REGION_LIMIT
Mar 16 21:08:17 magisystem kernel:  hwsleep-0257 [15] 
acpi_enter_sleep_state: Entering sleep state [S1]
Mar 16 21:08:17 magisystem kernel:    evgpe-0351: *** Error: 
acpi_ev_gpe_dispatch: No handler or method for GPE[00], disabling event
Mar 16 21:08:18 magisystem kernel:  exfldio-0129 [32] ex_setup_region 
     : Field [U1PE] access width (2 bytes) too large for region [UBP1] 
(length 1)
Mar 16 21:08:18 magisystem kernel:  exfldio-0140 [32] ex_setup_region 
     : Field [U1PE] Base+Offset+Width 0+0+2 is beyond end of region 
[UBP1] (length 1)
Mar 16 21:08:18 magisystem kernel:  exfldio-0129 [32] ex_setup_region 
     : Field [U1PE] access width (2 bytes) too large for region [UBP1] 
(length 1)
Mar 16 21:08:18 magisystem kernel:  exfldio-0140 [32] ex_setup_region 
     : Field [U1PE] Base+Offset+Width 0+0+2 is beyond end of region 
[UBP1] (length 1)
Mar 16 21:08:18 magisystem kernel:  psparse-1121: *** Error: Method 
execution failed [\_WAK] (Node c15bc768), AE_AML_REGION_LIMIT
Mar 16 21:08:18 magisystem kernel:  hwsleep-0428: *** Error: Method _WAK 
failed, AE_AML_REGION_LIMIT
Mar 16 21:08:18 magisystem kernel:    evgpe-0351: *** Error: 
acpi_ev_gpe_dispatch: No handler or method for GPE[00], disabling event

Anyone have ideas?

The command that I do is "echo 1 > sleep" in the /proc/acpi directory. 
The kernel is the 2.4.21-pre4 with the lastest patch.
The system is the Linux Debian Sid OS

Thanks for your help and time

Bye

Marcello


--------------020901040504080809040101--



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
