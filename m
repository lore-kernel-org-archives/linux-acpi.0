From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 8/8] ACPI / trace: Add trace interface for eMCA driver
Date: Tue, 15 Oct 2013 19:47:56 +0200
Message-ID: <20131015174756.GH7908@pd.tnic>
References: <1381473166-29303-1-git-send-email-gong.chen@linux.intel.com>
 <1381473166-29303-9-git-send-email-gong.chen@linux.intel.com>
 <20131015165435.GA2777@naverao1-tp.ibm.com>
 <20131015170039.GF7908@pd.tnic>
 <525D7BCD.7080303@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:34486 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932287Ab3JORsK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Oct 2013 13:48:10 -0400
Content-Disposition: inline
In-Reply-To: <525D7BCD.7080303@linux.vnet.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: "Chen, Gong" <gong.chen@linux.intel.com>, tony.luck@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, m.chehab@samsung.com

On Tue, Oct 15, 2013 at 11:00:53PM +0530, Naveen N. Rao wrote:
> I thought the primary problem was the conflict with edac core itself.
> So, if I'm not mistaken, we would have to prevent all edac drivers
> from loading.

That too - I don't see the need for them if the firmware does the
decoding.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
