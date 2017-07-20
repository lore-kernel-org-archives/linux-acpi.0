From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH 0/1] acpi: apei: Enable APEI multiple GHES source to
 share an single external IRQ
Date: Thu, 20 Jul 2017 06:49:36 +0200
Message-ID: <20170720044936.GA14552@nazgul.tnic>
References: <20170719172427.5478-1-msalter@redhat.com>
 <CAJZ5v0hdtDEgNXMmD-3oKqHn8vSFx=wfTgN+as1AO=jiQ_BKzQ@mail.gmail.com>
 <1500494721.14060.11.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1500494721.14060.11.camel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Salter <msalter@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Tyler Baicar <tbaicar@codeaurora.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jul 19, 2017 at 04:05:21PM -0400, Mark Salter wrote:
> Yes, I should have included Boris. The last time this came up, Boris
> said it was up to you. :)
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/401772.html

/me goes back and reads the old emails.

So I had some issues with how acpi_gsi_to_irq() returns the irq number
but that required more involved simplification and the submitter was
unsurprisingly reluctant to do it.

That's why it was Rafael's call.

AFAIR.

Also, from looking at the patches, the SOB chain is wrong:

Signed-off-by: Tuan Phan <tphan@apm.com>
Signed-off-by: Loc Ho <lho@apm.com>

I don't know from that who's the author and who's the submitter.
SubmittingPatches has more info on the whole deal.

So please resubmit updated versions with issues addressed.

Thanks.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
