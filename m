From: "Anthony J. Breeds-Taurima" <tony-xfCdrj5MXxYnC9Muvcwxkw@public.gmane.org>
Subject: swsusp acpi-20021022
Date: Thu, 31 Oct 2002 09:50:36 +0800 (WST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0210310944170.11540-100000@thor.cantech.net.au>
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

Hello All,
	Firstly I'm not 100% certain if this is better here or LKML, If I'm
wrong then I'll happily move the discussion there.

I'm running kernel 2.5.44 with the acpi-20021022 aptches applied.  I do how
ever have a small problem.  I have tested swsusp and the suspend went well.
Unfortuantly I get an ooops on resume.  I'm happy to look at the cause
(provide oops and ksyms) BUT the docs say more or less "If you touch your FS
between suspend and resume then kiss your data goodbye".

What I need to know is what is the safest way to get my machine back?
Can I just boot into another kernel and hope my FS won't be too badly
corrupted?

In case it matters I have a sony Vaio PCGFX990
(http://www.sony.com.au/vaio/products/index.cfm?catid=19479&prodid=PCGFX990)

Yours Tony

   Jan 22-25 2003           Linux.Conf.AU            http://linux.conf.au/
		  The Australian Linux Technical Conference!



-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0004en
