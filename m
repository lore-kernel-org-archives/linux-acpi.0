From: Arndt Schoenewald <abs-SA7OhAOe25xnNxvc45mVi0K323yFvGpRdefyYXQ/eNw@public.gmane.org>
Subject: Re: ACPI hangs X-Windows with nForce chipset
Date: Fri, 3 Jan 2003 17:23:35 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030103162335.GB26301@schiggy.intern.quelltext.com>
References: <20030103084438.1697.qmail@web13402.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030103084438.1697.qmail-A7XbpDnDaW6A/QwVtaZbd3CJp6faPEW9@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: James Joseph <jannix97-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi James,

does your system work without APIC and IO-APIC support enabled in the
kernel, or with APIC support being turned off in the BIOS?

(I have a SiS650 based machine with a MS-6335E mainboard which will
only boot with either one of the above workarounds. It seems that the
support for APICs and/or IO-APICs is still not 100% bugfree.)

The "Spurious 8259A interrupt : IRQ7" messages appear on many machines,
but seem to be harmless. I don't know what causes them.

Good luck,
Arndt


On Fri, Jan 03, 2003 at 12:44:38AM -0800, James Joseph wrote:
> Hi there,
> I have a clean (from kernel.org) 2.4.20 kernel patched
> with the latest ACPI patch from sourceforge.net
> (acpi-20021212-2.4.20.diff).  I am using AMD Athlon XP
> 2000+ on Asus A7N266-VM (nForce 220-D chipset with
> latest bios update rev. 1005) and i have Local APIC
> and IO APIC enabled. 
> I am using a Mandrake 8.1 base system. Enabling ACPI
> on the default mandrake kernel,(which is 2.4.8) make
> the system unbootable, it just prints a line of hex,
> and "Attempted to kill init" message comes.
> 
> Using the 2.4.20 kernel, system boots properly, and
> the text-only mode seems stable runlevel 3).
> /proc/interrupts show IO-APIC used for all devices
> except "cascade". But when i start X, the server and
> KDE boots up, and then whole system hangs. 
> Ctrl-Alt-Backspace and Ctrl-Alt-Del don't work, but i
> can Sync-Unmount-Reboot using the Magic SysRequest
> keys (kernel debugging enabled).
> [...] 
> 2) I also get the following message on the console
> once in a while:-
> Spurious 8259A interrupt : IRQ7
> [...] 

-- 
Arndt Schönewald <abs-SA7OhAOe25xnNxvc45mVi0K323yFvGpRdefyYXQ/eNw@public.gmane.org>, Software Developer
Quelltext AG (http://www.quelltext-ag.de), Dortmund, Germany


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
