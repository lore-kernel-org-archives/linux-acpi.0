From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 5/7] ghes_edac: add platform check to enable ghes_edac
Date: Sat, 5 Aug 2017 07:37:50 +0200
Message-ID: <20170805053750.GD23214@nazgul.tnic>
References: <20170803215753.30553-1-toshi.kani@hpe.com>
 <20170803215753.30553-6-toshi.kani@hpe.com>
 <20170804083137.GB15617@nazgul.tnic>
 <1501880213.2042.119.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:34028 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751184AbdHEFim (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 5 Aug 2017 01:38:42 -0400
Content-Disposition: inline
In-Reply-To: <1501880213.2042.119.camel@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, Aug 04, 2017 at 09:06:27PM +0000, Kani, Toshimitsu wrote:
> How about "ghes_edac.any_platform"?

ghes_edac.force_load

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
