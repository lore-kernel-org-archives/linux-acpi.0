From: Dan <overridex-Kz9Au3A7zptBDgjK7y7TUQ@public.gmane.org>
Subject: throttling resets when checking temp?
Date: Thu, 10 Jun 2004 04:13:29 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1086855209.25639.4.camel@nazgul.overridex.net>
Mime-Version: 1.0
Content-Type: text/plain
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

Hi there, I'm having what seems to be an odd problem to me.  when I
change my cpu throttling by running a command like:

echo 3 > /proc/acpi/processor/CPU0/throttling

it changes the throttling as it should, and

cat /proc/acpi/processor/CPU0/throttling

show's it's on the right setting, however if I run acpi -t or 

cat /proc/acpi/thermal_zone/THM0/temperature

the cpu throttling is reset to T0 in
/proc/acpi/processor/CPU0/throttling - what's the heck is causing this
and how can I change it?  It gets especially annoying when I have
gkrellm constantly displaying my temperature. I'm running kernel 2.6.5
with the acpi from that, though it's also happened as far back as kernel
2.6.0.  I'm running on a sager brand notebook that's a few years old.

Please cc me any replies, as I'm not subscribed to this list

============================
-Dan "OverrideX"-
ICQ: 7171522
AIM: OverrideX
Jabber: OverrideX-/eSpBmjxGS4dnm+yROfE0A@public.gmane.org

I have often regretted my speech, never my silence. -- Publilius Syrus




-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
