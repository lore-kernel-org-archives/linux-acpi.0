From: Frans Pop <elendil@planet.nl>
Subject: Re: [PATCH] acpi processor: simplify needlessly complex printk
Date: Mon, 29 Jun 2009 00:28:32 +0200
Message-ID: <200906290028.33285.elendil@planet.nl>
References: <200906282203.55643.elendil@planet.nl> <4A47E85D.3020202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from Cpsmtpm-eml107.kpnxchange.com ([195.121.3.11]:49726 "EHLO
	CPSMTPM-EML107.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752106AbZF1W2b (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 28 Jun 2009 18:28:31 -0400
In-Reply-To: <4A47E85D.3020202@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

On Monday 29 June 2009, Justin P. Mattock wrote:
> Would it be better to capitalize the S and add a period at the
> end, or does it not matter?

Kernel messages are in general not sentences.

I thought of removing the parenteses, but if you look at the context of 
the message then that only makes sense if other messages are modified at 
the same time. The messages below appear together for my system and their 
consistency could definitely be improved, but IMO that's better done in a 
separate patch.

ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
processor LNXCPU:00: registered as cooling_device7
ACPI: Processor [CPU0] (supports 8 throttling states)
