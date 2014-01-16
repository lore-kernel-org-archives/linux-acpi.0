From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [RFC][PATCH 2/3] PM / runtime: Routine for checking device
 status during system suspend
Date: Thu, 16 Jan 2014 15:32:51 +0200
Message-ID: <20140116133251.GC2494@intel.com>
References: <5420830.W4laSGaAU9@vostro.rjw.lan>
 <2472996.a5CGlmW4AP@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2472996.a5CGlmW4AP@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Aaron Lu <aaron.lu@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jan 15, 2014 at 12:14:46AM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Add a new helper routine, pm_runtime_enabled_and_suspended(), to
> allow subsystems (or PM domains) to check the runtime PM status of
> devices during system suspend (possibly to avoid resuming those
> devices upfront at that time).
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/base/power/runtime.c |   28 ++++++++++++++++++++++++++++
>  include/linux/pm_runtime.h   |    2 ++
>  2 files changed, 30 insertions(+)
> 
> Index: linux-pm/include/linux/pm_runtime.h
> ===================================================================
> --- linux-pm.orig/include/linux/pm_runtime.h
> +++ linux-pm/include/linux/pm_runtime.h
> @@ -53,6 +53,7 @@ extern unsigned long pm_runtime_autosusp
>  extern void pm_runtime_update_max_time_suspended(struct device *dev,
>  						 s64 delta_ns);
>  extern void pm_runtime_set_memalloc_noio(struct device *dev, bool enable);
> +extern bool pm_runtime_enabled_and_suspended(struct device *dev);
>  
>  static inline bool pm_children_suspended(struct device *dev)
>  {
> @@ -161,6 +162,7 @@ static inline unsigned long pm_runtime_a
>  				struct device *dev) { return 0; }
>  static inline void pm_runtime_set_memalloc_noio(struct device *dev,
>  						bool enable){}
> +static inline bool pm_runtime_enabled_and_suspended(struct device *dev) { return false };

The above probably doesn't compile if !CONFIG_PM_RUNTIME because of the
misplaced semicolon.
