From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH]  ACPI:  Unneccessary to scan the PCI bus already
	scanned.
Date: Mon, 3 Mar 2008 08:32:14 +0100
Message-ID: <20080303073214.GA5934@elte.hu>
References: <1204525186.4080.11.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:38463 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750800AbYCCHcb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 3 Mar 2008 02:32:31 -0500
Content-Disposition: inline
In-Reply-To: <1204525186.4080.11.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org


small typo:

> +		 * If the desired bus exits, the content of bus->sysdata will
                                        ^--- exists
> +		 * be replaced by sd.

also, it's not clear to me why the patch helps. Why does "double 
scanning" cause problems? We register devices twice? Shouldnt that just 
work? (except for a few "device already exists" type of messages)

	Ingo
