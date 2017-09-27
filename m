From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH] ACPI/APEI: adjust a local variable type in
 ghes_ioremap_pfn_irq()
Date: Wed, 27 Sep 2017 19:54:05 +0200
Message-ID: <20170927175405.x5ccou5d6rrevyvd@pd.tnic>
References: <59C8D51B020000780017F3B9@prv-mh.provo.novell.com>
 <59C8D51B020000780017F3B9@prv-mh.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43321 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751985AbdI0RyS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 27 Sep 2017 13:54:18 -0400
Content-Disposition: inline
In-Reply-To: <59C8D51B020000780017F3B9@prv-mh.provo.novell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jan Beulich <JBeulich@suse.com>
Cc: Len Brown <lenb@kernel.org>, rjw@rjwysocki.net, tony.luck@intel.com, linux-acpi@vger.kernel.org

On Mon, Sep 25, 2017 at 02:06:19AM -0600, Jan Beulich wrote:
> Match up with what 7edda0886b ("acpi: apei: handle SEA notification
> type for ARMv8") did for ghes_ioremap_pfn_nmi().
> 
> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> ---
>  drivers/acpi/apei/ghes.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
