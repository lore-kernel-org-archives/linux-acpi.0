From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Speedstep on Celeron SU2300 - 20% more battery lifetime on
	Windows
Date: Tue, 7 Sep 2010 16:22:46 +0100
Message-ID: <20100907152246.GA12326@srcf.ucam.org>
References: <AANLkTiktJ5Xgnsmq2je7T3Yc5Sf53Bu8vWMM1XT1V_vm@mail.gmail.com> <201009020152.37466.trenn@suse.de> <AANLkTi=WDEA+prG26g5R9oG1uZ7cNgaMrYDtug_LM7bY@mail.gmail.com> <201009061035.03727.trenn@suse.de> <AANLkTi==7HGa9OKUDq4cpexPpdPMKVgcXqONFL+UqmRe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTi==7HGa9OKUDq4cpexPpdPMKVgcXqONFL+UqmRe@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Tiago Marques <tiagomnm@gmail.com>
Cc: Thomas Renninger <trenn@suse.de>, cpufreq@vger.kernel.org, discuss@lesswatts.org, linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Sep 06, 2010 at 10:47:58PM +0100, Tiago Marques wrote:

> Yes, but shouldn't it detect P-States with different voltages, as in
> windows? (even as stupid as this sounds) I sure loved to get it always
> stuck at the lower clock, given that I usually perform maintenance on
> PCs I highly doubt the fan would get dust clogged to the point of
> taking the CPU to temperatures that would cause problems.
> This looks like it doesn't support Speedstep even though Intel says it
> does but the fact is that Windows can work with two voltages, which
> always improves power.

If there's only one frequency then there's no reason to have multiple 
voltages - the voltage will already be at the minimum possible for the 
core to be stable at that frequency. Entering C4 will typically result 
in the voltage dropping as parts of the core are disabled.

Does your chip have the "est" flag in /proc/cpuinfo? If not, it doesn't 
support speedstep.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
