From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 2/5] eeepc-wmi: Use acpi_dev_present
Date: Mon, 23 Nov 2015 20:55:27 +0100
Message-ID: <20151123195527.GA26288@wunner.de>
References: <cover.1448282995.git.lukas@wunner.de>
 <bdff67293ead344ccec77f55437085561b1ad88d.1448282995.git.lukas@wunner.de>
 <20151123190413.GU7413@malice.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151123190413.GU7413@malice.jf.intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, devel@acpica.org, platform-driver-x86@vger.kernel.org, Corentin Chary <corentin.chary@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Darren,

On Mon, Nov 23, 2015 at 11:04:13AM -0800, Darren Hart wrote:
> On Mon, Nov 23, 2015 at 03:34:55PM +0100, Lukas Wunner wrote:
> > Use shiny new acpi_dev_present and remove all the boilerplate to search
> > for a particular ACPI device. No functional change.
> 
> You did add a pr_warn, which is technically a functional change. Did you intend
> to leave that in?

That's not an addition of mine, I moved it from eeepc_wmi_parse_device()
to eeepc_wmi_probe() so that everything behaves exactly as before.
(See the deleted lines further up in the patch.)


> Rafael, I assume you will pick this up along with the acpi_dev_present ACPI
> change if you take that. Pleaes let me know if not.

The last patch in the series concerned Intel ASoC (sound/soc/intel/)
and the maintainer Mark Brown <broonie@kernel.org> has replied that
"This will collide with some other work done on the Intel code in -next I
expect, probably best to merge this via ASoC (so pulling a shared branch
for the new API) or just wait till 4.5 to do the conversion."
[full quote of his message as it wasn't cc: platform-driver-x86]

So I guess Mark might pull it in, haven't heard back from the ACPI
maintainers yet.


> Otherwise,
> Acked-by: Darren Hart <dvhart@linux.intel.com>

Awesome, thanks!

Best regards,

Lukas
