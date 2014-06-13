From: Robert Richter <rric@kernel.org>
Subject: Re: [PATCH v3 0/5] APEI: Make APEI architecture independent.
Date: Fri, 13 Jun 2014 15:14:23 +0200
Message-ID: <20140613131423.GZ27560@rric.localhost>
References: <1402657380-18539-1-git-send-email-tomasz.nowicki@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:34484 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750902AbaFMNOd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 13 Jun 2014 09:14:33 -0400
Content-Disposition: inline
In-Reply-To: <1402657380-18539-1-git-send-email-tomasz.nowicki@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Cc: rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com, bp@alien8.de, m.chehab@samsung.com, bp@suse.de, linux-edac@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org

On 13.06.14 13:02:55, Tomasz Nowicki wrote:
> V2->V3
> - address Robert's comment
> - disable ACPI_APEI_NMI selection so that it is hard selected by arch Kconfig
> - rename ACPI_APEI_NMI to ARCH_HAS_ACPI_APEI_NMI

Btw, it would be easier to wait a bit with reposting a new patch set
until there are no further comments expected for *all* patches (I
didn't have the time to look through all patches yet).

Thanks,

-Robert
