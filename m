From: "Wang, Zhenyu Z" <zhenyu.z.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Urgent support needed on thermal zone
Date: Fri, 2 Jul 2004 10:27:00 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <6E0C289723A0564F9A8279E236E8565F07B37E07@pdsmsx402.pd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Gaetano Sferra <gaesferr-VGgt2q2+T+FeoWH0uzbU5w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

There is a known issue with cooling_mode, see http://bugme.osdl.org/show_bug.cgi?id=1770
Can you attach your /proc/acpi/dsdt ?
 

-----Original Message-----
From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Gaetano Sferra
Sent: 2004年7月2日 0:03
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: [ACPI] Urgent support needed on thermal zone

Hello,
I've installed Fedora Core 2 on my Fujitsu-Siemes AMILO D laptop (kernel
2.6.5) and the acpi software
behavior seems strange to me (I'm a newbie) so I've some questions for you:

1. I didn't found an acpi patch for my kernel so... it's ok or I need
something else (like a kernel upgrade)?
2. Looking in /proc/acpi/thermal_zone/THRM file I see:
       cooling_mode contains "<not supported>"
       temperature contains something like "75 C" (strange, the CPU should
be a jam but still work)
       state contains "ok"
       trip_point contains "critical: 85 C"
    The question is: "Is my CPU in danger or acpid doesn't work properly?"
    The contents of the /proc/acpi/thermal_zone/THRM/temperature doesn't
change
    (it reports "75 C" value even if I've just turn on the PC)  but the fan
seems to
    work properly (the pc is a little hot above usual but.... it's, may be,
for the summer?).
3. Is the ACPI software the only one that control the temperature and work
with fan or is there an hardware
    controller also? In other words: "Why in the kernel configuration the
thermal zone help says that if it isn't
    enabled on laptops the CPU may be damaged?"
4. What I can do?

Thank you for support and for your good work,
Gaetano Sferra




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
