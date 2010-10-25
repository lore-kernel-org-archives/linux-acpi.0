From: Tony Luck <tony.luck@gmail.com>
Subject: Re: [NAK] Re: [PATCH -v2 9/9] ACPI, APEI, Generic Hardware Error
 Source POLL/IRQ/NMI notification type support
Date: Mon, 25 Oct 2010 14:23:12 -0700
Message-ID: <AANLkTi=DEmss+3uX_5uw=VJDY9+cFPayjQkCQHa+r+Ye@mail.gmail.com>
References: <1287992610-14996-1-git-send-email-ying.huang@intel.com>
	<1287992610-14996-10-git-send-email-ying.huang@intel.com>
	<20101025084553.GA27119@elte.hu>
	<1287997112.2862.322.camel@yhuang-dev>
	<20101025092557.GA11544@elte.hu>
	<AANLkTi=2SVT1M+nDZUB7EB05jh+tsuKcew_t66QORrwb@mail.gmail.com>
	<20101025202344.GC13652@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:44948 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487Ab0JYVXO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Oct 2010 17:23:14 -0400
In-Reply-To: <20101025202344.GC13652@liondog.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@gmail.com>, Ingo Molnar <mingo@elte.hu>, Huang Ying <ying.huang@intel.com>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel

On Mon, Oct 25, 2010 at 1:23 PM, Borislav Petkov <bp@alien8.de> wrote:

> You may be right but what we actually want is a consistent RAS
> infrastructure. Didn't you point out at the last edac meeting in Boston
> that concerning RAS Linux were in the stone ages? (at least this is what
> I remember reading).

That meeting was in San Francisco - but your recollection is correct.
Right now we have ways to count errors, and to attribute them to
specific hardware components (if we are lucky). This is only the
beginning of the feature set that is needed to be "advanced RAS".

> What we should do is put all that post-system-reset error info, ECC
> errors mapping to DRAM devices, L3 cache index manipulation based on
> excessive errors - you name it - together and stick it in ras/ or
> drivers/ras or whatever. And all with a nice and easy to use userspace
> tool on top.

This is what we should be working towards.  I don't think we have
a clear picture of what that high level infrastructure looks like. It
needs to be very flexible to take input from all sorts of platform
specific "driver" code that collects data.  The "perf events"
mechanism looks plausible as a transport mechanism for
reporting corrected (or otherwise non-fatal) events. But the
errors that didn't kill the system are only part of the RAS picture.

> Now it looks like a wart on arch/x86/ which truly doesn't belong there.
> And I don't buy all that crap that it can't be done right.

Of course it is a wart ... look up ACPI in any dictionary and you'll
find a picture of a stereotypical Halloween witch :-) I don't see other
architectures lining up to support ACPI ... but we shouldn't just
ignore it in x86.  The APEI pieces that were added to ACPI 4.0
have some interesting and useful features.  Most of them are
already implemented on shipping platforms because the APEI
bits were simply documenting WHEA (Windows Hardware Error
Architecture) features.  Look for this stuff in dmesg:

ACPI: HEST 000000007fb1c000 000A8 (v01 INTEL    SFC4UR 00000001 INTL 00000001)
ACPI: BERT 000000007fb1b000 00030 (v01 INTEL    SFC4UR 00000001 INTL 00000001)
ACPI: ERST 000000007fb1a000 00230 (v01 INTEL    SFC4UR 00000001 INTL 00000001)
ACPI: EINJ 000000007fb19000 00130 (v01 INTEL    SFC4UR 00000001 INTL 00000001)

-Tony
