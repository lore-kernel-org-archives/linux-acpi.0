From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: Re: Linux 2.6-pre1 Does not boot on ASUS L3800C: lock up in acpi while  "Executing all Devices _STA and_INIT methods"
Date: Tue, 15 Jul 2003 23:20:54 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030715212054.GA10046@hell.org.pl>
References: <F760B14C9561B941B89469F59BA3A847E9702C@orsmsx401.jf.intel.com> <3F146770.8020603@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3F146770.8020603-GANU6spQydw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Eric Valette <eric.valette-GANU6spQydw@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote Eric Valette:
> >That's weird. They should have the same version of the ACPI code...
> Thanks for responding. Note I have never seen such messages on 2.4 so...
> 
> FYI : I tested today with the latest version 0714 and it doesn't change 
>  anything... 2.4.22-pre6 + the patch works fine... Someone suggested 
> problem with the APIC but its enabled in 2.4...

That's how it works for me on the same machine: if APIC and IO-APIC is
compiled in, the kernel hangs at the place you mentioned. noapic doesn't
help, acpi=off does, as well as not compiling APIC in at all.

According to my experience, APIC should not work under 2.4.x and 2.5.x 
where x < 74, since it is magically disabled by BIOS and the kernel doesn't
know anything about it. Do you have any evidence that APIC works at all 
on these kernels?

Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
