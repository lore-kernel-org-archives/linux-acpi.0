From: Thomas Alderweireld <Thomas.Alderweireld-vJEk5272eHo@public.gmane.org>
Subject: ACPI can't read battery status
Date: Thu, 20 Feb 2003 10:38:45 +0100 (CET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0302201033430.27148-100000@lxplus066.cern.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

Dear All, 
ACPI can't read the battery status on my TravelMate427:
Here follows my battery (Model SANYO BATBCL11) 
proc/acpi/Battery/BAT1 informations:
[root@laptom BAT1]# more info
present:                 yes
design capacity:         6300 mAh
last full capacity:      6300 mAh
battery technology:      rechargeable
design voltage:          11100 mV
design capacity warning: 585 mAh
design capacity low:     175 mAh
capacity granularity 1:  64 mAh
capacity granularity 2:  64 mAh
model number:            GC86508SAT0
serial number:
battery type:            LiON
OEM info:                SANYO
[root@laptom BAT1]# more state
present:                 yes
ERROR: Unable to read battery status
[root@laptom BAT1]# more alarm
alarm:                   unsupported

Any Idea how I can fix this ????

Thanks

Tom

NB: I would like to thanks Acpi people for their fast answer of my 
yesterday's mail.




-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
