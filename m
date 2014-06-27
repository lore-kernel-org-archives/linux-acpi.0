From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Linaro-acpi] [PATCH v4 12/13] ARM64 / ACPI: if we chose to boot from acpi then disable FDT
Date: Fri, 27 Jun 2014 11:09:27 +0200
Message-ID: <5766378.doqChWUeyl@wuerfel>
References: <1403840976-7456-1-git-send-email-hanjun.guo@linaro.org> <1403840976-7456-13-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:60535 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127AbaF0JJq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Jun 2014 05:09:46 -0400
In-Reply-To: <1403840976-7456-13-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linaro-acpi@lists.linaro.org
Cc: Hanjun Guo <hanjun.guo@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, rric@kernel.org, linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>

On Friday 27 June 2014 11:49:35 Hanjun Guo wrote:
> From: Graeme Gregory <graeme.gregory@linaro.org>
> 
> If the early boot methods of acpi are happy that we have valid ACPI
> tables and acpi=off has not been passed. Then do not unflat devicetree
> effectively disabling further hardware probing from DT.
> 

I guess this answers the question I had on patch 4 ;-)

	Arnd
