From: "Miles Lane" <miles.lane@gmail.com>
Subject: Re: 2.6.17-mm2 -- drivers/built-in.o: In function `is_pci_dock_device':acpiphp_glue.c:(.text+0x12364): undefined reference to `is_dock_device'
Date: Sun, 25 Jun 2006 13:13:04 -0700
Message-ID: <a44ae5cd0606251313n5e7654f3t652df65e811325b5@mail.gmail.com>
References: <a44ae5cd0606251256m74182e7fw4eb2692c89b0e2f8@mail.gmail.com>
	 <20060625200953.GF23314@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:45157 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932242AbWFYUNE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 25 Jun 2006 16:13:04 -0400
Received: by py-out-1112.google.com with SMTP id b36so893863pyb
        for <linux-acpi@vger.kernel.org>; Sun, 25 Jun 2006 13:13:04 -0700 (PDT)
In-Reply-To: <20060625200953.GF23314@stusta.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Kristen Accardi <kristen.c.accardi@intel.com>, Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, gregkh@suse.de, len.brown@intel.com, linux-acpi@vger.kernel.org

Should I attach my entire .config file in the future?  It's large enough that
I try to trim it to avoid bloating people's inboxes.

Yes, that's right.  It is compiled as a module.  So this just needs
a tweaked config rule, right?

Thanks,
         Miles

On 6/25/06, Adrian Bunk <bunk@stusta.de> wrote:
> On Sun, Jun 25, 2006 at 12:56:44PM -0700, Miles Lane wrote:
> > drivers/built-in.o: In function
> > `is_pci_dock_device':acpiphp_glue.c:(.text+0x12364): undefined
> > reference to `is_dock_device'
> > drivers/built-in.o: In function
> > `cleanup_bridge':acpiphp_glue.c:(.text+0x12bc4): undefined reference
> > to `is_dock_device'
> > :acpiphp_glue.c:(.text+0x12bd3): undefined reference to
> > `unregister_hotplug_dock_device'
> > :acpiphp_glue.c:(.text+0x12bdb): undefined reference to
> > `unregister_dock_notifier'
> > drivers/built-in.o: In function
> > `register_slot':acpiphp_glue.c:(.text+0x13ac0): undefined reference to
> > `is_dock_device'
> > :acpiphp_glue.c:(.text+0x13cd9): undefined reference to `is_dock_device'
> > :acpiphp_glue.c:(.text+0x13cf0): undefined reference to
> > `register_hotplug_dock_device'
> > :acpiphp_glue.c:(.text+0x13d1d): undefined reference to
> > `register_dock_notifier'
> > make: *** [.tmp_vmlinux1] Error 1
> >
> > #
> > # PCI Hotplug Support
> > #
> > CONFIG_HOTPLUG_PCI=y
> > CONFIG_HOTPLUG_PCI_FAKE=y
> > CONFIG_HOTPLUG_PCI_COMPAQ=y
> > # CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
> > CONFIG_HOTPLUG_PCI_ACPI=y
> > CONFIG_HOTPLUG_PCI_ACPI_IBM=y
> > CONFIG_HOTPLUG_PCI_CPCI=y
> > # CONFIG_HOTPLUG_PCI_CPCI_ZT5550 is not set
> > CONFIG_HOTPLUG_PCI_CPCI_GENERIC=y
> > CONFIG_HOTPLUG_PCI_SHPC=y
> > # CONFIG_HOTPLUG_PCI_SHPC_POLL_EVENT_MODE is not set
>
>
> You hadn't attached your complete .config, but is it correct when I
> assume you have CONFIG_ACPI_DOCK=m? This would explain the problem.
>
>
> cu
> Adrian
>
> --
>
>        "Is there not promise of rain?" Ling Tan asked suddenly out
>         of the darkness. There had been need of rain for many days.
>        "Only a promise," Lao Er said.
>                                        Pearl S. Buck - Dragon Seed
>
>
