From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 7/8] ACPI, APEI, CPER: Cleanup CPER memory error output
 format
Date: Mon, 14 Oct 2013 20:47:17 +0200
Message-ID: <20131014184717.GK4009@pd.tnic>
References: <1381473166-29303-1-git-send-email-gong.chen@linux.intel.com>
 <1381473166-29303-8-git-send-email-gong.chen@linux.intel.com>
 <20131011160208.GL5925@pd.tnic>
 <20131014045500.GC12189@gchen.bj.intel.com>
 <20131014103616.GE4009@pd.tnic>
 <CA+8MBbJ9P1GVf3SCh7LMY_LH+pxQg3GWkxKMzni1b1Wyx1o8NQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:36279 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756766Ab3JNSr3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Oct 2013 14:47:29 -0400
Content-Disposition: inline
In-Reply-To: <CA+8MBbJ9P1GVf3SCh7LMY_LH+pxQg3GWkxKMzni1b1Wyx1o8NQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tony Luck <tony.luck@gmail.com>
Cc: Chen Gong <gong.chen@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Lance Ortiz <lance.ortiz@hp.com>, "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>

On Mon, Oct 14, 2013 at 10:12:35AM -0700, Tony Luck wrote:
> This is an excellent idea - if the full data is being logged via
> TRACE, then we can drop to virtually nothing on the console (just have
> something similar to the "Machine check events logged" message so that
> people will get a tip that they might want to go dig into other logs).
> Maybe something like: %d corrected memory errors\n", count [rate
> limited]
>
> But we'd have to make sure that the existing user(s) of this code also
> have a TRACE path.

It is basically the same idea as with the ras daemon - if we have a
userspace consumer of ras trace events, we disable dmesg output. So the
decision will be left to the userspace tool to disable dmesg output as a
last step of its initialization.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
