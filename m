From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [ACPI] No APIC interrupts after ACPI suspend
Date: Sun, 27 Jun 2004 17:27:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1088353667.5113.1.camel@tyrosine>
References: <1088160505.3702.4.camel@tyrosine>
	 <1088268145.14987.248.camel@zion.2good.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-S263975AbUF0QbZ@vger.kernel.org>
In-Reply-To: <1088268145.14987.248.camel@zion.2good.net>
To: David Eriksson <david@2good.nu>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

On Sat, 2004-06-26 at 18:42 +0200, David Eriksson wrote:

> Maybe you've found this bug?
> 
> http://bugme.osdl.org/show_bug.cgi?id=2643

Yeah, that one was biting me, but it's not the one causing this bug.
cat /proc/interrupts shows that the ACPI interrupt is correctly set to
level triggered, but the ioapic isn't set up correctly so no interrupts
make it through. The same seems to be true for all other level-triggered
interrupts.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
