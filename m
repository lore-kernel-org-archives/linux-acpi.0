From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Fri, 21 Jul 2017 15:47:15 +0200
Message-ID: <20170721134715.GC5036@nazgul.tnic>
References: <20170717215912.26070-1-toshi.kani@hpe.com>
 <20170717215912.26070-4-toshi.kani@hpe.com>
 <20170718060007.GB8736@nazgul.tnic>
 <1500407379.2042.21.camel@hpe.com>
 <20170718181545.32bd9181@vento.lan>
 <1500481869.2042.29.camel@hpe.com>
 <20170720043344.GC14367@nazgul.tnic>
 <1500579646.2042.37.camel@hpe.com>
 <20170721133441.GB5036@nazgul.tnic>
 <20170721104001.3cd2b884@vento.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:33978 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751760AbdGUNrZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 21 Jul 2017 09:47:25 -0400
Content-Disposition: inline
In-Reply-To: <20170721104001.3cd2b884@vento.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: "Kani, Toshimitsu" <toshi.kani@hpe.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>

On Fri, Jul 21, 2017 at 10:40:01AM -0300, Mauro Carvalho Chehab wrote:
> What happens when the error can be corrected? Does it still report it to
> userspace, or just silently hide the error?
> 
> If I remember well about a past discussion with some vendor, I was told
> that the firmware can hide some errors from being reported. Is it
> still the case?

I've heard the same thing but I have no idea what they're actually
doing. But it would make sense because the intention is not to worry
users unnecessarily if it can hide the error and if there are no adverse
consequences from it.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
