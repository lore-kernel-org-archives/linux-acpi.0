From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH](memory hotplug) Repost remove useless message at boot time from 2.6.18-rc4.
Date: Thu, 31 Aug 2006 16:22:09 -0600
Message-ID: <200608311622.10761.bjorn.helgaas@hp.com>
References: <20060825205423.0778.Y-GOTO@jp.fujitsu.com> <223978.1156683050640.SLOX.WebMail.wwwrun@imap-dhs.suse.de> <20060828223538.F622.Y-GOTO@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel6.hp.com ([156.153.255.205]:48769 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S932375AbWHaWVn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 31 Aug 2006 18:21:43 -0400
In-Reply-To: <20060828223538.F622.Y-GOTO@jp.fujitsu.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: Thomas Renninger <trenn@suse.de>, akpm@osdl.org, "Brown, Len" <len.brown@intel.com>, keith mannthey <kmannth@us.ibm.com>, ACPI-ML <linux-acpi@vger.kernel.org>, Linux Kernel ML <linux-kernel@vger.kernel.org>, Linux Hotplug Memory Support <lhms-devel@lists.sourceforge.net>, naveen.b.s@intel.com

On Monday 28 August 2006 08:12, Yasunori Goto wrote:
> > Am Fr 25.08.2006 13:59 schrieb Yasunori Goto <y-goto@jp.fujitsu.com>:
> Ok. Followings are current my understanding of sequence
> with your patch.
> 
> At boot time, acpi_memory_device_init() is called.
> 
> acpi_memory_device_init()
>    |
>    +---> acpi_bus_register_driver()
>            |
>            +---> acpi_driver_attach()
>                    |
>                    +---> acpi_bus_driver_init()
>                            |
>                            +---> acpi_memory_device_add()
>                                     |
>                                     +---> acpi_install_notify_handler().
> 
> 
> The problem is in acpi_driver_attach(). This function is using
> "acpi_device_list" to call acpi_bus_driver_init().
> 
> This list is registered by acpi_device_register() which is called by
> acpi_add_single_object().
> However, acpi_add_single_object() skips calling it if _STA is not on.
> 
> 1015         switch (type) {
> 1016         case ACPI_BUS_TYPE_PROCESSOR:
> 1017         case ACPI_BUS_TYPE_DEVICE:
> 1018                 result = acpi_bus_get_status(device);
> 1019                 if (ACPI_FAILURE(result) || !device->status.present) {
> 1020                         result = -ENOENT;
> 1021                         goto end;
> 1022                 }
> 1023                 break;
> 
> So, notify handler is registered just for memory device which is enable
> at boot time.
> If notify event occurs for new memory device, there is no notify handler
> for it....

I looked at this over a year ago, and my feeble recollection is
that if _STA says "not present", we don't do the device_add.  Later,
when _STA changes to "present", we get an ACPI notification.  I
expected that we would just do the device_add() at that time, and
there are even comments in acpi_bus_check_device() that suggest that,
but it just looks unfinished.

It seemed like it would be much cleaner to finish that up, and then
the driver's .add method would automatically get called, and the
memory driver wouldn't have to bother with all the notification stuff.

Bjorn
