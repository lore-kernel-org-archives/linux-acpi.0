From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: Concurrency in the execution of ACPI control methods
Date: Tue, 7 Mar 2006 12:47:49 -0800
Message-ID: <971FCB6690CD0E4898387DBF7552B90E04970A19@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr18.intel.com ([134.134.136.17]:12495 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751481AbWCGUsC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Mar 2006 15:48:02 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Wainwright <prw@ceiriog.eclipse.co.uk>, linux-acpi@vger.kernel.org


Looking at method _L19, the Sleep() operator should relinquish the
processor and allow the Notify dispatch to occur.

AcpiOsQueueForExecution should be using a different thread than the
thread that executes the AML interpreter. The Notify dispatcher does not
enter the AML interpreter mutex, so there should not be a deadlock. The
actual handler for the Notify should be in a driver somewhere.

I have found that the best method to determine exactly what is going on
is to enable full debug tracing in the ACPICA subsystem (via
acpi_dbg_level) and analyze the sequence of events.

Perhaps the ACPICA reference uses a bad choice of words. The code
supports the concurrency model defined in the ACPICA spec.

Bob



> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Peter Wainwright
> Sent: Tuesday, March 07, 2006 12:23 PM
> To: linux-acpi@vger.kernel.org
> Subject: Concurrency in the execution of ACPI control methods
> 
> Hello,
> 
> this is my first posting to this list. I recently purchased a HP
nx6125
> laptop. This
> laptop is known to suffer from a number of bugs when used with linux;
> these have
> been reported on Suse, Gentoo and Debian lists as well as on kernel
> bugzilla.
> The kernel bug is http://bugzilla.kernel.org/show_bug.cgi?id=5534.
> 
> I posted my own analysis of this bug on bugzilla, but there has been
no
> reply
> so far. I am posting here because I think it may raise an issue which
is
> wider than
> the scope of that bug, which seemingly affects only nx6125 owners. I
> think the ACPI
> spec is unclear on certain points so that the linux implementation may
> not be adequate
> for some machines.
> 
> <gory_technical_details>
> 
> In brief, the bug is that thermal Notify events are never processed
> until
> someone explicitly reads the temperature
> (e.g. /proc/acpi/thermal_zone/TZ1/temperature).
> According to my analysis, thermal events on the nx6125 are handled by
a
> control method
> (_L19) which issues a Notify event to the OS and then Sleeps and loops
> waiting for the
> OS to reset the trip points and clear the exception condition.
> 
> It seems to me that this causes a deadlock, because the GPE events and
> the Notify
> events are queued in a single-threaded workqueue and the Notify events
> cannot be
> processed until after _L19 returns.
> 
> </gory_technical_details>
> 
> This is described in
http://bugzilla.kernel.org/show_bug.cgi?id=5534#c65
> and
> http://bugzilla.kernel.org/show_bug.cgi?id=5534#c66.
> 
> My question is this: If this analysis is true, it means that the HP
BIOS
> is
> expecting some type of concurrent execution of ACPI control methods.
> This seems to
> go against (one interpretation of) the ACPI spec. However, the ACPI
spec
> is not
> entirely clear on the issue. The ACPI CA Reference Manual by Intel
(one
> of the
> authors of the ACPI spec) says "If a control method blocks (an event
> that can occur
> only under a few limited conditions), another method may begin
> execution. However, ???it can be said that the specification precludes
> the concurrent execution of control methods???. Therefore, the AML
> interpreter itself is essentially a single-threaded component of the
> ACPI subsystem". This looks like equivocation to me - surely it's
either
> single-threaded or not! "essentially" - "it can be said" - what are
they
> saying
> here? Anyway, it seems to me that to successfully interpret this DSDT
> (http://acpi.sourceforge.net/dsdt/view.php?id=558) it would be
necessary
> to use
> multiple threads in kacpid. Are there any other machines which do this
> kind
> of clever stuff? What is the correct interpretation of the ACPI spec
here?
> 
> 
> 
> Peter Wainwright
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
