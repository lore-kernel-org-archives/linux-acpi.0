From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH -v2 0/4] ACPI, APEI, Add APEI related _OSC support
Date: Mon, 27 Jun 2011 13:38:47 -0700
Message-ID: <m27h872enc.fsf@firstfloor.org>
References: <1309163160-3201-1-git-send-email-ying.huang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:15537 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754266Ab1F0UkJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Jun 2011 16:40:09 -0400
In-Reply-To: <1309163160-3201-1-git-send-email-ying.huang@intel.com> (Huang
	Ying's message of "Mon, 27 Jun 2011 16:25:56 +0800")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org

Huang Ying <ying.huang@intel.com> writes:

> Changes:
>
> - Change error message for WHEA _OSC call according to Matthew's comments
>
> [PATCH -v2 1/4] ACPI, APEI, GHES, Prevent GHES to be built as module
> [PATCH -v2 2/4] ACPI, APEI, GHES, Support disable GHES at boot time
> [PATCH -v2 3/4] ACPI, APEI, Add APEI bit support in generic _OSC call
> [PATCH -v2 4/4] ACPI, APEI, Add WHEA _OSC support

FWIW I reviewed the patch-kit and it all looks good to me.

Reviewed-by: Andi Kleen <ak@linux.intel.com>

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
