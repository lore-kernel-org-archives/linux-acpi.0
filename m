From: Ivor Hewitt <ivor-rtBon1mkn18@public.gmane.org>
Subject: Z600 screen restore
Date: Mon, 27 Sep 2004 18:49:16 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200409271849.16833.ivor@ivor.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

Hi,
I have a Sony vaio Z600-hek (same as US model Z505). Which I've been trying to 
get working with ACPI for a while....

On S3 restore the screen would power up and flash briefly and then power down 
immediately although the machine was now up and running. 

using "acpi_sleep=s3_mode" makes no difference.
"acpi_sleep=s3_bios" causes the machine to crash on s3 restore.

but if I comment out the two tests:-

#       testl   $1, video_flags - wakeup_code
#       jz      1f
and
#       testl   $2, video_flags - wakeup_code
#       jz      1f

the machine restores from s3 successfully and the screen powers up... so that 
appears to be the area of the problem...
any suggestions what the 'correct' fix for this would be?

Cheers,

-- 
Ivor Hewitt.
http://www.ivor.it - tech | http://www.ivor.org - hedge


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
