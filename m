From: Volker Schlecht <vschlecht-hi6Y0CQ0nG0@public.gmane.org>
Subject: Follow-Up: ACPI hangs while booting Linux 2.6.0-test4
Date: Mon, 25 Aug 2003 18:22:56 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030825162256.GA1147@loki.dragonslair>
References: <20030824121223.GB1167@loki.dragonslair>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030824121223.GB1167-MgmzcJy9OuAUkGTFvXBGug@public.gmane.org>
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

* Volker Schlecht  [030824 14:12]:
 
> I can't boot Linux 2.6.0-test4 with ACPI enabled on my Hewlett Packard
> ze4360ea notebook. This worked flawlessly with *-test1 through
> *-test3. 
> The boot process hangs at the point where it says 
> "ACPI Subsystem revision 20030813" 

Ok, the hang goes away with unsetting CONFIG_X86_UP_APIC. The Kernel
boots now. (May I suggest the removal of the "Kernel will run anyway" remark?)

Additionally there seem to be situations in which the battery charging
state appears to be unknown. 

cat /proc/acpi/battery/BAT1/state:

present:                 yes
capacity state:          ok
charging state:          unknown
present rate:            0 mA
remaining capacity:      4064 mAh
present voltage:         16704 mV

That can be changed by changing the state (i.e. pulling the plug),
though.

It also seems to break various desktop battery monitors (gkrellm2 and
the Gnome battery monitor applet), but I could not yet find out why.

ciao,
Volker

-- 
I'm always looking for a new idea that will be more productive than its cost.
		-- David Rockefeller


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
