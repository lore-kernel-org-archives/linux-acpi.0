From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 11/21] ACPI: processor: Convert to hotplug state machine
Date: Tue, 6 Sep 2016 23:08:28 +0200
Message-ID: <CAJZ5v0haVNDoOJco7kB=YEn=6GZciUdMXz124PBXVkAaQB5PGQ@mail.gmail.com>
References: <20160906170457.32393-1-bigeasy@linutronix.de> <20160906170457.32393-12-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33835 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965001AbcIFVIa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Sep 2016 17:08:30 -0400
In-Reply-To: <20160906170457.32393-12-bigeasy@linutronix.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, rt@linutronix.de, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Tue, Sep 6, 2016 at 7:04 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> Install the callbacks via the state machine.
>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

This appears to be part of a series, but what if it goes in
separately?  Would that be a problem?

Thanks,
Rafael
