From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2 0/2] net: thunder: Add ACPI support.
Date: Tue, 11 Aug 2015 13:49:11 -0700 (PDT)
Message-ID: <20150811.134911.568429332024299359.davem@davemloft.net>
References: <1439254717-2875-1-git-send-email-ddaney.cavm@gmail.com>
	<20150811.114908.1384923604512568161.davem@davemloft.net>
	<55CA5567.9010002@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:51771 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932120AbbHKUtO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Aug 2015 16:49:14 -0400
In-Reply-To: <55CA5567.9010002@caviumnetworks.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ddaney@caviumnetworks.com
Cc: ddaney.cavm@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, rrichter@cavium.com, tomasz.nowicki@linaro.org, sgoutham@cavium.com, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, mark.rutland@arm.com, rafael@kernel.org, david.daney@cavium.com

From: David Daney <ddaney@caviumnetworks.com>
Date: Tue, 11 Aug 2015 13:04:55 -0700

> You seem to be recommending precedence for OF.  It should be
> consistent across all drivers/sub-systems, so do you really think
> that OF before ACPI is the way to go?

I just think it's more hackish to test acpi_disabled than to
simply see if the matching OF node even exists.

If ACPI is enabled, no OF node will be found.

It could just be my preference for such things.

I really wish it just fell out from the probing method, but
we're using PCI for that.
