From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH][RFC v2] ACPI: acpi_pad: Do not launch acpi_pad threads on idle cpus
Date: Wed, 03 Oct 2018 11:38:58 +0200
Message-ID: <3282057.yGUaGxRyCs@aspire.rjw.lan>
References: <1525521202-32519-1-git-send-email-yu.c.chen@intel.com> <8775668.fKKdjnIWAU@aspire.rjw.lan> <20180514154523.GA17331@sandybridge-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180514154523.GA17331@sandybridge-desktop>
Sender: linux-kernel-owner@vger.kernel.org
To: Yu Chen <yu.c.chen@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Lenny Szubowicz <lszubowi@redhat.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Rui Zhang <rui.zhang@intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Monday, May 14, 2018 5:45:23 PM CEST Yu Chen wrote:
> On Sun, May 13, 2018 at 11:30:52AM +0200, Rafael J. Wysocki wrote:
> > On Saturday, May 5, 2018 1:53:22 PM CEST Chen Yu wrote:
> > > According to current implementation of acpi_pad driver,
> > > it does not make sense to spawn any power saving threads
> > > on the cpus which are already idle - it might bring
> > > unnecessary overhead on these idle cpus and causes power
> > > waste. So verify the condition that if the number of 'busy'
> > > cpus exceeds the amount of the 'forced idle' cpus is met.
> > > This is applicable due to round-robin attribute of the
> > > power saving threads, otherwise ignore the setting/ACPI
> > > notification.
> > 
> > OK, but CPUs are busy, because they are running tasks.  If acpi_pad
> > kthreads run on them, the tasks they are running will migrate to the
> > currently idle CPUs (unless they have specific CPU affinity) and the
> > throttling will not really be effective.
> >
> OK, I think this makes sense, I missed the load balance scenario.
> > I would think that acpi_pad should ensure that the requested number of
> > CPUs will not run anything other than throttling kthreads.  Isn't that
> > the case?
> > 
> Do you mean, we should check if the number of 'idle'(rather than the 'busy' one
> in this patch) cpus is larger than the requested one? Then I think we should also
> add a patch to use the play_idle() as power_clamp to treat the throttling kthreads
> as idle threads thus to stop system tick. Such as the patch Jacob proposed:

I wonder if that can be switched over to the new idle injection framework
added recently?

Thanks,
Rafael
