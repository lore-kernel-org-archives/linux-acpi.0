From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] ACPI / CPPC: Fix per-CPU pointers management
Date: Sat, 10 Dec 2016 19:51:06 +0100
Message-ID: <20161210185106.eyj356w3ffgibaqi@linutronix.de>
References: <cover.1479844244.git.tim.c.chen@linux.intel.com>
 <20161209144551.jhnbfsxdxsk4ld6s@linutronix.de>
 <CAJZ5v0jUCHSM90yEoygAbKVY3ySaWQk-Cp6qkd+6ESH74J2_8A@mail.gmail.com>
 <296282606.tnoJCKgU2l@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:36877 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752162AbcLJSvV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 10 Dec 2016 13:51:21 -0500
Content-Disposition: inline
In-Reply-To: <296282606.tnoJCKgU2l@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, the arch/x86 maintainers <x86@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, jolsa@redhat.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On 2016-12-10 00:52:28 [+0100], Rafael J. Wysocki wrote:
> Hi Thomas,
> 
> The crash fixed by this is exposed by the ITMT (asymmetric packing) series
> (which involves using ACPI CPPC on x86), so IMO it would be good to route it
> through tip along with that series.

can we get this merged into the original patch please? This is default y
and breaks bisecting.

> Thanks,
> Rafael

Sebastian
