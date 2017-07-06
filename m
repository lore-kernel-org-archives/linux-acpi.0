From: Chen Yu <yu.c.chen@intel.com>
Subject: Re: [PATCH 3/3] ACPI: EC: Change EC noirq tuning to be an optional
 behavior
Date: Thu, 6 Jul 2017 16:30:35 +0800
Message-ID: <20170706083035.GA2911@yu-desktop-1.sh.intel.com>
References: <d8ac96c8fd988daec20f7a22a2acb3119ccd149b.1497418749.git.lv.zheng@intel.com>
 <157972fa5572b0f0c157142ea151b8508e7640b4.1497418749.git.lv.zheng@intel.com>
 <1792284.us4mECpxNF@aspire.rjw.lan>
 <1AE640813FDE7649BE1B193DEA596E886CED9515@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886CED9515@SHSMSX101.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Lv,
On Mon, Jul 03, 2017 at 01:15:26PM +0800, Zheng, Lv wrote:
> Hi, Rafael
> 
> > From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> > Subject: Re: [PATCH 3/3] ACPI: EC: Change EC noirq tuning to be an optional behavior
> > 
> > On Wednesday, June 14, 2017 01:59:24 PM Lv Zheng wrote:
> > > According to the bug report, though the busy polling mode can make noirq
> > > stages executed faster, it causes abnormal fan blowing in noirq stages.
> > >
> > > This patch prepares an option so that the automatic busy polling mode
> > > switching for noirq stages can be enabled by who wants to tune it, not all
> > > users.
> > > Noticed that the new global option cannot be changed during noirq stages.
> > > There is no need to lock its value changes to sync with polling mode
> > > settings switches.
> > >
> > > For reporters and testers in the thread, as there are too many reporters
> > > on the bug link, this patch only picks names from most active commenters.
> > > Sorry for the neglet.
> > >
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=191181
> > > Reported-by: Tatsuyuki Ishi <ishitatsuyuki@gmail.com>
> > > Reported-by: Claudio Sacerdoti Coen <claudio.sacerdoticoen@unibo.it>
> > > Tested-by: Nicolo' <nicolopiazzalunga@gmail.com>
> > > Reported-by: Jens Axboe <axboe@kernel.dk>
> > > Tested-by: Gjorgji Jankovski <j.gjorgji@gmail.com>
> > > Tested-by: Damjan Georgievski <gdamjan@gmail.com>
> > > Tested-by: Fernando Chaves <nanochaves@gmail.com>
> > > Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> > 
> > First of all, this seems to be a fix for commit c3a696b6e8f8 (ACPI / EC: Use busy polling
> > mode when GPE is not enabled), so there should be a Fixes: tag pointing to that
> > one.
> > 
> > Moreover, if that is just a performance optimization and not a matter of correctness,
> > why don't we simply drop acpi_ec_enter/leave_noirq() entirely?
> > 
> > What is going to break if we do that?
> 
> Let me Cc Yu for justification.
> I just added busy poll support for suspend/boot according to the root cause reported by him.
> He should know the end user requirements better than me.
> 
I remembered the original issue was reported against the slowness during suspend/resume
due to the ec is running with GPE disabled, and falls into schedule_timeout() loop.

If the busy polling mode is controlled by the boot options rather than
acpi_ec_enter/leave_noirq(), then user should be noticed of the result
that the cpu usage might be always higer if they enable the busy polling
mode.

Thanks,
	Yu
> Thanks and best regards
> Lv
