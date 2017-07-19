From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Wed, 19 Jul 2017 08:01:00 +0200
Message-ID: <20170719060059.GG26030@nazgul.tnic>
References: <20170717215912.26070-1-toshi.kani@hpe.com>
 <20170717215912.26070-4-toshi.kani@hpe.com>
 <20170718060007.GB8736@nazgul.tnic>
 <3908561D78D1C84285E8C5FCA982C28F6130C6B8@ORSMSX114.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:33774 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751832AbdGSGBG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 19 Jul 2017 02:01:06 -0400
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F6130C6B8@ORSMSX114.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Toshi Kani <toshi.kani@hpe.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "mchehab@kernel.org" <mchehab@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Jul 18, 2017 at 10:13:42PM +0000, Luck, Tony wrote:
> Historically we've had complaints that sb_edac won't load that have been
> tracked to BIOS hiding one of the (many) PCI devices that it needs.  But
> device hiding is orthogonal to providing GHES error records.  A BIOS might
> do that, but I don't know that anyone intentionally does so.

Yeah, the hiding-devices path doesn't look like the optimal one. I think we
should look at the firmware-first setting and load ghes if FF is being done by
the firmware.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
