From: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH v2 4/7] ghes_edac: avoid multiple calls to dmi_walk()
Date: Tue, 15 Aug 2017 08:48:16 -0700
Message-ID: <20170815154815.wy3dqwb4yi3feahg@intel.com>
References: <20170814170552.j3lhzvnwlpz75y4g@pd.tnic>
 <1502732561.2042.141.camel@hpe.com>
 <20170814180526.wtfjzgc6uye2qtx6@pd.tnic>
 <1502734083.2042.143.camel@hpe.com>
 <20170814183551.sgk2i7lxpmpyodhv@pd.tnic>
 <1502736750.2042.145.camel@hpe.com>
 <20170814193432.mjldfhfal5ba5dt7@pd.tnic>
 <1502741290.2042.147.camel@hpe.com>
 <20170814203942.6t3mrq3hc324blab@pd.tnic>
 <1502810766.2042.149.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1502810766.2042.149.camel@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Cc: "bp@alien8.de" <bp@alien8.de>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Aug 15, 2017 at 08:35:51AM -0700, Kani, Toshimitsu wrote:
> User apps like ras-mc-ctl works as expected for a given (not-so-great)
> DIMM info from SMBIOS as well.  I do not see a probelm from user
> perspective, either.

Won't the user see all their DIMMs reported for each memory controller
under /sys/devices/system/edac/mc/mc*/dimm* ?

That sounds confusing.

-Tony
