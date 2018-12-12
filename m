From: Yu Chen <yu.c.chen@intel.com>
Subject: Re: [PATCH][RFC v2] ACPI: acpi_pad: Do not launch acpi_pad threads
 on idle cpus
Date: Wed, 12 Dec 2018 09:56:57 +0800
Message-ID: <20181212015656.GA25427@chenyu-desktop>
References: <1525521202-32519-1-git-send-email-yu.c.chen@intel.com>
 <20181210063153.GO5327@linux-l9pv.suse>
 <20181211031220.GA23975@chenyu-desktop>
 <20181211083754.GE28555@linux-l9pv.suse>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181211083754.GE28555@linux-l9pv.suse>
Sender: linux-kernel-owner@vger.kernel.org
To: joeyli <jlee@suse.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Lenny Szubowicz <lszubowi@redhat.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Rui Zhang <rui.zhang@intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi,
On Tue, Dec 11, 2018 at 04:37:54PM +0800, joeyli wrote:
> Hi Yu Chen,
> 
> Thanks for your response!
> 
> On Tue, Dec 11, 2018 at 11:12:21AM +0800, Yu Chen wrote:
> > Hi Joey,
> > On Mon, Dec 10, 2018 at 02:31:53PM +0800, joeyli wrote:
> > > Hi Chen Yu and ACPI experts,
> > > 
> > > On Sat, May 05, 2018 at 07:53:22PM +0800, Chen Yu wrote:
> > > > According to current implementation of acpi_pad driver,
> > > > it does not make sense to spawn any power saving threads
> > > > on the cpus which are already idle - it might bring
> > > > unnecessary overhead on these idle cpus and causes power
> > > > waste. So verify the condition that if the number of 'busy'
> > > > cpus exceeds the amount of the 'forced idle' cpus is met.
> > > > This is applicable due to round-robin attribute of the
> > > > power saving threads, otherwise ignore the setting/ACPI
> > > > notification.
> > > > 
> > > > Suggested-by: Lenny Szubowicz <lszubowi@redhat.com>
> > > > Suggested-by: Len Brown <lenb@kernel.org>
> > > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > > Cc: Lenny Szubowicz <lszubowi@redhat.com>
> > > > Cc: Len Brown <lenb@kernel.org>
> > > > Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > > Cc: Rui Zhang <rui.zhang@intel.com>
> > > > Cc: linux-acpi@vger.kernel.org
> > > > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > > 
> > > Do you have any news for this patch? Why it did not merged by kernel
> > > maineline?
> > > 
> > We are evaluating if this could be integrated into idle injection framework.
> > May I know if there's any requirement/background from SUSE on this?
> > 
> 
> I am also looking at your patch and idle injection framework. Currently I do not
> have good suggestion for your patches yet. But I will try to ready my knowledge when
> you send out new version.
>
Thanks. I mean, does SUSE get report from customers who encountered this issue?
BTW, may I know the status of the encryption hibernation please?(Usin the TPM?)

Best,
Yu(Ryan)
> Thanks a lot!
> Joey Lee 
