From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [0/12] acpi: make ACPI use driver model
Date: Wed, 25 Oct 2006 14:40:04 -0600
Message-ID: <200610251440.04502.bjorn.helgaas@hp.com>
References: <1158916460.11985.45.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:27098 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1161369AbWJYUkL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Oct 2006 16:40:11 -0400
In-Reply-To: <1158916460.11985.45.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, len.brown@intel.com

On Friday 22 September 2006 03:14, Zhang Rui wrote:
> Make ACPI use driver model.

What's happening with this series?  It doesn't seem to be in -mm
yet.  Some of this stuff has been kicking around for a year already.
It'd be nice to go forward or give up on the idea.

> Patrick has posted patches on rewriting ACPI driver model in November 2005.
> And recently Shaohua send me a prototype on making ACPI use driver model.
> This patch series bases on both Patrick and Shaohua's previous work. 
> 
> Two features are gonna to be changed by applying this series of patches.
> 1.	ACPI driver model. 
> 	ACPI driver are made to follow Linux driver model.
> 	The mainly work is to convert the registeration interfaces, so that
> 	ACPI devices are registered with the global device tree.
> 	Note the new .uevent method mark ACPI drivers by PNPID 
> 	instead of by name. Udev script needs to look for "HWID = "
> 	or "COMPTID = " to load the right ACPI driver.
> 2.	ACPI sysfs interface. 
> 	As a result of using driver model, ACPI devices is added in the 
> 	/sys/device tree. So after _EJ0 is added as a property of 
> 	ACPI device in device tree, /sys/firm/acpi is deleted.
> 	Note that the corresponding userspace script needs to be changed 
> 	for hot removal.
> 
> Note that this is only the first step of ACPI sysfs convert project.
> The next step is to duplicate /proc/acpi functions in /sys/device tree.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
