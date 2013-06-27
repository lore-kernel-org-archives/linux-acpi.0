From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2 V3] CPUFreq: Add new sysfs attribute freqdomain_cpus
 for acpi-freq driver
Date: Thu, 27 Jun 2013 13:55:47 +0530
Message-ID: <CAKohponGDfjP6bFtXohb=h+_csmT49UJ=Dko_e4mUrkDBVN02g@mail.gmail.com>
References: <1372316934-27225-1-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1372316934-27225-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-pm-owner@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: rjw@sisk.pl, lenb@kernel.org, jean-philippe.halimi@exascale-computing.eu, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 27 June 2013 12:38, Lan Tianyu <tianyu.lan@intel.com> wrote:
> Commit aa77a52 and fcf8058 changes the content of "related_cpus" and user
> space can't get cpus which are in the same hardware coordination cpu domain
> (These info are provided by ACPI AML method _PSD) via "related_cpus". This
> change affects some users of original "related_cpus".
>
> This patch is to add a new sysfs attribute "freqdomian_cpus" for acpi-cpufreq
> driver which exposes all cpus in the same domain regardless of hardware or
> software coordination to make up the info loss of previous change.
>
> Reference:https://bugzilla.kernel.org/show_bug.cgi?id=58761
> Reported-by: Jean-Philippe Halimi <jean-philippe.halimi@exascale-computing.eu>
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
