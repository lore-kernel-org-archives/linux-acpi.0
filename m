From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 25/70] ACPICA: Update disassembler for DMAR table changes
Date: Fri, 20 Jun 2008 21:50:43 +0200
Message-ID: <87d4mbansc.fsf@basil.nowhere.org>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
	<ee61cb033678eaf16901813eb6394dafa51e9c85.1213947350.git.len.brown@intel.com>
	<20080620115201.GB8637@srcf.ucam.org>
	<alpine.LFD.1.10.0806201438130.3027@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out03.alice-dsl.net ([88.44.63.5]:3199 "EHLO
	smtp-out03.alice-dsl.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709AbYFTUBq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 16:01:46 -0400
In-Reply-To: <alpine.LFD.1.10.0806201438130.3027@localhost.localdomain> (Len Brown's message of "Fri, 20 Jun 2008 14:41:41 -0400 (EDT)")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, luming.yu@intel.com

Len Brown <lenb@kernel.org> writes:
>
> But there is actually quite a bit in ACPICA that is not in Linux.
> The most useful, from a debugging point of view, might be the
> hooking the ACPICA debug code into the kernel debugger --
> something that Luming did about 2 years ago.  However, as the
> debugger was not part of the Linux kernel tree, the changes
> didn't really have a good path to a customer...

kgdb supports remote function calls, so if you just make a callable
interface and perhaps supply a standard macro file users could call
it.

-Andi
