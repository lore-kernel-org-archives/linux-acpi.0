From: Hamie <hamish@travellingkiwi.com>
Subject: Re: No APIC interrupts after ACPI suspend
Date: Sat, 26 Jun 2004 01:05:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <40DCBDCC.4070405@travellingkiwi.com>
References: <1088160505.3702.4.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-S265537AbUFZAF4@vger.kernel.org>
In-Reply-To: <1088160505.3702.4.camel@tyrosine>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

Matthew Garrett wrote:

>If I do an S3 suspend, my machine resumes correctly (Thinkpad X40,
>acpi_sleep=s3_bios passed on the command line). If I have the ioapic
>enabled, however, I get no interrupts after resume. Hacking in a call to
>APIC_init_uniprocessor in the resume path improves things - I get edge
>triggered interrupts, but anything flagged as level triggered doesn't
>work. How can I get the ioapic fully initialised on resume?
>  
>
I have an identical problem with an r50p. But I'm running PIC... 
(Because the r50p doesn't seem to do APIC). Not sure if it's identical, 
but after resuming, I get maybe 10 seconds of sound, OR 30 odd minutes 
of networking (I know... Sounds strange)... Then neither...

H
