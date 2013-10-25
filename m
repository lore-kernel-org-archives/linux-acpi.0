From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86/ACPI: Make Sony Vaio Z1 series to use "reboot=pci" default
Date: Fri, 25 Oct 2013 18:16:16 +0100
Message-ID: <CA+55aFyZEZp3CSFEcxzKt0c_7Q9_juGWiqb7VH214Fjcs3wUkQ@mail.gmail.com>
References: <1382597377-26797-1-git-send-email-tianyu.lan@intel.com>
	<20131025105352.GA5419@gmail.com>
	<1382719652.2445.1.camel@adam.happyassassin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vb0-f47.google.com ([209.85.212.47]:41736 "EHLO
	mail-vb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752202Ab3JYRQQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Oct 2013 13:16:16 -0400
In-Reply-To: <1382719652.2445.1.camel@adam.happyassassin.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adam Williamson <awilliam@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>, Lan Tianyu <tianyu.lan@intel.com>, Matthew Garrett <mjg@redhat.com>, Peter Anvin <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Robin Holt <holt@sgi.com>, davej@fedoraproject.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Thomas Gleixner <tglx@linutronix.de>

On Fri, Oct 25, 2013 at 5:47 PM, Adam Williamson <awilliam@redhat.com> wrote:
>
> I don't, but one comment I could add is that reboot _used_ to work okay
> on the Z1. And I _think_ it's worked OK since the April 2011 commit you
> mention (so the introduction of that didn't break it), but I can't
> absolutely swear to it.

It might be interesting to try, and if it used to work with the acpi
method, use bisection to see when it stopped working..

               Linus
