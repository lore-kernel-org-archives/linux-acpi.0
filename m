From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: thermal.o Linux ACPI Kernel Modul
Date: Wed, 15 Jan 2003 17:19:59 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A847137F73@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Fat32-S0/GAf8tV78@public.gmane.org
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Daniel [mailto:Fat32-S0/GAf8tV78@public.gmane.org] 
> Hallo Andrew,
> I have a little problem getting my cpu fan to work proppably 
> with linux.
> The ACPI module you coded creates a file in the proc fa calle 
> "trip_points".
> When I cat this file I get the following:
> cat trip_points
> critical (S5):           85 C
> passive:                 95 C: tc1=2 tc2=5 tsp=300 devices=0xc12c7680
> 
> So my fan is running the hole time (sometimes slower, 
> sometimes faster, but 
> never realy stops). btw. I have a Acer 613TXC Notebook with 
> Phoenix BIOS 
> (latest version).

You will notice that your system does not have an "active" entry. This
generally means that the fan is not under ACPI's control. So, the OS
power policy can read the temp (what does your temperature read?) and
implement passive cooling (throttle the CPU) and may shut the system
down when the temp hits 85C (wow, pretty hot) but it doesn't know about
any active cooling mechanisms.

> Could you please help me with a brief answer, or tell me 
> where I can find a  
> documentation fpr this? Where gets the thermal module it's 
> data for the 
> trip_points file from?

The thermal module gets the temperature trip points from the BIOS (the
DSDT.) The thinking is that the system manufacturer knows best about the
particular thermal characteristics of a given platform. I think we added
support to override these, if it becomes necessary, however. Look at
thermal.c.

Regards -- Andy


-------------------------------------------------------
This SF.NET email is sponsored by: A Thawte Code Signing Certificate 
is essential in establishing user confidence by providing assurance of 
authenticity and code integrity. Download our Free Code Signing guide:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0028en
