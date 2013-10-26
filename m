From: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH] x86/ACPI: Make Sony Vaio Z1 series to use "reboot=pci"
 default
Date: Fri, 25 Oct 2013 23:17:59 -0400
Message-ID: <20131026031759.GA8513@redhat.com>
References: <1382597377-26797-1-git-send-email-tianyu.lan@intel.com>
 <20131025105352.GA5419@gmail.com>
 <1382719652.2445.1.camel@adam.happyassassin.net>
 <CA+55aFyZEZp3CSFEcxzKt0c_7Q9_juGWiqb7VH214Fjcs3wUkQ@mail.gmail.com>
 <1382750841.19471.72.camel@adam.happyassassin.net>
 <1382754015.19471.80.camel@adam.happyassassin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:3935 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754085Ab3JZDSZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 25 Oct 2013 23:18:25 -0400
Content-Disposition: inline
In-Reply-To: <1382754015.19471.80.camel@adam.happyassassin.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adam Williamson <awilliam@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Lan Tianyu <tianyu.lan@intel.com>, Matthew Garrett <mjg@redhat.com>, Peter Anvin <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Robin Holt <holt@sgi.com>, davej@fedoraproject.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Thomas Gleixner <tglx@linutronix.de>

On Fri, Oct 25, 2013 at 07:20:15PM -0700, Adam Williamson wrote:
 > OK, so, findings: F16 and F17 live images reboot quickly. F18 is the
 > first that reboots slowly.

wait, stop. what does "reboots slowly" mean ? 
In every one of the failure I've seen, without a quirk it means reboot
doesn't happen at all.

	Dave
