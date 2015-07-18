From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/2] ACPI / cpufreq: ACPI processor driver and ACPI
 cpufreq driver cleanups
Date: Sat, 18 Jul 2015 11:34:46 +0530
Message-ID: <20150718060446.GB11802@linux>
References: <10273534.kyzK8rhvUz@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <10273534.kyzK8rhvUz@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pan Xinhui <xinhuix.pan@intel.com>
List-Id: linux-acpi@vger.kernel.org

On 18-07-15, 03:13, Rafael J. Wysocki wrote:
> Hi,
> 
> The following two patches clean up a couple of things in the ACPI processor
> driver and the ACPI cpufreq driver:
> 
> [1/2] Drop the unused first argument of acpi_processor_unregister_performance().
> [2/2] Drop the now redundant acpi_data pointer from acpi_cpufreq_data.
> 
> Both patches on top of the current linux-next branch of the linux-pm.git tree.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
