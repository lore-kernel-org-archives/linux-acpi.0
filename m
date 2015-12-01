From: Blibbet <blibbet@gmail.com>
Subject: Re: [PATCH] acpi: Better describe ACPI_DEBUGGER
Date: Tue, 1 Dec 2015 13:45:50 -0800
Message-ID: <565E150E.5010401@gmail.com>
References: <20151130213215.GC3816@twins.programming.kicks-ass.net>
 <1645670.Yj5okVLt1U@vostro.rjw.lan>
 <20151130223908.GH3816@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36071 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756358AbbLAVpx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Dec 2015 16:45:53 -0500
Received: by pacdm15 with SMTP id dm15so17493825pac.3
        for <linux-acpi@vger.kernel.org>; Tue, 01 Dec 2015 13:45:52 -0800 (PST)
In-Reply-To: <20151130223908.GH3816@twins.programming.kicks-ass.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, acpi@linux.intel.com

On 11/30/2015 02:39 PM, Peter Zijlstra wrote:
> On Mon, Nov 30, 2015 at 11:43:26PM +0100, Rafael J. Wysocki wrote:
>> On Monday, November 30, 2015 10:32:15 PM Peter Zijlstra wrote:
[...]
> n/p, for a brief moment I thought about things like a GDB stub running
> in SMM -- which would be entirely awesome if it had dedicated IO through
> a BMC or simple serial.
>
> Then I thought about all the kvm-gdb-stub fail I've encountered over the
> years and figured this would never work, seeing how BIOSes are never
> updated/fixed.

FYI, at Usenix WOOT'15, Intel talked about using a GDB stub to test SMM,
along with S2E, KLEE, OpenOCD, and Minnow. I *think* Intel is going to
be open-sourcing the resulting test project next quarter. Unclear if
this will impact ACPI.

https://www.usenix.org/conference/woot15/workshop-program/presentation/bazhaniuk

"Symbolic Execution for BIOS Security: We are building a tool that uses
symbolic execution to search for BIOS security vulnerabilities including
dangerous memory references (call outs) by SMM interrupt handlers in
UEFI-compliant implementations of BIOS. Our tool currently applies only
to interrupt handlers for SMM variables. Given a snapshot of SMRAM, the
base address of SMRAM, and the address of the variable interrupt handler
in SMRAM, the tool uses S2E to run the KLEE symbolic execution engine to
search for concrete examples of a call to the interrupt handler that
causes the handler to read memory outside of SMRAM. This is a work in
progress. We discuss our approach, our current status, our plans for the
tool, and the obstacles we face."

Thanks,
Lee
RSS: http://firmwaresecurity.com/feed
