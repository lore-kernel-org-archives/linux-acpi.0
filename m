From: Ludwig Meyerhoff <ludwig-KBAKnD37014@public.gmane.org>
Subject: ACPI and VIA C3
Date: Sun, 27 Jun 2004 23:17:16 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40DF395C.5010700@antar.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Hallo!

I have a VIA C3 (Ezra) processor. It is very nice for "normal"
applications, as it takes only a few watt.

I have a problem with the ACPI support of the kernel ...
While 2.4.20 recognizes the processor to support C1 and C2 states, the
2.4.26 does not, as the 2.6.6 does not also.

AFAIK the ACPI support has been rewritten for the 2.6 kernel and
backported to 2.4 in 2.4.23 or something ...

Now: does anyone know how I can achieve full ACPI support for my
processor in a more recent kernel than 2.4.20? In special I would like
to use frequency scaling/throttling, as most of the time my small
computer does nothing.

I already tried the epia1 patch on the 2.6.6 kernel and the acpi patch
on 2.6.7 kernel, both without a satisfying result ...




Saluti!

Ludwig





-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
