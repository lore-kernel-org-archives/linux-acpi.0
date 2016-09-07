From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 11/21] ACPI: processor: Convert to hotplug state machine
Date: Wed, 07 Sep 2016 17:59:22 +0200
Message-ID: <9098385.Dq4gL67fhY@vostro.rjw.lan>
References: <20160906170457.32393-1-bigeasy@linutronix.de> <CAJZ5v0haVNDoOJco7kB=YEn=6GZciUdMXz124PBXVkAaQB5PGQ@mail.gmail.com> <20160907140102.pcjxtqs7pvkvusao@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160907140102.pcjxtqs7pvkvusao@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, rt@linutronix.de, Thomas Gleixner <tglx@linutronix.de>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wednesday, September 07, 2016 04:01:02 PM Sebastian Andrzej Siewior wrote:
> On 2016-09-06 23:08:28 [+0200], Rafael J. Wysocki wrote:
> > This appears to be part of a series, but what if it goes in
> > separately?  Would that be a problem?
> 
> You would have to deal with conflicts in cpuhotplug.h. All other
> requirements are merged.

OK

Please feel free to add

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

and route it via tip.

Thanks,
Rafael
