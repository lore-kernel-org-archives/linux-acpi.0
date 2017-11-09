From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH 1/2] acpi: apei: handle PCIe AER errors in separate
 function
Date: Thu, 9 Nov 2017 18:21:24 +0100
Message-ID: <20171109172124.hq5wigcv5zfz56ag@pd.tnic>
References: <1510168392-30114-1-git-send-email-tbaicar@codeaurora.org>
 <1510168392-30114-2-git-send-email-tbaicar@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59665 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751066AbdKIRV3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 9 Nov 2017 12:21:29 -0500
Content-Disposition: inline
In-Reply-To: <1510168392-30114-2-git-send-email-tbaicar@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tyler Baicar <tbaicar@codeaurora.org>
Cc: rjw@rjwysocki.net, tony.luck@intel.com, will.deacon@arm.com, james.morse@arm.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Nov 08, 2017 at 12:13:11PM -0700, Tyler Baicar wrote:
> Move PCIe AER error handling code into a separate function.
> 
> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
> ---
>  drivers/acpi/apei/ghes.c | 64 +++++++++++++++++++++++++-----------------------
>  1 file changed, 34 insertions(+), 30 deletions(-)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
