From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Network failures with ACPI enabled (kernel 2.4, 2.6)
Date: 30 Dec 2003 12:48:02 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1072806481.2364.201.camel@dhcppc4>
References: <20031230010822.155c1466.mike@it-loops.com>
	 <20031230165749.34ed607d.mike@it-loops.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031230165749.34ed607d.mike-Z92qn3yYq0hWk0Htik3J/w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Michael Guntsche <mike-Z92qn3yYq0hWk0Htik3J/w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2003-12-30 at 10:57, Michael Guntsche wrote:
> On Tue, 30 Dec 2003 01:08:22 +0100
> Michael Guntsche <mike-Z92qn3yYq0hWk0Htik3J/w@public.gmane.org> wrote:
> 
> > But then I tried to copy an CD-Image file from our fileserver to my
> > notebook. As soon as the transfer started, the following error messages
> > appeared
> > in my syslog and the transfer stalled. 
> > 
> > 	b44: eth0: Link is down.
> > 	b44: eth0: Link is up at 100 Mbps, full duplex.
> > 	b44: eth0: Flow control is on for TX and on for RX.
> > 	<repeating>
> > 	.........
> 
> Today I tried the same transfer with a XIRCOM PCMCIA network card and ACPI enabled.
> It worked without a problem.
> I am not sure what this means for ACPI <-> B44 though. ;)

Please note which IRQ each kind of ethernet NIC gets,
and if it shares an IRQ with any other device.
If the working and non-working NICs come up on different IRQs
then that may be a clue.

But the fact that B44 works with acpi=off and fails with pci=noacpi
suggests that IRQ assignment isn't the problem.

Looking at the actual ACPI interrupt:

  0:     738650          XT-PIC  timer
  9:       3546          XT-PIC  acpi

Not an interrupt storm, but you're getting a measurable number of acpi
events.


echo 0x4 > /proc/acpi/debug_layer
echo 0x08000000 > /proc/acpi/debug_level

may tell us what they are -- though it is unclear why they might
interfere with the B44 device and not others.

>Local APIC disabled by BIOS -- reenabling.
> Found and enabled local APIC!

This can be risky -- please verify that "nolapic" has no effect.

thanks,
-Len




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
