From: "Wang, Zhenyu Z" <zhenyu.z.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: fan & thermal
Date: Fri, 3 Sep 2004 17:53:59 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <9DE394C12A921946AEECE1F71944ECD538596C@pdsmsx404>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nicolas Sabouret <Nicolas.Sabouret-L2FTfq7BK8M@public.gmane.org>
Cc: susinho-32FzPoaopq1AfugRpC6u6w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

It is like IBM Thinkpad R51.
No active cooling, No fan device. ACPI fan driver can't handle it.
Try to use acpi_os_name="Microsoft Windows NT" as kernel boot option to
see if that helps.

-zhen

-----Original Message-----
From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Nicolas Sabouret
Sent: 2004年9月3日 15:35
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: [ACPI] fan & thermal

Hi,

Please excuse me if this question has already been raised but I couldn't 
find an answer in the archive.

I have a compaq laptop with ACPI running Debian with acpid and acpi 
installed. My problem is that the fan is always on (whereas it is mostly 
silent when running on windows).

I looked in the doc and I don't understand why I am on active cooling 
whereas the temperature is below the trip point:
$ cat trip_points
critical (S5):           96 C
passive:                 90 C: tc1=4 tc2=3 tsp=40 devices=0xcbf6e6e8
$ cat temperature
temperature:             49 C

Note that I do not have an "active" trip point defined. Also note that 
/proc/acpi/fan is empty.

Thanks in advance for your help,
	Nico.

PS: Please CC me in your answer.
-- 
Nicolas SABOURET
Laboratoire d'Informatique de Paris 6 (LIP6)
8, rue du Capitaine Scott, 75015 Paris, France
http://www-poleia.lip6.fr/~sabouret


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
