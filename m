From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH 4/4] EDAC, skx_edac: Detect non-volatile DIMMs
Date: Tue, 5 Dec 2017 22:44:41 +0100
Message-ID: <20171205214441.pfxusrz5lpew5kre@pd.tnic>
References: <cover.1512070562.git.tony.luck@intel.com>
 <da4c989314e82ec29195804ba5349ac3136f74c0.1512070562.git.tony.luck@intel.com>
 <20171205105451.ob23asixm726hysb@pd.tnic>
 <20171205200336.tbx7oypjuca3g6vn@agluck-desk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:56036 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751453AbdLEVow (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 5 Dec 2017 16:44:52 -0500
Content-Disposition: inline
In-Reply-To: <20171205200336.tbx7oypjuca3g6vn@agluck-desk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-edac@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Jean Delvare <jdelvare@suse.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, Lv Zheng <lv.zheng@intel.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Aristeu Rozanski <aris@redhat.com>

On Tue, Dec 05, 2017 at 12:03:37PM -0800, Luck, Tony wrote:
> I could. But what happens when someone ends up on a system with
> an edac driver configured without ACPI_NFIT that does have NVDIMMs?

Same thing when you land on a system with a kernel where the driver for
a piece of hw is not enabled. I mean, this won't be an issue on distros
as there *everything* is enabled but for tailored configs, where people
want skx_edac but don't need the nvdimm part.

> I can make a stub version of nfit_get_smbios_id() that returns some
> error code ... and have the EDAC driver report size==0.
> 
> Would that be OK?

Sure, thanks!

> /me finds that the "Enter" key on his keyboard will put in a newline.
> Hurrah! now I don't have to copy/paste them from Boris.

Cheers! :-)))

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
