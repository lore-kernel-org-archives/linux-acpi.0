From: "Pete Phillips" <pete-MnLiQe5rda21Qrn1Bg8BZw@public.gmane.org>
Subject: (no subject)
Date: Fri, 06 Feb 2004 20:58:25 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200402062058.i16KwPA5028014@lap1.smtl.co.uk>
Reply-To: pete-MnLiQe5rda21Qrn1Bg8BZw@public.gmane.org
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi

I took delivery yesterday of an ASUS s1300N laptop. I have got 2.4.22
and 2.4.24 kernels with latest acpi patches. (I am running Suse 9.0 -
the default kernel sucks with almost 100% keventd sucking the life out of
the thing).

If I boot with acpi=off they boot perfectly well, minus of course acpi
support! Also boot OK with acpi=ht.
 
However, with acpi=on, they just hang  after the "linux loading"
sequence.
 
dmesg says that the ACPI has wakeup address 0xc0001000.
 
I am completely flumoxed !  I have seen numerous docs claiming that the
S1300N is fine with ACPI, so either the BIOS in mine is different (?) or
I am being a complete prat. (I accept that the latter is highly likely!)

Any ideas ?

Pete
--
Pete Phillips, Deputy Director,     |   http://www.smtl.co.uk/
Surgical Materials Testing Lab,     |   http://www.worldwidewounds.com/
Princess of Wales Hospital, S Wales |   http://www.dressings.org/
Tel/Fax: +44 1656-752820/30         |   pete-MnLiQe5rda21Qrn1Bg8BZw@public.gmane.org


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
