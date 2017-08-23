From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 3/5] ghes_edac: add platform check to enable ghes_edac
Date: Wed, 23 Aug 2017 18:20:53 +0200
Message-ID: <20170823162053.4nns6ytekw5fychw@pd.tnic>
References: <20170818194644.14538-1-toshi.kani@hpe.com>
 <20170818194644.14538-4-toshi.kani@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170818194644.14538-4-toshi.kani@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Toshi Kani <toshi.kani@hpe.com>
Cc: rjw@rjwysocki.net, mchehab@kernel.org, tony.luck@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Aug 18, 2017 at 01:46:42PM -0600, Toshi Kani wrote:
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
> "ghes_edac.force_load=1" skips this platform check.
> 
> [1]: https://lwn.net/Articles/538438/
> Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Tony Luck <tony.luck@intel.com>
> ---
>  drivers/edac/ghes_edac.c |   28 +++++++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 5 deletions(-)

Ok, for the remaining three, I've updated my "ghes" branch here:

https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=ghes

Please, redo them ontop.

@Rafael: how do you want to handle this?

The first two are ACPI patches and the remaining three are EDAC. It
would be probably easier if you acked the ACPI ones (but wait until
Toshi's next version) and took them all through the EDAC tree as I have
two more reworking that ghes_edac driver.

Alternatively, they could all go through the ACPI tree but you'll have
to pick them all up together. That shouldn't be a problem either as all
changes are solely to drivers/edac/ghes_edac.c and there's one other
patch in my EDAC pile which touches ghes_edac.c:

https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/diff/drivers/edac/ghes_edac.c?h=for-next&id=c54182ec0e157988f0cafd1e8d37b68ab4210f87

That's why I say, it'll be easier if I carried them all. :)

But I'm sure we can work something out.

Thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
