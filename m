From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: cpufreq doesn't seem to work in Intel Q9300
Date: Mon, 11 Aug 2008 07:12:09 -0700
Message-ID: <20080811071209.189b68c5@infradead.org>
References: <514e099a0808030300u140a0ae7m92a2e7294f39f7b7@mail.gmail.com>
	<200808081430.43012.trenn@suse.de>
	<aff5deaf0808081123s1fbe6a5cn7847e9cb053c1f5a@mail.gmail.com>
	<200808092059.47863.trenn@suse.de>
	<514e099a0808100128u303207clcb22292db2f0cc59@mail.gmail.com>
	<1218418431.6671.52.camel@yakui_zhao.sh.intel.com>
	<514e099a0808102144n241c8e9ak255bded0a80744f1@mail.gmail.com>
	<20080811042244.469f8e1d@infradead.org>
	<20080811140206.GB3338@cs181140183.pp.htv.fi>
	<20080811140734.GA27959@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:42935 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748AbYHKOMN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Aug 2008 10:12:13 -0400
In-Reply-To: <20080811140734.GA27959@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Adrian Bunk <bunk@kernel.org>, S K <nospamnoham@gmail.com>, Zhao Yakui <yakui.zhao@intel.com>, Thomas Renninger <trenn@suse.de>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Mon, 11 Aug 2008 15:07:34 +0100
Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> On Mon, Aug 11, 2008 at 05:02:06PM +0300, Adrian Bunk wrote:
> 
> > This statement is only true for HPC environments and when you
> > measure Watts per work done.
> > 
> > But if you have some desktop or server with a load that is
> > determined by when it gets used, then p4-clockmod can actually save
> > energy when the computer is not under high load or even idle.
> > 
> > Or do I miss anything?
> 
> On modern hardware, the C states will win you more than downclocking
> the processor would.
> 

actually.. p4_clockmod is *NOT* downclocking the processor.. that's the
whole problem with it..



-- 
If you want to reach me at my work email, use arjan@linux.intel.com
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
