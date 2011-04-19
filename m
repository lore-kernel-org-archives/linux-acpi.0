From: Tino Keitel <tino.keitel@tikei.de>
Subject: Re: [linux-pm] /proc/acpi/wakeup regression in 2.6.39-rc3
Date: Tue, 19 Apr 2011 22:22:12 +0200
Message-ID: <20110419202212.GA15438@mac.home>
References: <201104150053.37037.rjw@sisk.pl>
 <Pine.LNX.4.44L0.1104151034580.2051-100000@iolanthe.rowland.org>
 <20110415145457.GA27650@eazy.amigager.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110415145457.GA27650@eazy.amigager.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@sisk.pl>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation>
List-Id: linux-acpi@vger.kernel.org

Hi,

I reverted some wakeup and ACPI related commits. When I reverted commit
7fa69baf29de8c77a6b32c054df2abb8f11f8aa4, wakeup using the keyboard
worked again and /proc/acpi/wakeup behaved as expected.

So check this, I reverted the following commits to avoid conflicts and
build failures:

c19f9a84ec807da57fd75bbd9a3f2b8269611f79
5190726765b40774c069e187a958e10ccd970e65
2a5d24286e8bdafdc272b37ec5bdd9e977b3767c
f2b56bc808addb908a5bf435d9b942c02af9a7c4
7fa69baf29de8c77a6b32c054df2abb8f11f8aa4

Regards,
Tino
