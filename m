From: Hamie <hamish@travellingkiwi.com>
Subject: Re: [ACPI] No APIC interrupts after ACPI suspend
Date: Sat, 26 Jun 2004 19:03:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <40DDBA7A.6010404@travellingkiwi.com>
References: <1088160505.3702.4.camel@tyrosine> <1088268145.14987.248.camel@zion.2good.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-S266345AbUFZSEH@vger.kernel.org>
In-Reply-To: <1088268145.14987.248.camel@zion.2good.net>
To: David Eriksson <david@2good.nu>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

David Eriksson wrote:

>On Fri, 2004-06-25 at 12:48, Matthew Garrett wrote:
>  
>
>>If I do an S3 suspend, my machine resumes correctly (Thinkpad X40,
>>acpi_sleep=s3_bios passed on the command line). If I have the ioapic
>>enabled, however, I get no interrupts after resume. Hacking in a call to
>>APIC_init_uniprocessor in the resume path improves things - I get edge
>>triggered interrupts, but anything flagged as level triggered doesn't
>>work. How can I get the ioapic fully initialised on resume?
>>    
>>
>
>Maybe you've found this bug?
>
>http://bugme.osdl.org/show_bug.cgi?id=2643
>
>  
>
I think you're right... I've applied the patch to 2.6.7, and I'm still 
running after a boot-suspend-resume cycle. Hopefully it isn't just a 
fluke :)

The original patch seems to have been logged at the time of 2.6.6. Was 
it just too late to make 2.6.7? Will it be fixed in 2.6.8?

Thanks.

  Hamish.
