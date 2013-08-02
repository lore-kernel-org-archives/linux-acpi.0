From: Borislav Petkov <bp@alien8.de>
Subject: Re: i915 backlight
Date: Fri, 2 Aug 2013 10:34:24 +0200
Message-ID: <20130802083424.GB11566@pd.tnic>
References: <20130731162252.GC4724@pd.tnic>
 <20130731163623.GD4724@pd.tnic>
 <51F9B63F.7060509@intel.com>
 <20130801081215.GB3448@nazgul.tnic>
 <51FA2537.5040208@intel.com>
 <51FB0853.9090105@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51FB0853.9090105@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Jani Nikula <jani.nikula@intel.com>, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, lkml <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Aug 02, 2013 at 09:16:03AM +0800, Aaron Lu wrote:
> Since the sysfs interface works on your system, I think your problem
> should be different. Can you please file a bug for this? I can provide
> you with a debug patch and then see what happened. Please attach
> acpidump when filing the bug.
>
> https://bugzilla.kernel.org, ACPI/Power-Video.

Done: https://bugzilla.kernel.org/show_bug.cgi?id=60680

I did acpidump by hand but it should be ok.

Thanks for looking into this Aaron! :)

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
