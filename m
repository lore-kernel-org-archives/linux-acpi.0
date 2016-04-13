From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v5 01/14] x86/boot: enumerate documentation for the x86
 hardware_subarch
Date: Wed, 13 Apr 2016 10:01:32 +0200
Message-ID: <20160413080132.GA9697@gmail.com>
References: <1460158825-13117-1-git-send-email-mcgrof@kernel.org>
 <1460158825-13117-2-git-send-email-mcgrof@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35138 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbcDMIBi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Apr 2016 04:01:38 -0400
Content-Disposition: inline
In-Reply-To: <1460158825-13117-2-git-send-email-mcgrof@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, rusty@rustcorp.com.au, x86@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net, boris.ostrovsky@oracle.com, david.vrabel@citrix.com, konrad.wilk@oracle.com, xen-devel@lists.xensource.com, lguest@lists.ozlabs.org, andriy.shevchenko@linux.intel.com, jlee@suse.com, glin@suse.com, matt@codeblueprint.co.uk, andrew.cooper3@citrix.com, rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, toshi.kani@hp.com, linux-acpi@vger.kernel.org, kozerkov@parallels.com, josh@joshtriplett.org, joro@8bytes.org, tiwai@suse.de


* Luis R. Rodriguez <mcgrof@kernel.org> wrote:

> Although hardware_subarch has been in place since the x86 boot
> protocol 2.07 it hasn't been used much. Enumerate current possible
> values to avoid misuses and help with semantics later at boot
> time should this be used further.
> 
> These enums should only ever be used by architecture x86 code,
> and all that code should be well contained and compartamentalized,
> clarify that as well.
> 
> v2: updates documentation further -- be a bit more pedantic about
>     annotating care and use of these guys.
> v3: Use s/SOC/SoC and also anntoate that both domU and dom0 are
>     both currently supported through the PV boot path.
> 
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> ---
>  arch/x86/include/uapi/asm/bootparam.h | 37 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
> index 329254373479..bf9fea2f4591 100644
> --- a/arch/x86/include/uapi/asm/bootparam.h
> +++ b/arch/x86/include/uapi/asm/bootparam.h
> @@ -157,7 +157,42 @@ struct boot_params {
>  	__u8  _pad9[276];				/* 0xeec */
>  } __attribute__((packed));
>  
> -enum {
> +/**
> + * enum x86_hardware_subarch - x86 hardware subarchitecture

Could you add some prominent warning here, like:

> + * WARNING: the 'x86 subarch flag' is only used for legacy hacks, for platform
> + *          features that are not easily enumerated or discoverable. You should
> + *          not ever use this for new features.

Thanks,

	Ingo
