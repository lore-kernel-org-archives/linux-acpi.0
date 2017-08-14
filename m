From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 4/7] ghes_edac: avoid multiple calls to dmi_walk()
Date: Mon, 14 Aug 2017 19:05:52 +0200
Message-ID: <20170814170552.j3lhzvnwlpz75y4g@pd.tnic>
References: <20170803215753.30553-1-toshi.kani@hpe.com>
 <20170803215753.30553-5-toshi.kani@hpe.com>
 <20170804040525.GE12082@nazgul.tnic>
 <1501879964.2042.117.camel@hpe.com>
 <20170805051615.GC23214@nazgul.tnic>
 <1502128177.2042.131.camel@hpe.com>
 <20170811090414.GB9432@nazgul.tnic>
 <1502725671.2042.137.camel@hpe.com>
 <20170814162436.lta5xm742hh6g7yk@pd.tnic>
 <1502728754.2042.139.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:42764 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751445AbdHNRGB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 14 Aug 2017 13:06:01 -0400
Content-Disposition: inline
In-Reply-To: <1502728754.2042.139.camel@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, Aug 14, 2017 at 04:48:57PM +0000, Kani, Toshimitsu wrote:
> Right, but the issue is how [ghes_edac_]report_mem_error() protects
> from possible concurrent calls from multiple GHES sources when there is
> only a single mci.

Do you know of an actual firmware reporting multiple errors concurrently?

GHES v2 even needs to ACK the current error first before it can read the
next one.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
