From: "Eric L. Schott" <eschott-KNIoUGFsjeKVc3sceRu5cw@public.gmane.org>
Subject: ACPI & Thinkpad T40
Date: 19 Aug 2003 08:46:05 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1061297164.3172.13.camel@sinai.arl.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain
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

I have a Thinkpad T40 and have had mixed success with ACPI.  I have
found that revision 20030328 works well.  I can see the battery, etc. 
However, with any latter releases, I have problems.  For example, with
20030619, I have

Aug 19 08:22:55 eric kernel:     ACPI-0345: *** Error: Handler for
[EmbeddedControl] returned AE_TIME
Aug 19 08:22:55 eric kernel:     ACPI-1121: *** Error: Method execution
failed [\_SB_.PCI0.LPC_.EC__.BAT0._STA] (Node f7ff3200), AE_TIME
Aug 19 08:22:55 eric kernel:     ACPI-0345: *** Error: Handler for
[EmbeddedControl] returned AE_TIME
Aug 19 08:22:55 eric kernel:     ACPI-1121: *** Error: Method execution
failed [\_SB_.PCI0.LPC_.EC__.BAT1._STA] (Node f7ff3380), AE_TIME
Aug 19 08:22:55 eric kernel:     ACPI-0345: *** Error: Handler for
[EmbeddedControl] returned AE_TIME
Aug 19 08:22:55 eric kernel:     ACPI-1121: *** Error: Method execution
failed [\_SB_.PCI0.LPC_.EC__.AC__._PSR] (Node f7ff3480), AE_TIME
Aug 19 08:22:55 eric kernel:     ACPI-0345: *** Error: Handler for
[EmbeddedControl] returned AE_TIME
Aug 19 08:22:55 eric kernel:     ACPI-1121: *** Error: Method execution
failed [\_PR_.CPU_._PPC] (Node f7fca9c0), AE_TIME
Aug 19 08:22:55 eric kernel:     ACPI-0345: *** Error: Handler for
[EmbeddedControl] returned AE_TIME
Aug 19 08:22:55 eric kernel:     ACPI-1121: *** Error: Method execution
failed [\_TZ_.THM0._TMP] (Node c1c1dfa0), AE_TIME

I would appreciate any patches that I can test.

Eric.



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
