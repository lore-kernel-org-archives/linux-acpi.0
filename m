From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Power button doesn't give events (Asus TUSL2-C)
Date: Fri, 10 Jan 2003 10:32:59 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A847137F5B@orsmsx401.jf.intel.com>
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
To: Jurgen Kramer <gtm.kramer-c1aixF9oqgPk1uMJSBkQmQ@public.gmane.org>, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> From: Jurgen Kramer [mailto:gtm.kramer-c1aixF9oqgPk1uMJSBkQmQ@public.gmane.org] 
> I am running the recent versions of ACPI on all my Linux systems and
> all but one behave. On my primary desktop, running ACPI version
> 20021212, pressing the power button doesn't result in an proper
> power/button event. Nothing happens at all. It does work under W*XP.
> 
> What can be the problem here? I you need more info I am happy 
> to supply.
> 
> According to dmesg output my system, a Asus TUSL2-C, does pass the
> blacklist test.

Does the output from /proc/interrupts list ACPI anywhere?

Does the interrupt count increase by 1 every time you press a power
button?

What does your dmesg say about discovered buttons?

Regards -- Andy


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
