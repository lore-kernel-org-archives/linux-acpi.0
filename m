From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: Re: Bogus "APIC: NR_CPUS/possible_cpus limit of 4 reached" messages
Date: Fri, 7 Oct 2016 15:26:34 +0200
Message-ID: <20161007132634.GA20654@x4>
References: <20161006112737.GA308@x4>
 <20161006124800.5a824dfc@lxorguk.ukuu.org.uk>
 <20161006115220.GB308@x4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161006115220.GB308@x4>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Gu Zheng <guz.fnst@cn.fujitsu.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Dou Liyang <douly.fnst@cn.fujitsu.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-acpi@vger.kernel.org

On 2016.10.06 at 13:52 +0200, Markus Trippelsdorf wrote:
> On 2016.10.06 at 12:48 +0100, One Thousand Gnomes wrote:
> > On Thu, 6 Oct 2016 13:27:37 +0200
> > Markus Trippelsdorf <markus@trippelsdorf.de> wrote:
> > 
> > > On current trunk I get during boot:
> > > 
> > > [    0.000000] APIC: NR_CPUS/possible_cpus limit of 4 reached.  Processor 4/0x84 ignored.
> > > [    0.000000] APIC: NR_CPUS/possible_cpus limit of 4 reached.  Processor 5/0x85 ignored.
> > > 
> > > I don't think these messages make much sense on a 4-core machine.
> > > 
> > 
> > Four cores with or without hyperthreading ?
> 
> Without. This is a rather old AMD machine (AMD Phenom II X4 955).

CCing more people.

-- 
Markus
