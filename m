From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Various questions about EC and the spec
Date: Thu, 3 Jul 2003 15:51:03 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030702163127.T90754@root.org>
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

1. The 2.0B spec has a typo, I believe.  Section 13.3.3 says "remain
dedicated to the OSPM for ~1 microsecond"  when I believe it should be
"~1 millisecond".  (See "Total Burst Time" which is correct I believe).

2. The last sentence of 13.2.1 conflicts with 13.3.3.  13.2.1 says that
burst mode prevents the overhead of SCIs.  However, 13.3.3 says that while
in burst mode, the EC continues to generate SCIs as normal.  Which is it?

3. The description of disabling burst mode (13.3.3) says the same
thing twice.  The last two sentences both say the EC clears the burst
enable bit.  I think the last sentence should be removed.

4. I was looking at different implementations of EcSpaceHandler().  Ours
in FreeBSD can handle any width divisible by 8 (8,16,32).  Linux handles
widths == 8.  Since the EC space is 256 8 bit bytes, is multi-byte access
required?  Thoughts on if it will ever be?

Thanks,
-Nate


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
