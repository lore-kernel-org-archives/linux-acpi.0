From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 7/8] ACPI, APEI, CPER: Cleanup CPER memory error output
 format
Date: Tue, 15 Oct 2013 14:29:58 +0200
Message-ID: <20131015122958.GD7908@pd.tnic>
References: <1381473166-29303-1-git-send-email-gong.chen@linux.intel.com>
 <1381473166-29303-8-git-send-email-gong.chen@linux.intel.com>
 <20131011160208.GL5925@pd.tnic>
 <20131014045500.GC12189@gchen.bj.intel.com>
 <20131014103616.GE4009@pd.tnic>
 <CA+8MBbJ9P1GVf3SCh7LMY_LH+pxQg3GWkxKMzni1b1Wyx1o8NQ@mail.gmail.com>
 <525D2A07.6080201@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:43728 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932270Ab3JOMaL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Oct 2013 08:30:11 -0400
Content-Disposition: inline
In-Reply-To: <525D2A07.6080201@linux.vnet.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Tony Luck <tony.luck@gmail.com>, Chen Gong <gong.chen@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Lance Ortiz <lance.ortiz@hp.com>

On Tue, Oct 15, 2013 at 05:11:59PM +0530, Naveen N. Rao wrote:
> If so, how will disabling dmesg output and switching to a trace event
> help? The user-space program will still break unless they add support
> for that trace event, right?

Well, as yourself this: what happens to a userspace program which relies
on this *exact* error message format and greps dmesg?

> I'm not sure if we actually provide guarantees w.r.t kernel log
> messages. The issue in this specific scenario is the sheer verbosity
> of the log messages.

No, the issue is what I said above: userspace programs expecting exactly
this output. Once we exposed it to userspace, we cannot simply assume
that nothing is using it.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
