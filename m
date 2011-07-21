From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [BUGFIX] ACPI, APEI, EINJ Param support is disabled by default
Date: Thu, 21 Jul 2011 04:42:04 +0200
Message-ID: <20110721024204.GJ8006@one.firstfloor.org>
References: <1311149369-20624-1-git-send-email-ying.huang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:40419 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990Ab1GUCmJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Jul 2011 22:42:09 -0400
Content-Disposition: inline
In-Reply-To: <1311149369-20624-1-git-send-email-ying.huang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org, Matthew Garrett <mjg@redhat.com>

>  
> +static bool param_extension;
> +module_param(param_extension, bool, 0);

Make it 0644, then it can be changed at runtime. No need to require a reboot.

-Andi
