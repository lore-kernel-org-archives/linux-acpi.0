From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: [PATCH] acpi: Avoid dropping rapid hotkey events (or other GPEs)
 on Asus EeePC
Date: Thu, 17 Jul 2008 17:02:54 +0100
Message-ID: <487F6D2E.2040501@tuffmail.co.uk>
References: <487D23C3.5070301@student.cs.york.ac.uk> <487F58B6.5040309@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:3434 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760620AbYGQQCj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jul 2008 12:02:39 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1993806nfc.21
        for <linux-acpi@vger.kernel.org>; Thu, 17 Jul 2008 09:02:37 -0700 (PDT)
In-Reply-To: <487F58B6.5040309@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>

Alexey Starikovskiy wrote:
> Hi Alan,
>
> Could you please test if your patch works with the last patch in #10919?
>
> Thanks,
> Alex.
Vacuously so.

My patch still applies, but #10919 makes it obsolete.  My patch fixed a
bug that shows up in polling mode.  #10919 kills polling mode.

I've tested v2.6.26 + #10919 and it works fine (except for spamming the
kernel log - please read my Bugzilla comment).


It appears that interrupt mode suffered from a race which is very
similar to my original problem.  If two GPE interrupts arrive before the
workqueue runs, then the second interrupt will be ignored because
EC_FLAGS_QUERY_PENDING is still set.  This will happen with any EC if
interrupts are very close together, right?

I think my patch also fixes this theoretical problem.  But I'd rather
you took over on this.  I was already confused by ec.c in v2.6.26, and
with #10919 I understand it even less.  E.g. why is
ec_switch_to_poll_mode() still present; what does it do now do_ec_poll()
is removed?

I'm happy to work on this with you, but I'd need to be able understand
the code first :-(.

Alan
