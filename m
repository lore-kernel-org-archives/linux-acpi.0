From: Dave Jones <davej@redhat.com>
Subject: Re: acpi-cpufreq; Intel Johnstown (Atom N270)
Date: Thu, 13 Aug 2009 15:07:41 -0400
Message-ID: <20090813190741.GA7808@redhat.com>
References: <20090813172556.GB9385@alittletooquiet.net> <20090813182908.GC9385@alittletooquiet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:42728 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755373AbZHMTHt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Aug 2009 15:07:49 -0400
Content-Disposition: inline
In-Reply-To: <20090813182908.GC9385@alittletooquiet.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Forest Bond <forest@alittletooquiet.net>
Cc: linux-acpi@vger.kernel.org

On Thu, Aug 13, 2009 at 02:29:08PM -0400, Forest Bond wrote:
 > Hi,
 > 
 > On Thu, Aug 13, 2009 at 01:25:57PM -0400, Forest Bond wrote:
 > > I'm using an Intel Johnstown board with an Atom N270 processor.  Performance
 > > seems to improve dramatically with acpi-cpufreq loaded.  This caught me by
 > > surprise.  I had assumed that without loading acpi-cpufreq the CPU would be
 > > running at its maximum speed all the time.
 > 
 > I ran some tests to get some numbers.  My findings indicate that before
 > acpi-cpufreq is loaded the CPU is running at 800MHz even though /proc/cpuinfo
 > indicates 1.6GHz.

if no cpufreq modules have been loaded, the CPU will be running at whatever
p-state the BIOS programmed it to start up at. In your case for some reason, that's
the 'slow' speed. 

	Dave

