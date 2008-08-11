From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] acpi: replace AE_BAD_ADDRESS exception code with AE_ERROR
Date: Mon, 11 Aug 2008 13:26:06 +0200
Message-ID: <48A021CE.9040706@linux.intel.com>
References: <1218167831.4978.11.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:4989 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751400AbYHKL0A (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Aug 2008 07:26:00 -0400
In-Reply-To: <1218167831.4978.11.camel@minggr.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>

Lin Ming wrote:
> Hi, Andi
> 
> The AE_BAD_ADDRESS exception code is now unused in ACPICA.
> For linux, it's only used at wmi.c and acer-wmi.c.
> I checked both wmi.c and acer-wmi.c, the AE_BAD_ADDRESS exception code
> has no special meaning. The parent functions just call AE_SUCCESS() or
> AE_FAILURE() to check the return status.
> So it's safe to replace AE_BAD_ADDRESS with AE_ERROR.

Queued for test thanks
-Andi
