From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 4/7] ghes_edac: avoid multiple calls to dmi_walk()
Date: Mon, 14 Aug 2017 20:35:51 +0200
Message-ID: <20170814183551.sgk2i7lxpmpyodhv@pd.tnic>
References: <20170805051615.GC23214@nazgul.tnic>
 <1502128177.2042.131.camel@hpe.com>
 <20170811090414.GB9432@nazgul.tnic>
 <1502725671.2042.137.camel@hpe.com>
 <20170814162436.lta5xm742hh6g7yk@pd.tnic>
 <1502728754.2042.139.camel@hpe.com>
 <20170814170552.j3lhzvnwlpz75y4g@pd.tnic>
 <1502732561.2042.141.camel@hpe.com>
 <20170814180526.wtfjzgc6uye2qtx6@pd.tnic>
 <1502734083.2042.143.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:45870 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750859AbdHNSgA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 14 Aug 2017 14:36:00 -0400
Content-Disposition: inline
In-Reply-To: <1502734083.2042.143.camel@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>

On Mon, Aug 14, 2017 at 06:17:47PM +0000, Kani, Toshimitsu wrote:
> Right, ghes_edac_report_mem_error() gets serialized per a GHES entry,
> but not globally.

Globally what?

What is the actual potential scenario for concurrency issues you see?
Example pls.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
