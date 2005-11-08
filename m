From: "sdfa" <slinky1776-wzCN7aUSXSrQT0dZR+AlfA@public.gmane.org>
Subject: Re: hard drive errors on acpi s3 resume
Date: Mon,  7 Nov 2005 22:06:27 -0500 (EST)
Message-ID: <20051108030627.93670109EB8@xprdmailfe1.nwk.excite.com>
Reply-To: slinky1776-wzCN7aUSXSrQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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


wow, i didn't expect so many responses, thanks alot!



about the patch:

i'll try that patch and tell you guys how it goes.



about checking the dsdt:

i dont have much experience with dsdts, so i dont know how to check them, edit them, definitely wouldnt know what interesting behavior might constitute. but this guy here: http://linux.highsphere.net/howtos/b100b.php has almost the exact same laptop as i do(the only difference is screensize, i believe) and he didn't seem to have any problems with his dsdt, though he doesnt seem to have this hard drive issue(or isnt aware of it, he does mention it taking about 40 seconds to resume from s3).



about spinning the drive down before s3: 

when i do a hdparm -y /dev/hda, the drive immediately spins back up, probably due to some logger daemon. i've tried killing syslogd and klogd, but this still happens.



about it being an ide driver problem:

if it is an ide driver issue, can anybody point me in the right direction? maybe an ide driver mailing list or something? i'm believe i'm using the PIIX driver(i've got an ich4-m ide controller), but i havent been able to find a development website or anything for it. the help in menuconfig said that PIIX was for ich4 ide controllers, so i was hoping to find some intel-sponsored ich4-m driver development, but no luck.

_______________________________________________
Join Excite! - http://www.excite.com
The most personalized portal on the Web!




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
