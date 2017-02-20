From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH -v2] ACPI, APEI: Fix BERT resources conflict with ACPI
 NVS area
Date: Mon, 20 Feb 2017 10:44:19 +0100
Message-ID: <20170220094419.j6effubsn7qct55q@pd.tnic>
References: <20170220011343.6736-1-ying.huang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52716 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751072AbdBTJop (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 20 Feb 2017 04:44:45 -0500
Content-Disposition: inline
In-Reply-To: <20170220011343.6736-1-ying.huang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Huang, Ying" <ying.huang@intel.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Feb 20, 2017 at 09:12:58AM +0800, Huang, Ying wrote:
> From: Huang Ying <ying.huang@intel.com>
> 
> It was reported that on some machines, there is overlap between ACPI
> NVS area and BERT address range.  This appears reasonable because BERT
> contents need to be non-volatile across reboot.  But this will cause
> resources conflict in current Linux kernel implementation because the
> ACPI NVS area is marked as busy.  The resource conflict is fixed via
> excluding the ACPI NVS area when requesting IO resources for BERT.
> When accessing the BERT contents, the whole BERT address range will be
> ioremapped and accessed.
> 
> Reported-and-tested-by: Hans Kristian Rosbach <hansr@raskesider.no>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> ---
>  drivers/acpi/apei/bert.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
