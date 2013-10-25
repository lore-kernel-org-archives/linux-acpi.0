From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86/ACPI: Make Sony Vaio Z1 series to use "reboot=pci" default
Date: Fri, 25 Oct 2013 13:54:24 +0100
Message-ID: <CA+55aFzAyhdkN4t2YTTQd-_Yf6WA_FYRjP4JnpSCeSvqxzRRCA@mail.gmail.com>
References: <1382597377-26797-1-git-send-email-tianyu.lan@intel.com>
	<20131025105352.GA5419@gmail.com>
	<20131025124402.GA7089@redhat.com>
	<526A6898.8030806@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vb0-f50.google.com ([209.85.212.50]:45316 "EHLO
	mail-vb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822Ab3JYMyZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Oct 2013 08:54:25 -0400
In-Reply-To: <526A6898.8030806@zytor.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Jones <davej@redhat.com>, Ingo Molnar <mingo@kernel.org>, Lan Tianyu <tianyu.lan@intel.com>, Matthew Garrett <mjg@redhat.com>, the arch/x86 maintainers <x86@kernel.org>, Robin Holt <holt@sgi.com>, davej@fedoraproject.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Adam Williamson <awilliam@redhat.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Thomas Gleixner <tglx@linutronix.de>

On Fri, Oct 25, 2013 at 1:48 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>
> The Dell problem I believe is understood... they are invoking the KBC as
> their ACPI reboot port, and it is believed that that triggers an SMI
> which invokes the BIOS, and the BIOS is broken if you behave like a
> non-Windows system.

Well, that's presumably true of *all* the machines. Because I bet
windows boots on it. The details may matter.

The solution is to act more like Windows. There was some talk about
one likely fundamental difference being in how we enable VT-d. Maybe
we should just change that?

Seriously, if the "fix" is potentially something as simple as
disabling VT-d before reboots, let's just do it. Not add these quirks.
We have people to test a patch, but what _is_ that patch?

               Linus
