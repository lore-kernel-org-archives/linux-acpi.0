From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH][RFC v2] ACPI: acpi_pad: Do not launch acpi_pad threads on idle cpus
Date: Sun, 13 May 2018 11:30:52 +0200
Message-ID: <8775668.fKKdjnIWAU@aspire.rjw.lan>
References: <1525521202-32519-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525521202-32519-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Lenny Szubowicz <lszubowi@redhat.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Rui Zhang <rui.zhang@intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Saturday, May 5, 2018 1:53:22 PM CEST Chen Yu wrote:
> According to current implementation of acpi_pad driver,
> it does not make sense to spawn any power saving threads
> on the cpus which are already idle - it might bring
> unnecessary overhead on these idle cpus and causes power
> waste. So verify the condition that if the number of 'busy'
> cpus exceeds the amount of the 'forced idle' cpus is met.
> This is applicable due to round-robin attribute of the
> power saving threads, otherwise ignore the setting/ACPI
> notification.

OK, but CPUs are busy, because they are running tasks.  If acpi_pad
kthreads run on them, the tasks they are running will migrate to the
currently idle CPUs (unless they have specific CPU affinity) and the
throttling will not really be effective.

I would think that acpi_pad should ensure that the requested number of
CPUs will not run anything other than throttling kthreads.  Isn't that
the case?

Thanks,
Rafael
