From: Kenji Kaneshige <kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: Re: [PATCH 2.6.13-rc4 1/2] fix possible null pointer access
 - acpi_pci_irq_enable
Date: Fri, 05 Aug 2005 10:34:07 +0900
Message-ID: <42F2C20F.4050807@jp.fujitsu.com>
References: <42ED97C2.7060409@jp.fujitsu.com> <42ED9830.7060808@jp.fujitsu.com> <20050803113637.GB4038@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050803113637.GB4038-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

> Should people be passing NULLs here, anyway? Is not the right fix to
> remove the check, and remove the (!dev) check, too, and just fix the
> callers? People are going to fix the oops, but noone is going to see
> that ACPI_DEBUG_PRINT...

As you said, I think people should not pass NULLs here, and we should
fix the caller. But I think it is not bad to check (!dev) and (!dev->bus)
in these functions instead of panic. How about using WARN_ON here to
notify people of badness?

	if (!dev) {
		WARN_ON(1);
		return_VALUE(-EINVAL);
	}

	if (!dev->bus) {
		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid (NULL) 'bus' field\n"));
		WARN_ON(1);
		return_VALUE(-ENODEV);
	}

Thanks,
Kenji Kaneshige


Pavel Machek wrote:
> Hi!
> 
> 
>>This patch fixes possible null pointer access in acpi_pci_irq_enable.
>>
>>The 'bus' field in pci_dev structure should be checked before calling
>>pci_read_config_byte() because pci_bus_read_config_byte() called by
>>pci_read_config_byte() refers to 'bus' field.
> 
> 
> Should people be passing NULLs here, anyway? Is not the right fix to
> remove the check, and remove the (!dev) check, too, and just fix the
> callers? People are going to fix the oops, but noone is going to see
> that ACPI_DEBUG_PRINT...
> 
> 
> 								Pavel
> 
> 
> 
>>Signed-off-by: Kenji Kaneshige <kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
>>---
>>
>> drivers/acpi/pci_irq.c |   10 +++++-----
>> 1 files changed, 5 insertions(+), 5 deletions(-)
>>
>>diff -puN drivers/acpi/pci_irq.c~fix-possible-null-pointer-access-acpi_pci_irq_enable drivers/acpi/pci_irq.c
>>--- linux-2.6.13-rc4/drivers/acpi/pci_irq.c~fix-possible-null-pointer-access-acpi_pci_irq_enable	2005-08-01 12:20:26.000000000 +0900
>>+++ linux-2.6.13-rc4-kanesige/drivers/acpi/pci_irq.c	2005-08-01 12:20:26.000000000 +0900
>>@@ -397,6 +397,11 @@ acpi_pci_irq_enable (
>> 
>> 	if (!dev)
>> 		return_VALUE(-EINVAL);
>>+
>>+	if (!dev->bus) {
>>+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid (NULL) 'bus' field\n"));
>>+		return_VALUE(-ENODEV);
>>+	}
>> 	
>> 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
>> 	if (!pin) {
>>@@ -405,11 +410,6 @@ acpi_pci_irq_enable (
>> 	}
>> 	pin--;
>> 
>>-	if (!dev->bus) {
>>-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid (NULL) 'bus' field\n"));
>>-		return_VALUE(-ENODEV);
>>-	}
>>-
>> 	/* 
>> 	 * First we check the PCI IRQ routing table (PRT) for an IRQ.  PRT
>> 	 * values override any BIOS-assigned IRQs set during boot.
>>_
>>
>>
>>
>>-------------------------------------------------------
>>SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
>>from IBM. Find simple to follow Roadmaps, straightforward articles,
>>informative Webcasts and more! Get everything you need to get up to
>>speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
>>_______________________________________________
>>Acpi-devel mailing list
>>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>>https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 
> 



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
