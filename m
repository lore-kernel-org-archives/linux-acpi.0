From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Thu, 20 Jul 2017 19:05:04 +0200
Message-ID: <20170720170504.GA23149@nazgul.tnic>
References: <20170718080836.GB8372@nazgul.tnic>
 <1500412288.2042.25.camel@hpe.com>
 <20170719055235.GD26030@nazgul.tnic>
 <1500480051.2042.27.camel@hpe.com>
 <20170719162204.GE16124@nazgul.tnic>
 <1500482822.2042.31.camel@hpe.com>
 <20170720041645.GA14367@nazgul.tnic>
 <1500561189.2042.35.camel@hpe.com>
 <20170720150409.GB20712@nazgul.tnic>
 <3908561D78D1C84285E8C5FCA982C28F6130F211@ORSMSX114.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:54222 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965333AbdGTRFO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 20 Jul 2017 13:05:14 -0400
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F6130F211@ORSMSX114.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Kani, Toshimitsu" <toshi.kani@hpe.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>

On Thu, Jul 20, 2017 at 04:55:59PM +0000, Luck, Tony wrote:
> Add a module parameter to those edac drivers that can override the check
> and let them load anyway.  I'm not paranoid, I just assume that there is a BIOS
> out there that sets the OSC/WHEA bits, but isn't generating useful GHES logs.

Or add that parameter to edac_core.ko and let it control which EDAC
driver gets loaded? Something like

edac=ignore_ghes

or so. And then the other EDAC drivers query it.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
