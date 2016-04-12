From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v5 04/14] x86/rtc: replace paravirt rtc check with
 platform legacy quirk
Date: Tue, 12 Apr 2016 22:56:49 +0200
Message-ID: <20160412205649.GK1990@wotan.suse.de>
References: <1460158825-13117-1-git-send-email-mcgrof@kernel.org>
 <1460158825-13117-5-git-send-email-mcgrof@kernel.org>
 <570BAB84.903@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <570BAB84.903@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, rusty@rustcorp.com.au, x86@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net, david.vrabel@citrix.com, konrad.wilk@oracle.com, xen-devel@lists.xensource.com, lguest@lists.ozlabs.org, andriy.shevchenko@linux.intel.com, jlee@suse.com, glin@suse.com, matt@codeblueprint.co.uk, andrew.cooper3@citrix.com, rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, toshi.kani@hp.com, linux-acpi@vger.kernel.org, kozerkov@parallels.com, josh@joshtriplett.org, joro@8bytes.org, tiwai@suse.de
List-Id: linux-acpi@vger.kernel.org

On Mon, Apr 11, 2016 at 09:49:56AM -0400, Boris Ostrovsky wrote:
> On 04/08/2016 07:40 PM, Luis R. Rodriguez wrote:
> 
> diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
> index 1ae89a2721d6..8bb8c1a4615a 100644
> --- a/arch/x86/include/asm/x86_init.h
> +++ b/arch/x86/include/asm/x86_init.h
> @@ -142,6 +142,15 @@ struct x86_cpuinit_ops {
>  struct timespec;
>  /**
> + * struct x86_legacy_features - legacy x86 features
> + *
> + * @rtc: this device has a CMOS real-time clock present
> + */
> +struct x86_legacy_features {
> +	int rtc;
> +};
> +
> +/**
>   * struct x86_platform_ops - platform specific runtime functions
>   * @calibrate_tsc:		calibrate TSC
>   * @get_wallclock:		get time from HW clock like RTC etc.
> @@ -152,6 +161,14 @@ struct timespec;
>   * @save_sched_clock_state:	save state for sched_clock() on suspend
>   * @restore_sched_clock_state:	restore state for sched_clock() on resume
>   * @apic_post_init:		adjust apic if neeeded
> + * @legacy:			legacy features
> + * @set_legacy_features:	override legacy features. Use of this callback
> + * 				is highly discouraged. You should only need
> + * 				this if your hardware platform requires further
> + * 				custom fine tuning far beyong what may be
> + * 				possible in x86_early_init_platform_quirks() by
> + * 				only using the current x86_hardware_subarch
> + * 				semantics.
>   */
>  struct x86_platform_ops {
>  	unsigned long (*calibrate_tsc)(void);
> @@ -165,6 +182,8 @@ struct x86_platform_ops {
>  	void (*save_sched_clock_state)(void);
>  	void (*restore_sched_clock_state)(void);
>  	void (*apic_post_init)(void);
> +	struct x86_legacy_features legacy;
> 
> 
> I don't think this belongs here --- we are in the ops structure.

Bike shed thing -- I went with what Ingo suggested [0], which was to
embed things under x86_platform, and that happens to be this struct.

So unless I hear otherwise from the maintainer I'm sticking with it.

http://lkml.kernel.org/r/20160224083259.GA20579@gmail.com

  Luis
