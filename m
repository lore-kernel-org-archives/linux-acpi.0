From: "Ing. Jan Slezak" <jan.slezak-aRb0bU7PRFPrBKCeMvbIDA@public.gmane.org>
Subject: Re: ACPI 20030109 + Kernel 2.4.21-pre3 + Dell
Date: Fri, 17 Jan 2003 16:07:11 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E281C1F.DEEA74F3@centrum.cz>
References: <E18ZGQ1-0006sN-00@sc8-sf-list2.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
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

Hi

I have same problem as Marco. I have Dell Latitude C640 and most of the
numerical values in the /proc FS are zero or equivalent. And in addition
battery module produces a lot of "Warning: Buffer created with zero
length in AML". I had a short look at the dissasembled DSDT and it seems
that some code is executed conditionally based on operation system
running on the laptop. Are not all the problems with ACPI on Dell caused
by nonstandard implementation of ACPI by Dell? I had same problems also
with ACPI 20021212 and kernel 2.4.20. Do any of you have any suggestion?

Thanks

Jan


-------------------------------------------------------
This SF.NET email is sponsored by: Thawte.com - A 128-bit supercerts will
allow you to extend the highest allowed 128 bit encryption to all your 
clients even if they use browsers that are limited to 40 bit encryption. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0030en
