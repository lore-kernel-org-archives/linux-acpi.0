From: Nirmal Govind <nirmalg-8DAjSxpRXgY@public.gmane.org>
Subject: Re: acpi and 2.6.0 kernel - S3 doesn't resume, S4 =infinite
 loop
Date: Tue, 23 Dec 2003 09:12:34 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FE84D52.8060809@psu.edu>
References: <3ACA40606221794F80A5670F0AF15F8401720C4F@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720C4F-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Mads Paulin <paulin-/w0Os/Ss2Sh/SzgSGea1oA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> What could cause S3 resume failure?  My  T21 works well with S3, S1.
> Could you please narrow down the issue ! 
> --Luming

After several google searches and reading up on posts by others abt
similar problems with ACPI,  I was leaning towards the theory that it's
got something to do with the Intel 855 graphics adapter on both my
Fujitsu and Mads's ASUS. I read on another post that the graphics
card had issues with ACPI (that one wasn't Intel 855)..

But after looking at the syslog, this doesn't seem to be the 
problem: there was a message that said it was
looking for "Module char-major-10-134" (the APM module) when it 
resumed -- I put in an
alias to set this to off and that error went away. I also removed
all the modules before I suspended and that reduced the number of
errors I get when it resumes. But these are the remaining messages
from syslog:

Dec 23 02:22:13 variance kernel: Back to C!
Dec 23 02:22:13 variance kernel: acpi_processor_perf-0318 [37]
acpi_processor_set_per: Transition failed
Dec 23 02:22:13 variance kernel: cpufreq: resume failed in
->setpolicy/target step on CPU 0
Dec 23 02:22:13 variance kernel: PM: Finishing up.
Dec 23 02:22:13 variance kernel: PCI: Setting latency timer of
device 0000:00:1d.0 to 64
Dec 23 02:22:13 variance kernel: PCI: Setting latency timer of
device 0000:00:1d.1 to 64
Dec 23 02:22:13 variance kernel: PCI: Setting latency timer of
device 0000:00:1d.2 to 64
Dec 23 02:22:13 variance kernel: MCE: The hardware reports a non
fatal, correctable incident occurred on CPU 0.
Dec 23 02:22:13 variance kernel: Bank 1: e2000000000001d5
Dec 23 02:22:13 variance kernel: hda: Wakeup request inited, waiting
for !BSY...
Dec 23 02:22:13 variance kernel: hda: start_power_step(step: 1000)
Dec 23 02:22:13 variance kernel: blk: queue cf4fe000, I/O limit
4095Mb (mask 0xffffffff)
Dec 23 02:22:13 variance kernel: hda: completing PM request, resume
Dec 23 02:22:13 variance kernel: hdc: Wakeup request inited, waiting
for !BSY...
Dec 23 02:22:13 variance kernel: hdc: start_power_step(step: 1000)
Dec 23 02:22:13 variance kernel: hdc: completing PM request, resume
Dec 23 02:22:13 variance kernel: Restarting tasks... done
Dec 23 02:22:13 variance kernel: drivers/usb/host/uhci-hcd.c: 1820:
host system error, PCI problems?
Dec 23 02:22:13 variance kernel: drivers/usb/host/uhci-hcd.c: 1820:
host controller halted. very bad
Dec 23 02:22:13 variance kernel: drivers/usb/host/uhci-hcd.c: 1840:
host system error, PCI problems?
Dec 23 02:22:13 variance kernel: drivers/usb/host/uhci-hcd.c: 1840:
host controller halted. very bad
Dec 23 02:22:13 variance kernel: drivers/usb/host/uhci-hcd.c: 1860:
host system error, PCI problems?
Dec 23 02:22:13 variance kernel: drivers/usb/host/uhci-hcd.c: 1860:
host controller halted. very bad

So looks like there's some problem with the uhci-hcd controller? I 
googled and it's a recognized bug:

http://bugzilla.kernel.org/show_bug.cgi?id=1373

The workaround suggested is to rmmod the uhci-hcd module .. I have 
it built into the kernel so maybe I need to recompile this as a 
module... However, the others have been able to resume, just that 
the USB devices don't work.. mine doesn't resume at all.. could this 
have to do with the following error above:

cpufreq: resume failed in ->setpolicy/target step on CPU 0

Should I uncheck the CONFIG_X86_ACPI_CPUFREQ=y option in the kernel 
config?

Btw, the thermal_zone directory in /proc/acpi is empty.. I did 
enable it in
the kernel configure .. the same goes for fan/ - it's also empty. Do
these work for you?

nirmal




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
