From: Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph@boehmwalder.at>
Subject: Re: [PATCH v2] thinkad_acpi: Support the battery wear control
Date: Tue, 5 Dec 2017 15:22:28 +0100
Message-ID: <20171205142228.lrfds2ih7tgf7ovy@christoph-lap>
References: <20171203225640.GA11655@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171203225640.GA11655@thinkpad>
Sender: linux-kernel-owner@vger.kernel.org
To: Ognjen Galic <smclt30p@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

On Sun, Dec 03, 2017 at 11:56:40PM +0100, Ognjen Galic wrote:
> Add support for the ACPI batteries on newer thinkpad models
> (>Sandy Bridge) that support the setting of start and stop
> thresholds.
> 
> The actual interface to the driver is a extension for the
> existing ACPI battery driver. This was done so that users
> can write transparently to the interface of the ACPI battery
> driver and dont have to use some private interface
> (for ex. /sys/devices/platform/thinkpad_acpi/).
> 
> Two new interfaces are created:
> 
> /sys/class/power_supply/BAT{0,1}/charge_start_threshold
> /sys/class/power_supply/BAT{0,1}/charge_stop_threshold

Just tried this on my X1 Carbon (i7-3667U Ivy Lake):

# cat /sys/class/power_supply/BAT0/charge_stop_threshold
100
# cat /sys/class/power_supply/BAT0/charge_start_threshold
100

That doesn't seem to make any sense.  Is my battery somehow reporting
false values here?  Any way to cross check these values?

--
Regards,
Christoph
