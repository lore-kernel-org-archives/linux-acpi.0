From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4 3/3] acpi, apei, ghes: Factor out ioremap virtual
 memory for IRQ and NMI context.
Date: Wed, 2 Jul 2014 14:17:00 +0200
Message-ID: <20140702121700.GG1318@pd.tnic>
References: <1403610095-5354-1-git-send-email-tomasz.nowicki@linaro.org>
 <1403610095-5354-4-git-send-email-tomasz.nowicki@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1403610095-5354-4-git-send-email-tomasz.nowicki@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Cc: rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com, m.chehab@samsung.com, bp@suse.de, linux-edac@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, rric@kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Jun 24, 2014 at 01:41:35PM +0200, Tomasz Nowicki wrote:
> GHES currently maps two pages with atomic_ioremap.  From now
> on, NMI is architectural depended so there is no need to allocate
> an NMI page for platforms without NMI support.
> 
> To make it possible to not use a second page, swap the existing
> page order so that the IRQ context page is first, and the optional
> NMI context page is second.  Then, use HAVE_ACPI_APEI_NMI to decide
> how many pages are to be allocated.
> 
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
