From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [patch 2/2] x86: Manage ENERGY_PERF_BIAS based on cpufreq
	governor
Date: Fri, 5 Mar 2010 20:55:22 +0000
Message-ID: <20100305205522.GA15489@srcf.ucam.org>
References: <20100303000649.757684000@intel.com> <20100303000849.278509000@intel.com> <4B8DADB9.1040302@xenotime.net> <20100303215453.GG2579@ucw.cz> <1267662469.16916.1020.camel@localhost.localdomain> <20100305091949.GA31554@atrey.karlin.mff.cuni.cz> <7C53B33EE871F14797C999838AA8B5A914ACD58C@orsmsx505.amr.corp.intel.com> <20100305204029.GB20554@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100305204029.GB20554@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, Randy Dunlap <rdunlap@xenotime.net>, Ingo Molnar <mingo@elte.hu>, H Peter Anvin <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Len Brown <lenb@kernel.org>, Dave Jones <davej@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Mar 05, 2010 at 09:40:29PM +0100, Pavel Machek wrote:

> That can be only true if it does not give benefits period... AC and
> battery power are quite different scenarios.

No, they're not.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
