From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Wrong button event reported when waking up from S1
Date: Mon, 7 Apr 2003 11:40:48 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A84725A24F@orsmsx401.jf.intel.com>
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
To: stef <stef-listes-39ZsbGIQGT5GWvitb5QawA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: stef [mailto:stef-listes-39ZsbGIQGT5GWvitb5QawA@public.gmane.org] 
>         I have a problem with 2.4.21pre6+acpi 20030328, when 
> I do 'echo -n 1 >/proc/acpi/sleep' and wake my laptop with 
> the sleep button, acpi gives a power button (PWRF) event 
> instead of a sleep button event (SBTN).
> 
> cat /proc/acpi/event
> button/power PWRF 00000080 00000007
> button/power PWRF 00000080 00000008
> button/power PWRF 00000080 00000009
> button/power PWRF 00000080 0000000a
> button/power PWRF 00000080 0000000b
> button/power PWRF 00000080 0000000c
> button/power PWRF 00000080 0000000d
> button/power PWRF 00000080 0000000e
> button/power PWRF 00000080 0000000f
> button/power PWRF 00000080 00000010
> button/power PWRF 00000080 00000011
> button/power PWRF 00000080 00000012
> button/sleep SBTN 00000080 0000001a <- last button pressed before 
> entering S1
> button/power PWRF 00000080 00000013 <- event reported

Hmm the button event count makes me think this is somehow a left-over
event from before we entered S1. Thoughts?

Regards -- Andy


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
