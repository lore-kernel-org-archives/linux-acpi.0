From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: cpufreq doesn't seem to work in Intel Q9300
Date: Mon, 11 Aug 2008 09:33:51 +0800
Message-ID: <1218418431.6671.52.camel@yakui_zhao.sh.intel.com>
References: <514e099a0808030300u140a0ae7m92a2e7294f39f7b7@mail.gmail.com>
	 <200808081430.43012.trenn@suse.de>
	 <aff5deaf0808081123s1fbe6a5cn7847e9cb053c1f5a@mail.gmail.com>
	 <200808092059.47863.trenn@suse.de>
	 <514e099a0808100128u303207clcb22292db2f0cc59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:49093 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752838AbYHKBT6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 10 Aug 2008 21:19:58 -0400
In-Reply-To: <514e099a0808100128u303207clcb22292db2f0cc59@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: S K <nospamnoham@gmail.com>
Cc: Thomas Renninger <trenn@suse.de>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Sun, 2008-08-10 at 01:28 -0700, S K wrote:
> On Sat, Aug 9, 2008 at 11:59 AM, Thomas Renninger <trenn@suse.de> wrote:
> > On Friday 08 August 2008 08:23:25 pm S K wrote:
> >> > Try updating the BIOS.
> >> > I expect your CPU is too new and the BIOS cannot export the correct freq
> >> > values for the specific CPU yet.
> >> >
> >> >      Thomas
> >>
> >> The BIOS is already at the latest version :( Is the above comment the
> >> only possible reason for the issue?
> >
> > It is very likely.
> 
> But Windows XP is able to do the scaling properly. So how can it be a
> BIOS issue? While reading about the Foxconn BIOS fiasco that happened
> recently a kernel dev (forgot his name) stated that Linux tries to
> emulate Windows for ACPI operations.
> 
> So I'm guessing this is a kernel bug.
>From the attached acpidump it seems that there is no definition of
_PCT,_PSS, _PPC. So acpi_cpufreq driver can't be used on your machine.
This is a BIOS issue. 

But it is very strange that cpufreq scaling can work on Windows XP.
Will you please try the P4 clock cpufreq driver and see whether the
scaling can work ? In fact P4 clock cpufreq driver is already replaced
by acpi_cpufreq driver for the latest cpu. 
Anyway please try p4 clock cpufreq driver.

Thanks.

> 
> -SK

