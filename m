From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH update] PCI / ACPI: PCI delay optimization from ACPI
Date: Mon, 23 Mar 2015 17:15:28 +0800
Message-ID: <550FD9B0.7070803@intel.com>
References: <54FD4FB9.2060802@intel.com> <5222588.FaRe37n2T1@vostro.rjw.lan> <54FE93A4.9040908@intel.com> <20150320210354.GK26935@google.com> <550FA607.8080805@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:39447 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752187AbbCWJQ7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Mar 2015 05:16:59 -0400
In-Reply-To: <550FA607.8080805@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>

On 03/23/2015 01:35 PM, Aaron Lu wrote:
> On 03/21/2015 05:03 AM, Bjorn Helgaas wrote:
>> I think you need something in pci_root.c that evaluates _DSM function 8 for
>> the host bridge, and then some mechanism for all the devices under that
>> bridge to inherit the result.
> 
> Thanks for the suggestion, will try to do this in the next revision.

Turned out I can decide if a PCI bridge is the host bridge or not by
checking: pdev->bus->bridge->parent pointer, so I did something like
this instead:

+       /* Function 8 is only applicable to host bridge */
+       if (pdev->bus->bridge->parent)
+               return;

Looks good?

And I also renamed the UUID and moved the common definitions to pci.h,
so the following two patches do these things:
patch 1: rename the PCI UUID and move the definitions to pci.h;
patch 2: add check for host bridge in pci_acpi_delay_optimize, re-order
         elements[0] and elements[3] check and use macros for _DSM
	 function 8 and 9.

Thanks,
Aaron
