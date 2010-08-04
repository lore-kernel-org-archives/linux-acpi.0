From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Question regarding linux acpi
Date: Wed, 4 Aug 2010 21:22:32 +0100
Message-ID: <20100804202232.GA4276@srcf.ucam.org>
References: <20100804170236.GA32073@srcf.ucam.org> <BLU102-W81BE50E68610AAA92C33AEBAF0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:60222 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758817Ab0HDUWf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Aug 2010 16:22:35 -0400
Content-Disposition: inline
In-Reply-To: <BLU102-W81BE50E68610AAA92C33AEBAF0@phx.gbl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Raj Kumar <rajkumar278@hotmail.com>
Cc: linux-acpi@vger.kernel.org

On Thu, Aug 05, 2010 at 01:44:21AM +0530, Raj Kumar wrote:

>    Does it mean that only bus driver code will handle all low power mode
>    requests?

The bus code is responsible for calling the device-specific methods, but 
the device-specific drivers will typically know nothing about ACPI. 
They'll only know that the bus code asked them to enter a low-power mode 
or that they got a wakeup event.

>    peripherals are idle but not all peripherals belonging to bus then in that
>    case
> 
>    does the bus handle the low power modes of peripherals? 

Yes. All determination is done per-device. Check 
Documentation/power/runtime_pm.txt.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
