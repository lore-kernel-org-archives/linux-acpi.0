From: David Eriksson <david@2good.nu>
Subject: Re: [ACPI] No APIC interrupts after ACPI suspend
Date: Sat, 26 Jun 2004 18:42:25 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1088268145.14987.248.camel@zion.2good.net>
References: <1088160505.3702.4.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-S267184AbUFZQk6@vger.kernel.org>
In-Reply-To: <1088160505.3702.4.camel@tyrosine>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

On Fri, 2004-06-25 at 12:48, Matthew Garrett wrote:
> If I do an S3 suspend, my machine resumes correctly (Thinkpad X40,
> acpi_sleep=s3_bios passed on the command line). If I have the ioapic
> enabled, however, I get no interrupts after resume. Hacking in a call to
> APIC_init_uniprocessor in the resume path improves things - I get edge
> triggered interrupts, but anything flagged as level triggered doesn't
> work. How can I get the ioapic fully initialised on resume?

Maybe you've found this bug?

http://bugme.osdl.org/show_bug.cgi?id=2643

-- 
-\- David Eriksson -/-                              www.2GooD.nu
 
"I personally refuse to use inferior tools because of ideology."
                                                - Linus Torvalds
