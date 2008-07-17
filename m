From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] ACPI : Set FAN device to correct state in boot phase
Date: Thu, 17 Jul 2008 14:49:29 +0200
Message-ID: <487F3FD9.5000002@firstfloor.org>
References: <1216019643.32159.1.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:55572 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751273AbYGQMta (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jul 2008 08:49:30 -0400
In-Reply-To: <1216019643.32159.1.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

Zhao Yakui wrote:
> Subject:ACPI: Set FAN device to correct state in boot phase
> From: Zhao Yakui <yakui.zhao@intel.com>
> 
> On some laptops when ACPI FAN driver is loaded, maybe the FAN device will be
> turned on. But if the temperature is below the threshold, the corresponding 
> FAN device should be turned off in the course of loading thermal driver.
> 
> So it is necessary to set the FAN device to the correct state in course of loading
> the thermal driver.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=8049

Queued, thanks.

-Andi
