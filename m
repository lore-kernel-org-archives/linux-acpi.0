From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Fri, 21 Jul 2017 15:34:41 +0200
Message-ID: <20170721133441.GB5036@nazgul.tnic>
References: <20170717215912.26070-1-toshi.kani@hpe.com>
 <20170717215912.26070-4-toshi.kani@hpe.com>
 <20170718060007.GB8736@nazgul.tnic>
 <1500407379.2042.21.camel@hpe.com>
 <20170718181545.32bd9181@vento.lan>
 <1500481869.2042.29.camel@hpe.com>
 <20170720043344.GC14367@nazgul.tnic>
 <1500579646.2042.37.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:33464 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750762AbdGUNer (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 21 Jul 2017 09:34:47 -0400
Content-Disposition: inline
In-Reply-To: <1500579646.2042.37.camel@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mchehab@s-opensource.com" <mchehab@s-opensource.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>

On Thu, Jul 20, 2017 at 07:50:03PM +0000, Kani, Toshimitsu wrote:
> GHES / firmware-first still requires OS recovery actions when an error
> cannot be corrected by the platform.  They are handled by ghes_proc(),
> and ghes_edac remains its error-reporting wrapper.

I mean all the recovery actions the firmware does because it gets to see
the error first. Otherwise, Firmware First is the the dumbest repeater
layer in the history of layers.

> Firmware has better knowledge about the platform and can provide better
> RAS when implemented properly.

s/when/if/

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
