From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Various Lockups with IBM T30
Date: Thu, 24 Oct 2002 09:14:41 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DF74@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: 'Ti Leggett' <leggett-zhzY/AYb9nBYTrM/R70HSA@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> From: Ti Leggett [mailto:leggett-zhzY/AYb9nBYTrM/R70HSA@public.gmane.org] 
> Good news! As of the latest patch against 2.4.20-pre11 I can boot with
> all ACPI options compiled in. The only downside is that it kinda fails
> and disables ACPI. I'm attaching my dmesg.
> 
> I haven't gotten anymore warnings since long time ago so I'm not even
> sure where to start to futz with the DSDT.

Hi Ti,

This is not good news. What happens is, the T30, in addition to having the
problems you were reporting before, also has a bug in the ECDT. The most
recent ACPI patch sees the ECDT bug, and terminates ACPI.

I've reported the ECDT bug to IBM, so we'll see what happens, but that is
just a mask for the other problem, which I haven't been able to diagnose
yet.

Which is a shame, because the T30 is a pretty awesome machine.

Regards -- Andy


-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ad.doubleclick.net/clk;4729346;7592162;s?http://www.sun.com/javavote
