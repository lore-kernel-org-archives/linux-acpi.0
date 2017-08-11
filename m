From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 4/7] ghes_edac: avoid multiple calls to dmi_walk()
Date: Fri, 11 Aug 2017 11:04:14 +0200
Message-ID: <20170811090414.GB9432@nazgul.tnic>
References: <20170803215753.30553-1-toshi.kani@hpe.com>
 <20170803215753.30553-5-toshi.kani@hpe.com>
 <20170804040525.GE12082@nazgul.tnic>
 <1501879964.2042.117.camel@hpe.com>
 <20170805051615.GC23214@nazgul.tnic>
 <1502128177.2042.131.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1502128177.2042.131.camel@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>
List-Id: linux-acpi@vger.kernel.org

On Mon, Aug 07, 2017 at 05:59:15PM +0000, Kani, Toshimitsu wrote:
> I think we should keep the current scheme, which registers an mci for

No we shouldn't.

> each GHES entry.  ghes_edac_report_mem_error() expects that error-
> reporting is serialized per a GHES entry.  Sharing a single mci among
> all GHES entries / error interfaces might lead to a race condition.

See how I solved it in my patchset and feel free to reuse it.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
