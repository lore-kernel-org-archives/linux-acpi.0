From: =?ISO-8859-15?Q?Peter_M=FCnster?= <pmlists-GANU6spQydw@public.gmane.org>
Subject: RE: system does not wake up sometimes
Date: Tue, 1 Feb 2005 21:04:38 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0502012022280.24529@gaston.free.fr>
References: <16A54BF5D6E14E4D916CE26C9AD3057501168084@pdsmsx402.ccr.corp.intel.com>
  <Pine.LNX.4.58.0501312317420.31879@gaston.free.fr>
 <1107218653.26227.3.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <1107218653.26227.3.camel-U5EdaLXB8smDugQYiPIPGdh3ngVCH38I@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 1 Feb 2005, Li Shaohua wrote:

> > No, I didn't find any rule. Sometimes the system really wakes up the right
> > time (Jan 22 11:10:00 gaston kernel: Back to C!), but very often it does
> > not. And this is not so good, because some cron-jobs don't get started at
> > the right time...
> Just try to set an alarm in system run time (doesn't do suspend/resume)
> and see if ACPI interrupt increased (see /proc/interrupts). Please try
> several times and report back. How about S3?

Now I've played around a little bit with /proc/acpi/alarm and I discover,
that it works exactly one time after reboot, and then never again.

Here is the kernel message when interrupt arrives:
ACPI-0286: *** Error: No installed handler for fixed event [00000004]

Here is the kernel message when interrupt arrives and system was sleeping:
Stopping tasks: ================================================|
Back to C!
APIC error on CPU0: 00(08)
    ACPI-0286: *** Error: No installed handler for fixed event [00000004]
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: USB 2.0 restarted, EHCI 1.00, driver 26 Oct 2004
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 19 (level, high) -> IRQ 19
Restarting tasks... done
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V3 device at 0000:02:00.0 into 4x mode
[drm] Loading R200 Microcode

And here the kernel message when I have to wake up the system by moving the
mouse:
Stopping tasks: =======================================================|
Back to C!
APIC error on CPU0: 00(08)
ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 22 (level, high) -> IRQ 22
PCI: Setting latency timer of device 0000:00:06.0 to 64
ACPI: PCI interrupt 0000:01:09.0[A] -> GSI 17 (level, high) -> IRQ 17
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 19 (level, high) -> IRQ 19
Restarting tasks... done

Concerning S3: it seems, that it does not work with X-Windows.

Cheers, Peter

-- 
http://pmrb.free.fr/contact/


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
