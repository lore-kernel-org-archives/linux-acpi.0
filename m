From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH] ACPI, APEI: Fixup common access width firmware bug
Date: Tue, 12 Jun 2012 16:46:47 +0800
Message-ID: <1339490807.7404.39.camel@yhuang-dev>
References: <1339490608.21507.5.camel@amber.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:43383 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751957Ab2FLIqt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 Jun 2012 04:46:49 -0400
In-Reply-To: <1339490608.21507.5.camel@amber.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Gary Hade <garyhade@us.ibm.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Tue, 2012-06-12 at 10:43 +0200, Jean Delvare wrote:
> Many firmwares have a common register definition bug where 8-bit
> access width is specified for a 32-bit register. Ideally this should
> be fixed in the BIOS, but earlier versions of the kernel did not
> complain, so fix that up silently.
> 
> This closes kernel bug #43282:
> https://bugzilla.kernel.org/show_bug.cgi?id=43282
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Gary Hade <garyhade@us.ibm.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: stable@vger.kernel.org [3.4+]
Acked-by: Huang Ying <ying.huang@intel.com>

Best Regards,
Huang Ying


