From: Yu Chen <yu.c.chen@intel.com>
Subject: Re: [PATCH][RFC] ACPI: acpi_pad: Do not launch acpi_pad threads on
 idle cpus
Date: Sat, 5 May 2018 19:52:04 +0800
Message-ID: <20180505115204.GA32444@sandybridge-desktop>
References: <1525421322-23431-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1525421322-23431-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>, Rui Zhang <rui.zhang@intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, May 04, 2018 at 04:08:42PM +0800, Chen Yu wrote:
> According to current implementation of acpi_pad driver,
> it does not make sense to spawn any power saving threads
> on the cpus which are already idle - it might bring
> unnecessary overhead on these idle cpus and causes power
> waste. So verify the condition that if the number of 'busy'
> cpus exceeds the amount of the 'forced idle' cpus - This is
> applicable due to round-robin attribute of the power saving
> threads, otherwise ignore the setting/ACPI notification.
> 
> Suggested-by: Lenny Szubowicz <lszubowi@redhat.com>
> Suggested-by: Len Brown <lenb@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Rui Zhang <rui.zhang@intel.com>
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>
Please ignore this one, I'm sending out another version.
Thanks,
Yu
