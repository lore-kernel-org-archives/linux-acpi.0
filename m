From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 3/7] ACPI / APEI: add OSC APEI bit check for ghes_edac
Date: Sat, 5 Aug 2017 07:14:34 +0200
Message-ID: <20170805051434.GB23214@nazgul.tnic>
References: <20170803215753.30553-1-toshi.kani@hpe.com>
 <20170803215753.30553-4-toshi.kani@hpe.com>
 <20170804034417.GC12082@nazgul.tnic>
 <1501879218.2042.115.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:33442 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751183AbdHEFPO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 5 Aug 2017 01:15:14 -0400
Content-Disposition: inline
In-Reply-To: <1501879218.2042.115.camel@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, Aug 04, 2017 at 08:49:51PM +0000, Kani, Toshimitsu wrote:
> Some firmware features can be enabled / disabled in BIOS.  While HPE
> firmware does not allow to disable FF, it's possible that other vendors
> might allow such and still have the same OEM ID info.

Yeah, we don't protect ourselves against "might allow". Either you have
an *actual* example for such platform or you don't and then you don't
need this check.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
