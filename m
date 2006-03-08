From: "Brown, Len" <len.brown@intel.com>
Subject: Re is there an easy way to tell if anacpi_deviceis on a PCI bus?
Date: Wed, 8 Mar 2006 15:53:26 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B300652368F@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr22.intel.com ([143.183.121.14]:21940 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S932263AbWCHUyE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Mar 2006 15:54:04 -0500
Received: from scsfmr100.sc.intel.com (scsfmr100.sc.intel.com [10.3.253.9])
	by scsfmr002.sc.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k28Ks4Qu021553
	for <linux-acpi@vger.kernel.org>; Wed, 8 Mar 2006 20:54:04 GMT
Received: from fmsmsxvs040.fm.intel.com (fmsmsxvs040.fm.intel.com [132.233.42.124])
	by scsfmr100.sc.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id k28Ks03b012183
	for <linux-acpi@vger.kernel.org>; Wed, 8 Mar 2006 20:54:06 GMT
Received: from fmsmsx332.amr.corp.intel.com ([132.233.42.148])
 by fmsmsxvs040.fm.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2006030812540317917
 for <linux-acpi@vger.kernel.org>; Wed, 08 Mar 2006 12:54:03 -0800
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Accardi, Kristen C" <kristen.c.accardi@intel.com>
Cc: linux-acpi@vger.kernel.org

>>> I was wondering if there was an easy way to tell, given an acpi_device
>>> struct if that object was a device on a PCI bus?  I was wondering if the
>>> existence of _ADR meant this was a PCI device, but it seems that _ADR
>>> can also be for USB devices as well?

>> _ADR is generic, it has different meaning depending
>> on the class of device.  the PCI decoding is one such meaning.
>> 
>> PCI devices are children of PCI (bus) devices.
>> Shaohua did a patch a while back to get to the PCI device
>> from an ACPI device for the purpose of D-states.

> I don't think that will work for me, as I am working in the context of
> hotplug, where a struct pci_dev will not exist yet.

Ah, pci_acpi_find_device() seems to be the opposite of what you want.
It starts with a PCI devnum from the PCI sub-system and then
looks up the acpi_handle in the DSDT.

To find if an acpi_device is a child of a PCI bus, it seems
that you need to look at its parent, and parents of parents...
to see if any are a PCI bus, eg have HID PNP0A03.

-Len

