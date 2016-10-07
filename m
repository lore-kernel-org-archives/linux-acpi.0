From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: Re: Bogus "APIC: NR_CPUS/possible_cpus limit of 4 reached" messages
Date: Fri, 7 Oct 2016 16:09:26 +0200
Message-ID: <20161007140926.GA314@x4>
References: <20161006112737.GA308@x4>
 <20161006124800.5a824dfc@lxorguk.ukuu.org.uk>
 <20161006115220.GB308@x4>
 <20161007132634.GA20654@x4>
 <alpine.DEB.2.20.1610071549330.19804@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ud10.udmedia.de ([194.117.254.50]:46022 "EHLO
        mail.ud10.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751412AbcJGOJa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Oct 2016 10:09:30 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1610071549330.19804@nanos>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Gu Zheng <guz.fnst@cn.fujitsu.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Dou Liyang <douly.fnst@cn.fujitsu.com>

On 2016.10.07 at 15:55 +0200, Thomas Gleixner wrote:
> On Fri, 7 Oct 2016, Markus Trippelsdorf wrote:
> > On 2016.10.06 at 13:52 +0200, Markus Trippelsdorf wrote:
> > > On 2016.10.06 at 12:48 +0100, One Thousand Gnomes wrote:
> > > > On Thu, 6 Oct 2016 13:27:37 +0200
> > > > Markus Trippelsdorf <markus@trippelsdorf.de> wrote:
> > > > 
> > > > > On current trunk I get during boot:
> > > > > 
> > > > > [    0.000000] APIC: NR_CPUS/possible_cpus limit of 4 reached.  Processor 4/0x84 ignored.
> > > > > [    0.000000] APIC: NR_CPUS/possible_cpus limit of 4 reached.  Processor 5/0x85 ignored.
> > > > > 
> > > > > I don't think these messages make much sense on a 4-core machine.
> > > > > 
> > > > 
> > > > Four cores with or without hyperthreading ?
> > > 
> > > Without. This is a rather old AMD machine (AMD Phenom II X4 955).
> 
> That's due to the recent cpuid -> nodeid changes. The patch below should
> fix it.

Indeed it does. Thanks for the quick fix.

-- 
Markus
