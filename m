From: Sourav K Mandal <smandal-DPNOqEs/LNQ@public.gmane.org>
Subject: Re: Problem with Compaq Presario 27xx
Date: Thu, 01 Aug 2002 19:03:09 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200208012303.TAA01367@department-of-alchemy.mit.edu>
References: <D8C1802AADD0D346BE5C0A1D117075CC02C1C860@cceexc17.americas.cpqcorp.net>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: Your message of "Thu, 01 Aug 2002 17:49:05 CDT."
             <D8C1802AADD0D346BE5C0A1D117075CC02C1C860-pKAD8otJBe2P0FQRY6S+e9kSKC0Mw0DFJ8am2ALHCgk@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: "Black, Richard" <Richard.Black-VXdhtT5mjnY@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> What fix do I need so that I can proceed to repack my dsdt table?

Use:

http://people.freebsd.org/~takawata/pacpidump.tar.gz

cat dsdt.dat | pacpidump > dsdt.asl

Then proceed.  The output you see with acpidisasm is _not_
assembly code.


Sourav


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
