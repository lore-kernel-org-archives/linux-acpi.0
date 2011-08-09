From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v3 0/2] Forcibly enable some MISC_ENABLE features on
 Intel
Date: Tue, 9 Aug 2011 13:50:50 +0100
Message-ID: <20110809135050.79eed316@lxorguk.ukuu.org.uk>
References: <cover.1312893572.git.luto@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37398 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753377Ab1HIMsO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Aug 2011 08:48:14 -0400
In-Reply-To: <cover.1312893572.git.luto@mit.edu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Lutomirski <luto@MIT.EDU>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>

On Tue,  9 Aug 2011 08:41:04 -0400
Andy Lutomirski <luto@MIT.EDU> wrote:

> Intel allows BIOS or the OS to enable or disable some CPU fueatures via
> IA32_MISC_ENABLE.  I have machines that don't enable fast strings or
> monitor/mwait in BIOS, so do it on bootup instead.

The question is - why. 

> The Intel SDM volume 3, appendix B.1 says that the OS should not touch
> the monitor enable bit if SSE3 is not present, which presumably means
> that the OS may touch that bit if SSE3 is present.  In any case, these
> patches seem to work.

That's a big "presumes"

For example back in Pentium days the BIOS sometimes turned off a string
fast path because it was subtly not reliable on certain parts and could
corrupt.

It's possible your BIOS vendor has a good reason for doing this. It's
also possible its a bug, or a left over perhaps from some pre-release
processor or something.

I think a bit more research is probably appropriate before processor
configuration hacks go in that 'seem to work'.

Alan
