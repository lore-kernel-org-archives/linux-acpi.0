From: Emma Jane Hogbin <emmajane-MHIYrZpDPrNWk0Htik3J/w@public.gmane.org>
Subject: APIC options 2.4.21 kernel + patch
Date: Tue, 1 Jul 2003 01:20:06 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030701052006.GB2242@xtrinsic.com>
Reply-To: Emma Jane Hogbin <emmajane-MHIYrZpDPrNWk0Htik3J/w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

Hi:

I'm currently working on an ACPI HOWTO. It was written for the 2.4.20
kernel, and I'm getting some questions about the 2.4.21 kernel and the
latest patch. I am hoping this is a quick question with an easy answer.
http://xtrinsic.com/geek/articles/acpi.phtml

Here is a copy of the email I received which outlines the problem behind
the question:
http://sourceforge.net/mailarchive/forum.php?thread_id=2668793&forum_id=7803

My question is this: Does the CONFIG_X86_UP_APIC module need to be set to
"Y" for the 2.4.21 kernel + latest ACPI patch to work? 

I've found the following APIC options in the 2.4.20 kernel:
	CONFIG_X86_GOOD_APIC=y
	# CONFIG_X86_UP_APIC is not set
	# CONFIG_X86_UP_IOAPIC is not set

The reader who emailed me said that he had to enable the second option in
order to get the 2.4.21 kernel + patch to work. Will this be true for all
hardware configurations 2.4.21?

thanks!!

emma

-- 
Emma Jane Hogbin
[[ 416 417 2868 ][ www.xtrinsic.com ]]


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
