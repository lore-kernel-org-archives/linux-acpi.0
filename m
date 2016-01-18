From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4] acpi, apei: add Boot Error Record Table (BERT) support
Date: Mon, 18 Jan 2016 17:08:16 +0100
Message-ID: <20160118160816.GG12644@pd.tnic>
References: <1452260742-13625-1-git-send-email-fu.wei@linaro.org>
 <20160116191604.GE31869@pd.tnic>
 <569CFFD0.5050102@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:50764 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755455AbcARQIm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 18 Jan 2016 11:08:42 -0500
Content-Disposition: inline
In-Reply-To: <569CFFD0.5050102@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Abdulhamid, Harb" <harba@codeaurora.org>
Cc: fu.wei@linaro.org, tony.luck@intel.com, gong.chen@intel.com, ying.huang@intel.com, tomasz.nowicki@linaro.org, tn@semihalf.com, tbaicar@codeaurora.org, rruigrok@codeaurora.org, harba@qti.qualcomm.com, graeme.gregory@linaro.org, al.stone@linaro.org, hanjun.guo@linaro.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, jcm@redhat.com, mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net, "Chen, Gong" <gong.chen@linux.intel.com>

On Mon, Jan 18, 2016 at 10:08:00AM -0500, Abdulhamid, Harb wrote:
> This is okay, except the part about "the kernel cannot allow itself to do
> any
> error recovery due to risk of data corruption, the machine resets."
> 
> Errors detected by the kernel should not result in a BERT record on the next
> boot,
> only in cases where for some reason the kernel does not respond or
> there
> is a firmware/hardware decision to immediately reset (e.g.power/thermal
> faults,
> watchdog, etc.).

Ok, I see where my proposed text can be misunderstood.

> If a kernel consumes a fatal error record at run-time (e.g. via MCE or APEI
> mechanism), in that case the kernel will panic and attempt to gracefully
> restart the system.

That depends on the system.

> Since the error record was successfully consumed, firmware does not
> need to generate a BERT for the next boot, as it assumes the kernel
> has already logged it and is aware of the reboot reason.

I think this depends on the hardware+firmware implementation and which
part decides to reset the system without even running the error handler.

> In short, my understanding is that BERT should only be generated when
> the reboot was triggered by firmware/hardware.

Right.

> Here is my crack at massaging the language a bit more:
> "Under normal circumstances, when a hardware error occurs, the kernel
> gets notified via an NMI, MCE or some other method. When the error has
> a fatal severity or is unrecoverable, the kernel would normally panic.

So this is still not exact. It all depends on what the hardware does.
Even more importantly, does the hardware even run the error handler and
let it access MCA banks to find about the error or does it directly
warm-reset the system.

The error can happen, it is critical, *nothing* might be visible in the
MCA registers (this is x86-specific) and the machine would reset. Only
when you warm-reset, you may or may not see anything in there.

In reading the BERT explanation in the ACPI spec, I have to say, it
sounds pretty ok to me:

"18.3.1 Boot Error Source

Under normal circumstances, when a hardware error occurs, the error
handler receives control and processes the error. This gives OSPM a
chance to process the error condition, report it, and optionally attempt
recovery. In some cases, the system is unable to process an error.
For example, system firmware or a management controller may choose to
reset the system or the system might experience an uncontrolled crash
or reset.The boot error source is used to report unhandled errors that
occurred in a previous boot. This mechanism is described in the BERT
table."

I think we should take that text. :)

> I would hope that firmware vendors care about their BERT being
> broken, otherwise how can they explain why their
> firmware/hardware is suddenly rebooting without having a BERT
> record to explain the cause?

One would hope :-\

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
