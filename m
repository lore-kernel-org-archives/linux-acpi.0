From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 5/7] ghes_edac: add platform check to enable ghes_edac
Date: Fri, 4 Aug 2017 10:31:37 +0200
Message-ID: <20170804083137.GB15617@nazgul.tnic>
References: <20170803215753.30553-1-toshi.kani@hpe.com>
 <20170803215753.30553-6-toshi.kani@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170803215753.30553-6-toshi.kani@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Toshi Kani <toshi.kani@hpe.com>
Cc: rjw@rjwysocki.net, mchehab@kernel.org, tony.luck@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Aug 03, 2017 at 03:57:51PM -0600, Toshi Kani wrote:
> The ghes_edac driver was introduced in 2013 [1], but it has not
> been enabled by any distro yet.  This driver obtains error info
> from firmware interfaces, which are not properly implemented on
> many platforms, as the driver always emits the messages below:
> 
>  This EDAC driver relies on BIOS to enumerate memory and get error reports.
>  Unfortunately, not all BIOSes reflect the memory layout correctly
>  So, the end result of using this driver varies from vendor to vendor
>  If you find incorrect reports, please contact your hardware vendor
>  to correct its BIOS.
> 
> To get out from this situation, add a platform check to selectively
> enable the driver on the platforms that are known to have proper
> firmware implementation.  Platform vendors can add their platforms
> to the list when they support ghes_edac.
> 
> "ghes_edac.any_oem=1" skips this platform check.

There's that non-generic OEM thing again. NAK!

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
