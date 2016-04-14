From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v6 04/16] x86/rtc: replace paravirt rtc check with
 platform legacy quirk
Date: Thu, 14 Apr 2016 06:28:33 +0200
Message-ID: <570F1C71.9000604@suse.com>
References: <1460592286-300-1-git-send-email-mcgrof@kernel.org>
 <1460592286-300-5-git-send-email-mcgrof@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40968 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753937AbcDNE2j (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 14 Apr 2016 00:28:39 -0400
In-Reply-To: <1460592286-300-5-git-send-email-mcgrof@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@kernel.org>, bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, rusty@rustcorp.com.au
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net, boris.ostrovsky@oracle.com, david.vrabel@citrix.com, konrad.wilk@oracle.com, xen-devel@lists.xensource.com, lguest@lists.ozlabs.org, andriy.shevchenko@linux.intel.com, jlee@suse.com, glin@suse.com, matt@codeblueprint.co.uk, andrew.cooper3@citrix.com, rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, toshi.kani@hp.com, linux-acpi@vger.kernel.org, kozerkov@parallels.com, josh@joshtriplett.org, bigeasy@linutronix.de, ffainelli@freebox.fr, george.dunlap@citrix.com, julien.grall@linaro.org, mbizon@freebox.fr, tiwai@suse.de

On 14/04/16 02:04, Luis R. Rodriguez wrote:
> We have 4 types of x86 platforms that disable RTC:
> 
>   * Intel MID
>   * Lguest - uses paravirt
>   * Xen dom-U - uses paravirt
>   * x86 on legacy systems annotated with an ACPI legacy flag
> 
> We can consolidate all of these into a platform specific legacy
> quirk set early in boot through i386_start_kernel() and through
> x86_64_start_reservations(). This deals with the RTC quirks which
> we can rely on through the hardware subarch, the ACPI check can
> be dealt with separately.
> 
> For Xen things are bit more complex given that the @X86_SUBARCH_XEN
> x86_hardware_subarch is shared on for Xen which uses the PV path for
> both domU and dom0. Since the semantics for differentiating between
> the two are Xen specific we provide a platform helper to help override
> default legacy features -- x86_platform.set_legacy_features(). Use
> of this helper is highly discouraged, its only purpose should be
> to account for the lack of semantics available within your given
> x86_hardware_subarch.
> 
> As per 0-day, this bumps the vmlinux size using i386-tinyconfig as
> follows:
> 
> TOTAL   TEXT   init.text    x86_early_init_platform_quirks()
> +70     +62    +62          +43
> 
> Only 8 bytes overhead total, as the main increase in size is
> all removed via __init.
> 
> v4: split the subarch check from the ACPI check, clarify
>     on the ACPI change commit log why ordering works
> v5: add x86_platform.set_legacy_features() to account for dom0,
>     add also size impact on vmlinux as per 0-day report
> v6: Use __init on xen_dom0_set_legacy_features()
> 
> Suggested-by: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
