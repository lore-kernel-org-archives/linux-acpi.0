From: Robert Woerle <robert.woerle-y2s3ugBAdl9BDgjK7y7TUQ@public.gmane.org>
Subject: Transmeta and the mem
Date: Mon, 02 Dec 2002 12:49:21 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3DEB48C1.20708@symplon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Guys

I dont know if its correct to put it here , but ACPI is also related to 
that .
I have a machine here ( Tablet PC ) which uses a Transmeta Crusoe TM 5600
CPU has the known CodeMorphing Technologie which uses 16MB Ram for 
itself ....

So Linux is not correctly detecting the amount of Ram i ve ( if i dont 
do cat /proc/meminfo ive the full
amount and not minus the 16MB for the Codemoprhing ) and ACPI is failing 
to start (AE_NOMEMORY)
Only if i do a "mem=XXXM" where XXX is the amount minus 16MB ....

So i was wondering if Linux is not correctly handling the Transmeta CPU 
(???!) which would be really a pity since there is a "famous guy" 
working for Transmeta ????

I also have several other problems , like PCI devices are not gracefully 
mapped .. and so on
Any hints ??

-- 
 
_____________________________________
*Robert Wörle
 Linux | Embedded Device*
*
Symplon AG*

*...touch the internet*

phone: +49 89 552 999 35
fax: +49 89 552 999 10
email: robert.woerle-y2s3ugBAdl9BDgjK7y7TUQ@public.gmane.org <mailto:robert.woerle@symplon.com>
web: www.symplon.com <http://www.symplon.com/>

_____________________________________
 



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
