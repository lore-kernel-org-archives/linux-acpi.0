From: Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH] x86_64: enable SWIOTLB if system has SRAT memory regions
 above MAX_DMA32_PFN
Date: Mon, 30 Nov 2015 21:45:29 -0500
Message-ID: <565D09C9.9000708@redhat.com>
References: <1448904938-92922-1-git-send-email-imammedo@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41713 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751841AbbLACpd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 30 Nov 2015 21:45:33 -0500
In-Reply-To: <1448904938-92922-1-git-send-email-imammedo@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Igor Mammedov <imammedo@redhat.com>, linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, konrad.wilk@oracle.com, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, akataria@vmware.com, fujita.tomonori@lab.ntt.co.jp, revers@redhat.com

On 11/30/2015 12:35 PM, Igor Mammedov wrote:
> when memory hotplug enabled system is booted with less
> than 4GB of RAM and then later more RAM is hotplugged
> 32-bit devices stop functioning with following error:
> 
>  nommu_map_single: overflow 327b4f8c0+1522 of device mask ffffffff
> 
> the reason for this is that if x86_64 system were booted
> with RAM less than 4GB, it doesn't enable SWIOTLB and
> when memory is hotplugged beyond MAX_DMA32_PFN, devices
> that expect 32-bit addresses can't handle 64-bit addresses.
> 
> Fix it by tracking max possible PFN when parsing
> memory affinity structures from SRAT ACPI table and
> enable SWIOTLB if there is hotpluggable memory
> regions beyond MAX_DMA32_PFN.
> 
> It fixes KVM guests when they use emulated devices
> (reproduces with ata_piix, e1000 and usb devices,
>  RHBZ: 1275941, 1275977, 1271527)
> It also fixes the HyperV, VMWare with emulated devices
> which are affected by this issue as well.
> 
> Systems that have RAM less than 4GB and do not use
> memory hotplug but still have hotplug regions in SRAT
> (i.e. broken BIOS that can't disable mem hotplug)
> can disable memory hotplug with 'acpi_no_memhotplug = 1'
> to avoid automatic SWIOTLB initialization.
> 
> Tested on QEMU/KVM and HyperV.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Acked-by: Rik van Riel <riel@redhat.com>




-- 
All rights reversed
