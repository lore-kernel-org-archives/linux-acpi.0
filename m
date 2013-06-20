From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 2/2] mce: acpi/apei: Add a boot option to disable ff
 mode for corrected errors
Date: Thu, 20 Jun 2013 09:48:24 +0200
Message-ID: <20130620074824.GF32694@pd.tnic>
References: <20130619175438.2852.93449.stgit@localhost.localdomain>
 <20130619175728.2852.73156.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130619175728.2852.73156.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: tony.luck@intel.com, ananth@in.ibm.com, masbock@linux.vnet.ibm.com, lcm@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, ying.huang@intel.com
List-Id: linux-acpi@vger.kernel.org

On Wed, Jun 19, 2013 at 11:27:42PM +0530, Naveen N. Rao wrote:
> Add a boot option to disable firmware first mode for corrected errors.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  Documentation/x86/x86_64/boot-options.txt |    5 +++++
>  arch/x86/include/asm/acpi.h               |    2 ++
>  arch/x86/kernel/acpi/boot.c               |    5 +++++
>  drivers/acpi/apei/hest.c                  |    3 ++-
>  4 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/x86/x86_64/boot-options.txt b/Documentation/x86/x86_64/boot-options.txt
> index e9e8ddb..1228b22 100644
> --- a/Documentation/x86/x86_64/boot-options.txt
> +++ b/Documentation/x86/x86_64/boot-options.txt
> @@ -176,6 +176,11 @@ ACPI
>  
>    acpi=noirq	Don't route interrupts
>  
> +  acpi=nocmcff	Disable firmware first mode for corrected errors. This
> +		disables parsing the HEST CMC error source to check if
> +		firmware has set the FF flag. This may result in
> +		duplicate corrected error reports.

Ok, this option should be called something more vendor-agnostic like

acpi=noff

for example.

CMCI is Intel-specific and Firmware First is a generic way to say that
firmware would like to look at the errors first.

AMD has similar thing called error thresholding so...

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
