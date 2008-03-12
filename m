From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/3] acer-wmi patches for 2.6.25-rc5
Date: Wed, 12 Mar 2008 16:25:56 -0400
Message-ID: <200803121625.56814.lenb@kernel.org>
References: <20080312201238.2071.31534.stgit@pacifica>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58169 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751780AbYCLU0S (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Mar 2008 16:26:18 -0400
In-Reply-To: <20080312201238.2071.31534.stgit@pacifica>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-acpi@vger.kernel.org

On Wednesday 12 March 2008, Carlos Corbacho wrote:
> Len,
> 
> The following patchset is some minor cleanups and an extra DMI quirk for
> 2.6.25-rc5.
> 
> If you're not happy with applying patch #3 now, it can always wait until 2.6.26

i think a DMI entry for a hook in a brand-new driver is fine.

1,2,3 applied.

thanks,
-Lenn

> -Carlos
> ---
> 
> Carlos Corbacho (3):
>       acer-wmi: Add mail LED support for Acer Aspire 3610/ 5610
>       acer-wmi: Fix DSDT path in documentation
>       acer-wmi: Make device detection error messages more descriptive
> 
> 
>  Documentation/laptops/acer-wmi.txt |    2 +-
>  drivers/misc/acer-wmi.c            |   30 +++++++++++++++++++++++++-----
>  2 files changed, 26 insertions(+), 6 deletions(-)
> 
> 


