From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 1/5] ACPI / blacklist: add acpi_match_platform_list()
Date: Mon, 21 Aug 2017 19:36:12 +0200
Message-ID: <20170821173612.i3zxlmxklmvv5kzd@pd.tnic>
References: <20170818194644.14538-1-toshi.kani@hpe.com>
 <20170818194644.14538-2-toshi.kani@hpe.com>
 <20170821112657.hrtjoeagxhc67rrr@pd.tnic>
 <1503333107.2042.163.camel@hpe.com>
 <20170821170415.kttnqiwj2fkntsc7@pd.tnic>
 <1503335626.2042.165.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:40964 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753726AbdHURgW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 21 Aug 2017 13:36:22 -0400
Content-Disposition: inline
In-Reply-To: <1503335626.2042.165.camel@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, Aug 21, 2017 at 05:23:37PM +0000, Kani, Toshimitsu wrote:
> > > 'data' here is private to the caller.  So, I do not think we need
> > > to define the bits.  Shall I change the name to 'driver_data' to
> > > make it more explicit?
> > 
> > You changed it to 'data'. It was a u32-used-as-boolean
> > is_critical_error before.
> > 
> > So you can just as well make it into flags and people can extend
> > those flags if needed. A flag bit should be enough in most cases
> > anyway. If they really need driver_data, then they can add a void *
> > member.
> 
> Hmm.. In patch 2, intel_pstate_platform_pwr_mgmt_exists() uses this
> field for PSS and PCC, which are enum values.  I think we should allow
> drivers to set any values here.  I agree that it may need to be void *
> if we also allow drivers to set a pointer here.

Let's see what Rafael prefers.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
