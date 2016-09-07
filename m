From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 11/21] ACPI: processor: Convert to hotplug state machine
Date: Wed, 7 Sep 2016 16:01:02 +0200
Message-ID: <20160907140102.pcjxtqs7pvkvusao@linutronix.de>
References: <20160906170457.32393-1-bigeasy@linutronix.de>
 <20160906170457.32393-12-bigeasy@linutronix.de>
 <CAJZ5v0haVNDoOJco7kB=YEn=6GZciUdMXz124PBXVkAaQB5PGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:39831 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752699AbcIGOBf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Sep 2016 10:01:35 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0haVNDoOJco7kB=YEn=6GZciUdMXz124PBXVkAaQB5PGQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, rt@linutronix.de, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On 2016-09-06 23:08:28 [+0200], Rafael J. Wysocki wrote:
> This appears to be part of a series, but what if it goes in
> separately?  Would that be a problem?

You would have to deal with conflicts in cpuhotplug.h. All other
requirements are merged.

> Thanks,
> Rafael

Sebastian
