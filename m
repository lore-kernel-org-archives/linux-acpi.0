From: Kristen Accardi <kristen.c.accardi@intel.com>
Subject: Re: [Pcihpd-discuss] Re: [patch 0/4]  Hot Dock/Undock support
Date: Wed, 18 Jan 2006 13:43:00 -0800
Message-ID: <1137620581.31839.21.camel@whizzy>
References: <1137545813.19858.45.camel@whizzy>
	 <20060118130444.GA1518@elf.ucw.cz> <1137609747.31839.6.camel@whizzy>
	 <20060118204251.GA1544@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr19.intel.com ([134.134.136.18]:24010 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1161029AbWARWBF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Jan 2006 17:01:05 -0500
In-Reply-To: <20060118204251.GA1544@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, pcihpd-discuss@lists.sourceforge.net, len.brown@intel.com, linux-acpi@vger.kernel.org

On Wed, 2006-01-18 at 21:42 +0100, Pavel Machek wrote:
> Hi!
> 
> There's a bug in error handling:
> 
> int __init acpiphp_glue_init(void)
> {
>         int num = 0;
> 
>         acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
>                         ACPI_UINT32_MAX, find_root_bridges, &num,
> NULL);
> 
>         if (num <= 0)
>                 return -1;
>         else
>                 acpi_pci_register_driver(&acpi_pci_hp_driver);
> 
>         return 0;
> }
> 
> You register driver here, but if acpiphp_get_num_slots() returns 0
> later, you return -ENODEV, aborting load of driver, but without
> undergistering that driver. It oopses after a while. Same problem if
> init_slots() returns error.
> 
> 								Pavel

This one needs some more thought on how to fix, because I'm not certain
if we have the code in place to back out of this once we find root
bridges that exist.  it might be easy, but it might not be. 

