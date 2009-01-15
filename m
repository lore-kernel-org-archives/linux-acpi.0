From: Martin Michlmayr <tbm@cyrius.com>
Subject: Re: [2.6.28] Kernel panic after closing lid on HP 2510p
Date: Thu, 15 Jan 2009 08:41:34 +0100
Message-ID: <20090115074134.GA22704@deprecation.cyrius.com>
References: <200901121356.46236.elendil@planet.nl> <20090113123056.GA2464@deprecation.cyrius.com> <20090114162603.c632d82e.akpm@linux-foundation.org> <20090115020311.GA18740@srcf.ucam.org> <20090114181542.34614acf.akpm@linux-foundation.org> <20090115022106.GA19069@srcf.ucam.org> <1231988103.20746.149.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755191AbZAOHl6@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1231988103.20746.149.camel@rzhang-dt>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Andrew Morton <akpm@linux-foundation.org>, "elendil@planet.nl" <elendil@planet.nl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, fengguang.wu@intel.com
List-Id: linux-acpi@vger.kernel.org

* Zhang Rui <rui.zhang@intel.com> [2009-01-15 10:55]:
> please check if this is a duplicate of bug #11259.
> http://bugzilla.kernel.org/show_bug.cgi?id=11259

It certainly sounds so.

BTW, here is my original bug report which contains an easy recipe to
reproduce the problem: http://lkml.org/lkml/2008/6/16/157
And here's a bug report from Ubuntu that shows that the HP 6710b,
HP 6510b and HP 2510p laptops are affected:
https://bugs.launchpad.net/ubuntu/+source/acpid/+bug/157691

Thanks for looking into this issue.
-- 
Martin Michlmayr
http://www.cyrius.com/
