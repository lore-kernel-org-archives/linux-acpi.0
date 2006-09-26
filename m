From: <eiichiro.oiwa.nm@hitachi.com>
Subject: Re:[patch 10/10] Fix incorrect handling PCI-Express Root Bridge _HID
Date: Tue, 26 Sep 2006 13:41:16 +0900
Message-ID: <XNM1$9$0$4$$3$3$7$A$9002679U4518af61@hitachi.com>
References: <200609252328.k8PNSGca002194@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail9.hitachi.co.jp ([133.145.228.44]:27023 "EHLO
	mail9.hitachi.co.jp") by vger.kernel.org with ESMTP
	id S1750742AbWIZElf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Sep 2006 00:41:35 -0400
Received: from mlsv10.hitachi.co.jp (unknown [133.145.228.16])
	by mail9.hitachi.co.jp (Postfix) with ESMTP id D675337C95
	for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2006 13:41:33 +0900 (JST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org

Hi Andrew,

We need this patch for APCI hotplug because APCI parser gets bus number from acpi_object_extra. I already tested this patch by ACPI hotplug, and confirmed there is no problem on our box has described PCI topology.
I don't have git rights.
Could you merge this patch into Linus's tree?

Thanks,
Eiichiro Oiwa

>From: <eiichiro.oiwa.nm@hitachi.com>
>
>Lifted from http://bugzilla.kernel.org/show_bug.cgi?id=7145
>
>PCI Bus Topology:
>
>[CPU] [CPU]        [CPU]  [CPU]
>  |      |BUS        |     |   BUS
>--+--+---+---      --+--+--+------
>     |                  |
> [Root Bridge]*1-----[Root Bridge]*1
>     |      |           \        \
> [Bridge]   |        [PCI-e slot] [PCI-e slot]
>    | |    [PCI-e slot]
>    | \
>    | [PCI-e slot]
>    |
>    |
> [PCI Bridge]
>    |     \
>    |      [PCI-X slot]
>    |
> [PCI-X slot]
>
>*1: PCI Express Root Bridge.
>
>I could not get correct PCI Express BUS number from the structure of
>acpi_object_extra.  I always get zero as BUS number regardless of BUS
>location.  I found that there is incorrect comparison with _HID (PNP0A08)
>in acpi/events/evrgnini.c and PCI Express _BBN method always fail. 
>Therefore, we get always get zero as PCI Express bus number.
>
>I suggest the following patch.
>
>Cc: "Brown, Len" <len.brown@intel.com>
>Cc: <linux-acpi@vger.kernel.org>
>Signed-off-by: Andrew Morton <akpm@osdl.org>
>---
>
> drivers/acpi/events/evrgnini.c |    4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff -puN drivers/acpi/events/evrgnini.c~fix-incorrect-handling-of-pci-express-root-bridge-_hid drivers/acpi/events/evrgnini.c
>--- a/drivers/acpi/events/evrgnini.c~fix-incorrect-handling-of-pci-express-root-bridge-_hid
>+++ a/drivers/acpi/events/evrgnini.c
>@@ -225,12 +225,12 @@ acpi_ev_pci_config_region_setup(acpi_han
> 				if (!
> 				    (ACPI_STRNCMP
> 				     (object_hID.value, PCI_ROOT_HID_STRING,
>-				      sizeof(PCI_ROOT_HID_STRING))
>+				      sizeof(PCI_ROOT_HID_STRING)))
> 				     ||
> 				     !(ACPI_STRNCMP
> 				       (object_hID.value,
> 					PCI_EXPRESS_ROOT_HID_STRING,
>-					sizeof(PCI_EXPRESS_ROOT_HID_STRING)))))
>+					sizeof(PCI_EXPRESS_ROOT_HID_STRING))))
> 				{
> 
> 					/* Install a handler for this PCI root bridge */
>_
>
