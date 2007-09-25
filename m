From: "Torsten Kaiser" <just.for.lkml@googlemail.com>
Subject: Re: ACPI power off regression in 2.6.23-rc8 (NOT in rc7)
Date: Tue, 25 Sep 2007 18:30:00 +0200
Message-ID: <64bb37e0709250930m555a9586j35a1d579ea5a3713@mail.gmail.com>
References: <20070925065109.GA3080@localhost.localdomain>
	 <20070925003340.5d6dd7f4.akpm@linux-foundation.org>
	 <46F8C880.1010006@suse.de>
	 <64bb37e0709250208gcbdeb6do6026e138e746bde2@mail.gmail.com>
	 <46F8F033.2040402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:29800 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759150AbXIYQaF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Sep 2007 12:30:05 -0400
Received: by py-out-1112.google.com with SMTP id u77so3631107pyb
        for <linux-acpi@vger.kernel.org>; Tue, 25 Sep 2007 09:30:02 -0700 (PDT)
In-Reply-To: <46F8F033.2040402@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Damien Wyart <damien.wyart@free.fr>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Frans Pop <elendil@planet.nl>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org

On 9/25/07, Alexey Starikovskiy <aystarik@gmail.com> wrote:
> Torsten Kaiser wrote:
> > No, I do not have CONFIG_ACPI_SLEEP set,
> > because I do not have CONFIG_PM_SLEEP set,
> > because I do not want SUSPEND and/or HIBERNATION.
> This is not the reason. SUSPEND is controlled with CONFIG_SUSPEND and
> HIBERNATION is controlled with CONFIG_HIBERNATION.
> But if you want S5 ACPI sleep state you might want to enable ACPI_SLEEP...

What I meant with SUSPEND and/or HIBERNATION was CONFIG_SUSPEND /
CONFIG_HIBERNATION.

And the relations where from Kconfig:
from drivers/acpi/Kconfig:
config ACPI_SLEEP
        bool
        depends on PM_SLEEP
        default y

-> no PM_SLEEP means no ACPI_SLEEP

from kernel/power/Kconfig:
config PM_SLEEP
        bool
        depends on SUSPEND || HIBERNATION
        default y

-> No SUSPEND and/or HIBERNATION means no PM_SLEEP

And if I select SUSPEND and/or HIBERNATION I will not only build this
feature into the kernel, but also HOTPLUG_CPU and I want to avoid
that.

It's exactly as Linus said in his mail: Not everybody wants SUSPEND...

I should have formulated that better in my mail, but that was what I
wanted to say.


Back to debugging this:
http://marc.info/?l=linux-acpi&m=119052970904643&w=4
fails to apply against 2.6.23-rc7-mm1, but moving that function by
hand was not to difficult. ;)
(With only the second patch I got a link error...)

http://marc.info/?l=linux-acpi&m=119073173625910&w=4
applied, and a test showed that my system now powers off again.

Torsten
