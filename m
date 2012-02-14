From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 4/5] ACPI: Do cpufreq clamping for throttling per
 package v2
Date: Tue, 14 Feb 2012 00:17:44 +0000
Message-ID: <20120214001744.GA11137@srcf.ucam.org>
References: <1328545032-21373-1-git-send-email-andi@firstfloor.org>
 <1328545032-21373-5-git-send-email-andi@firstfloor.org>
 <20120206163106.GB32061@srcf.ucam.org>
 <4F399D19.9090904@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4F399D19.9090904@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On Mon, Feb 13, 2012 at 06:30:33PM -0500, Len Brown wrote:
> On 02/06/2012 11:31 AM, Matthew Garrett wrote:
> 
> > On Mon, Feb 06, 2012 at 08:17:11AM -0800, Andi Kleen wrote:
> >> +#define reduction_pctg(cpu) \
> >> +	per_cpu(cpufreq_thermal_reduction_pctg, phys_package_first_cpu(cpu))
> > 
> > I don't like using percentages here - we end up with the potential for 
> > several percentages to end up mapping to the same P state.
> 
> 
> Does it matter?

If you step through multiple percentages that map to the same P state, 
yes. On the other hand, re-reading the specification, it seems that this 
is the behaviour envisaged in the polling equation. I guess we'll stick 
with that.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
