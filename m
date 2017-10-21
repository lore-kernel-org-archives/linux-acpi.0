From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v7] acpi: apei: remove the unused dead-code for SEA/NMI
 notification type
Date: Sat, 21 Oct 2017 14:15:11 +0200
Message-ID: <20171021121511.mr2u7etyfj5t2xra@pd.tnic>
References: <20171021103503.23598-1-gengdongjiu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44154 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932067AbdJUMPY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 21 Oct 2017 08:15:24 -0400
Content-Disposition: inline
In-Reply-To: <20171021103503.23598-1-gengdongjiu@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: rjw@rjwysocki.net, lenb@kernel.org, tbaicar@codeaurora.org, will.deacon@arm.com, prarit@redhat.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Oct 21, 2017 at 06:35:03PM +0800, Dongjiu Geng wrote:
> For the SEA notification, the two functions ghes_sea_add() and
> ghes_sea_remove() are only called when CONFIG_ACPI_APEI_SEA
> is defined. If not, it will return errors in the ghes_probe()
> and not continue. If the probe is failed, the ghes_sea_remove()
> also has no chance to be called. Hence, remove the unnecessary
> handling when CONFIG_ACPI_APEI_SEA is not defined.
> 
> For the NMI notification, it has the same issue as SEA notification,
> so also remove the unused dead-code for it.
> 
> Cc: Tyler Baicar <tbaicar@codeaurora.org>
> Cc: James Morse <james.morse@arm.com>
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> Tested-by: Tyler Baicar <tbaicar@codeaurora.org>
> Signed-off-by: Borislav Petkov <bp@suse.de>

I gave you Reviewed-by, not Signed-off-by.

Before you send more patches, read this:

Documentation/process/submitting-patches.rst

You can read the whole document but do especially concentrate on
sections 11-13, in order to get an idea how the SOB chain and all that
patch tagging works.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
