From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: does anyone have Dell Latitude E6400?
Date: Tue, 09 Jun 2009 15:05:53 +0800
Message-ID: <1244531153.9076.68.camel@rzhang-dt>
References: <1244529861.9076.61.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:1572 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752465AbZFIHFY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 9 Jun 2009 03:05:24 -0400
In-Reply-To: <1244529861.9076.61.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>

BTW, it would be great if someone can verify if the Macbook MB402LL/A,
MB403LL/A, MB404LL/A has ACPI ambient light sensor or not.

thanks,
rui

On Tue, 2009-06-09 at 14:44 +0800, Zhang Rui wrote:
> Hi, all,
> 
> I need to purchase a laptop with ambient light sensor to implement the
> ACPI ambient light sensor driver in Linux.
> Google tells me that Dell Latitude e6400 has this, but I'm not sure if
> the sensor is controlled via ACPI or platform specific methods.
> so can anybody that has this laptop send me the lspci and acpidump
> output please?
> 
> If somebody knows some other laptop models with this ACPI device (grep
> ACPI0008 and _ALI/_ALR control methods in the acpidump), please let me
> know.
> 
> BTW, to get the acpidump output, you need to download the latest pmtools
> at http://www.lesswatts.org/projects/acpi/utilities.php,
> build and run "acpidump > acpidump.log".
> 
> thanks,
> rui
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

