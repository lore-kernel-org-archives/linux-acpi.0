From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH, RESEND] acpi-cpufreq: remove unreliable optional
 device.get() code
Date: Sun, 17 Jul 2011 16:59:18 +0200
Message-ID: <20110717145918.GA32223@comet.dominikbrodowski.net>
References: <alpine.LFD.2.02.1106060144310.6779@x980>
 <20110606071209.GA20080@isilmar-3.linta.de>
 <alpine.LFD.2.02.1106062353030.4784@x980>
 <20110607054226.GA22398@isilmar-3.linta.de>
 <alpine.LFD.2.02.1107131718270.9546@x980>
 <alpine.LFD.2.02.1107161846130.11045@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1107161846130.11045@x980>
Sender: cpufreq-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Dave Jones <davej@redhat.com>, linux-acpi@vger.kernel.org, cpufreq@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Jul 16, 2011 at 06:49:34PM -0400, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> Date: Mon, 6 Jun 2011 01:06:57 -0400
> 
> cpufreq offers the optional driver.get() entry point
> for drivers to export instantaneous frequency in
> /sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_cur_freq.
> 
> 25% of the acpi-cpufreq driver is involved in supporting
> that optional feature, but on modern processors, it
> is not reliable.
> 
> So here we delete this optional feature from acpi-cpufreq.
> /sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_cur_freq
> will go away on acpi-cpufreq systems, but note that
> /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq
> will still be presnet to indicate the most recent request.
> 
> (and yes, powertop still works:-)
> 
> The most common reason that driver.get() is not reliable
> is that modern processors autonomously change frequency
> without OS instruction.  This means that reading
> PERF_STATUS is possibly in-accurate as soon as the
> instruction after it is read.
>
> Average frequency over an interval is more useful
> than instantaneous frequency on modern hardware.
> acpi-cpufreq supplies average frequency via
> the the driver->getavg() entry, which is what
> the ondemand governor uses.

Regarding this patch and the philosophy behind it, I uphold my doubts which
I specified last time this issue came up (cf.
http://marc.info/?l=linux-acpi&m=130742534931688&w=2 )

Best,
	Dominik
