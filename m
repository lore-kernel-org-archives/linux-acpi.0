From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 17802] New: touchpad become crazy: disable irq
 21
Date: Wed, 8 Sep 2010 15:32:01 -0700
Message-ID: <20100908153201.91dc03d2.akpm@linux-foundation.org>
References: <bug-17802-10286@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43422 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756267Ab0IHWct (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Sep 2010 18:32:49 -0400
In-Reply-To: <bug-17802-10286@https.bugzilla.kernel.org/>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, x86@kernel.org, Dmitry Torokhov <dtor@mail.ru>
Cc: bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org, polhallen@fuckaround.org


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Sun, 5 Sep 2010 11:47:41 GMT
bugzilla-daemon@bugzilla.kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=17802
> 
>            Summary: touchpad become crazy: disable irq 21
>            Product: Other
>            Version: 2.5
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: high
>           Priority: P1
>          Component: Other
>         AssignedTo: other_other@kernel-bugs.osdl.org
>         ReportedBy: polhallen@fuckaround.org

heh.

>         Regression: No
> 
> 
> Hi
> on macbook 4.1 (kernel 2.6.31.12) often the touchpad become crazy and irq 21 is
> disable, in syslog I see:
> 
> Sep  5 13:32:05 pollon kernel: [ 2215.099257] ide-atapi: hda:
> ide_check_ireason: wrong transfer direction!
> Sep  5 13:32:05 pollon kernel: [ 2215.150195] ide-atapi: hda:
> ide_check_ireason: wrong transfer direction!
> Sep  5 13:32:23 pollon kernel: [ 2233.081273] hda: request sense failure:
> status=0xd0 { Busy }
> Sep  5 13:32:23 pollon kernel: [ 2233.081285] hda: possibly failed opcode: 0xa0
> Sep  5 13:32:37 pollon kernel: [ 2247.317239] irq 21: nobody cared (try booting
> with the "irqpoll" option)
> Sep  5 13:32:37 pollon kernel: [ 2247.317244] Pid: 0, comm: swapper Tainted: P 
>          2.6.31.12-pollon #2
> Sep  5 13:32:37 pollon kernel: [ 2247.317246] Call Trace:
> Sep  5 13:32:37 pollon kernel: [ 2247.317253]  [<c0169b7f>] ?
> __report_bad_irq+0x24/0x69
> Sep  5 13:32:37 pollon kernel: [ 2247.317256]  [<c0169b86>] ?
> __report_bad_irq+0x2b/0x69
> Sep  5 13:32:37 pollon kernel: [ 2247.317259]  [<c0169cb1>] ?
> note_interrupt+0xed/0x13c
> Sep  5 13:32:37 pollon kernel: [ 2247.317262]  [<c016a196>] ?
> handle_fasteoi_irq+0x7a/0x97
> Sep  5 13:32:37 pollon kernel: [ 2247.317265]  [<c01098d4>] ?
> handle_irq+0x17/0x1b
> Sep  5 13:32:37 pollon kernel: [ 2247.317268]  [<c0109110>] ? do_IRQ+0x38/0x89
> Sep  5 13:32:37 pollon kernel: [ 2247.317270]  [<c0107c69>] ?
> common_interrupt+0x29/0x30
> Sep  5 13:32:37 pollon kernel: [ 2247.317289]  [<f845623a>] ?
> acpi_idle_enter_simple+0xf7/0x129 [processor]
> Sep  5 13:32:37 pollon kernel: [ 2247.317293]  [<c02f79d6>] ?
> cpuidle_idle_call+0x64/0x96
> Sep  5 13:32:37 pollon kernel: [ 2247.317297]  [<c01068a3>] ?
> cpu_idle+0x46/0x5f
> Sep  5 13:32:37 pollon kernel: [ 2247.317298] handlers:
> Sep  5 13:32:37 pollon kernel: [ 2247.317300] [<f809c147>]
> (usb_hcd_irq+0x0/0x66 [usbcore])
> Sep  5 13:32:37 pollon kernel: [ 2247.317323] [<f80dbbbe>] (ide_intr+0x0/0x1b9
> [ide_core])
> Sep  5 13:32:37 pollon kernel: [ 2247.317343] [<f80dbbbe>] (ide_intr+0x0/0x1b9
> [ide_core])
> Sep  5 13:32:37 pollon kernel: [ 2247.317361] [<f809c147>]
> (usb_hcd_irq+0x0/0x66 [usbcore])
> Sep  5 13:32:37 pollon kernel: [ 2247.317382] Disabling IRQ #21
> 
> also suspend stops and I can only reboot the system.
> 
> If I add irqpoll there is not this problem but suspend doesn't run.
> 

Not heh.  Ugly.

Could be ACPI, could be x86, could be something else.

Guys, could you please take a look, suggest how we should tackle this?

Thanks.

