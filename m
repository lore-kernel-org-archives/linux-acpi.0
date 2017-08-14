From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 4/7] ghes_edac: avoid multiple calls to dmi_walk()
Date: Mon, 14 Aug 2017 18:24:36 +0200
Message-ID: <20170814162436.lta5xm742hh6g7yk@pd.tnic>
References: <20170803215753.30553-1-toshi.kani@hpe.com>
 <20170803215753.30553-5-toshi.kani@hpe.com>
 <20170804040525.GE12082@nazgul.tnic>
 <1501879964.2042.117.camel@hpe.com>
 <20170805051615.GC23214@nazgul.tnic>
 <1502128177.2042.131.camel@hpe.com>
 <20170811090414.GB9432@nazgul.tnic>
 <1502725671.2042.137.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1502725671.2042.137.camel@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Aug 14, 2017 at 03:57:35PM +0000, Kani, Toshimitsu wrote:
> Hmm... Sorry, I failed to see how your patchset solved it.  Would you
> mind to explain how it is done?

+static int __init ghes_edac_register(void)
 {
+       struct ghes_edac_pvt *pvt = ghes_pvt;

Only one local ghes_pvt structure.

And you handle multiple calls into ghes_edac_register() by exiting all
those which are not the first one as the first one already did all the
init.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
