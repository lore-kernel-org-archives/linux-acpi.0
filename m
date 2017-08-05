From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 6/7] EDAC: add edac_check_mc_owner() to check MC owner
Date: Sat, 5 Aug 2017 07:44:51 +0200
Message-ID: <20170805054451.GE23214@nazgul.tnic>
References: <20170803215753.30553-1-toshi.kani@hpe.com>
 <20170803215753.30553-7-toshi.kani@hpe.com>
 <20170804083007.GA15617@nazgul.tnic>
 <1501881932.2042.121.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:34180 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751189AbdHEFpc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 5 Aug 2017 01:45:32 -0400
Content-Disposition: inline
In-Reply-To: <1501881932.2042.121.camel@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, Aug 04, 2017 at 09:35:05PM +0000, Kani, Toshimitsu wrote:
> 1 means the caller's init function can continue its initialization --
> such conditions are free or owned by itself.

Make that:

	edac_get_owner(void)

to return the owner string or NULL if there's no owner.

The caller can then do the string checking and do strncmp() to limit the
string length being checked.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
