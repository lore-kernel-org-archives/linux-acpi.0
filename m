From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2 4/6] ACPI / osi: Fix default _OSI(Darwin) support
Date: Fri, 29 Apr 2016 15:01:23 +0200
Message-ID: <20160429130123.GA18473@wunner.de>
References: <cover.1461656216.git.lv.zheng@intel.com>
 <e8ea6e8841adce9e10e5bd0b278b47a7c799c276.1461736123.git.lv.zheng@intel.com>
 <36DF59CE26D8EE47B0655C516E9CE64028748233@shsmsx102.ccr.corp.intel.com>
 <2223787.tzTyTqLAjo@vostro.rjw.lan>
 <1AE640813FDE7649BE1B193DEA596E883BB82C18@SHSMSX101.ccr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E883BB82EF4@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E883BB82EF4@SHSMSX101.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Chen, Yu C" <yu.c.chen@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>
List-Id: linux-acpi@vger.kernel.org

Hi Lv Zheng,

On Fri, Apr 29, 2016 at 02:07:53AM +0000, Zheng, Lv wrote:
> I just sent UPDATE of PATCH 4/6 and PATCH 6/6 to the mailing list with this
> corrected.
> I was hoping they could update patchwork content so that the Bugzilla
> reporters might use the updated patches for confirmation.
> The Message-Id(s) of the 2 patches were kept as same as the old ones.

As promised on Bugzilla I've tested v2 of this series (with the "INC"
manually fixed up) on a MacBookPro9,1.

I only reviewed the patches in a superficial fashion, but one issue I've
noticed is that

#define pr_fmt(fmt) "ACPI: " fmt

is missing in osi.c (patch [6/6]).

Without command line arguments, Linux responds yay to _OSI("Darwin")
and nothing else and the Thunderbolt controller is powered up.

With "acpi_osi=!Darwin", Linux responds nay to everything and the
Thunderbolt controller is powered down.

So it seems to work as intended. If you want me to test anything else
please let me know.

Thanks,

Lukas
