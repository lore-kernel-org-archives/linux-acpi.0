From: "A. Auquier" <a.auquier-BedXh0tyk8Y@public.gmane.org>
Subject: DSTD "fixed" but still dmesg errors
Date: Tue, 06 Jul 2004 14:35:24 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1089117324.2349.31.camel@darkmobil>
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

Hello everybody.


I tell you my little story...
I have a Medion MD41300 laptop and I installed Gentoo on it.
(P4 3.06 HT + i820 chipset)
I'm using 2.6.4 kernel (with smp and acpi support).
My system crashed when I was under X.
(I also tried 2.4.26 and 2.6.6...)
After some times, I saw that there was no crash anymore when I turned
off acpi.
So I try to fix it and I read this thread:
http://forums.gentoo.org/viewtopic.php?t=122145

My original dsdt:
http://auquier.net/acpi/dsdtbad.dsl
The isal errors:
http://auquier.net/acpi/iaslerrors.txt
My 'fixed' dsdt:
http://auquier.net/acpi/dsdtgood.dsl
The differences between the dsl:
http://auquier.net/acpi/diffdsdt.txt

And iasl compiled it with no error.
I booted with this new dsdt (initrd) but I was still having crashes and
errors in dmesg.

My entire dmesg:
http://auquier.net/acpi/dmesg.txt

I read more the thread about howto fix ACPI and try to boot with
'noapic' and had no more crashes (and ACPI working) !

So I have some questions:
1) Did I fix my dsdt correctly ?
2) What can I do to deal with my dmesg errors ?
3) Is it possible to use APIC with ACPI ?

My lilo.conf:
http://auquier.net/acpi/lilo.txt


Thank you all for the help !

Alexandre



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
