From: Peter Muessig-Trapp <muessig-trapp-S0/GAf8tV78@public.gmane.org>
Subject: system crashes after cat /proc/acpi/battery/BAT0/state
Date: Sun, 01 Feb 2004 17:24:57 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <401D2859.5090205@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

after

cat /proc/acpi/battery/BAT0/state

the system print out battery informations but after 5 seconds the system 
crashs
completely.
I can't find any error messages in /var/log/messages which helps me
understanding whats going on.

Anyone any idea, what's going on? Or what can I do, to get any helpfull
hints?

I am using kernel 2.6.0 Debian/sid.

cat /proc/acpi/info
version:                 20031002

cat /proc/acpi/battery/BAT0/info

present:                 yes
design capacity:         3876 mAh
last full capacity:      3876 mAh
battery technology:      rechargeable
design voltage:          14800 mV
design capacity warning: 388 mAh
design capacity low:     0 mAh
capacity granularity 1:  100 mAh
capacity granularity 2:  100 mAh
model number:            Primary
serial number:           56E0
battery type:            4E4F494C
OEM info:                 COMPAQ

Thanks for any help!

Peter Muessig-Trapp



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
