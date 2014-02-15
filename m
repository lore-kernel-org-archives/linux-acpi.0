From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH] ACPI, APEI: Remove X86 redundant dependency for APEI
 Generic Hardware Error Source.
Date: Sat, 15 Feb 2014 07:06:16 +0100
Message-ID: <20140215060615.GA10430@pd.tnic>
References: <1392049416-31240-1-git-send-email-tomasz.nowicki@linaro.org>
 <1611441.dxrnOY2zmW@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1611441.dxrnOY2zmW@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Tomasz Nowicki <tomasz.nowicki@linaro.org>, "Luck, Tony" <tony.luck@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Feb 15, 2014 at 01:57:48AM +0100, Rafael J. Wysocki wrote:
> On Monday, February 10, 2014 05:23:36 PM Tomasz Nowicki wrote:
> > ACPI_APEI is already dependent on X86, hence, there is no need to
> > define such dependency for ACPI_APEI_GHES again.
> > 
> > Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> 
> Tony, Boris, if you're fine with this, I'll take it for 3.15.

Acked-by: Borislav Petkov <bp@suse.de>

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
