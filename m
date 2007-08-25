From: Dave Jones <davej@redhat.com>
Subject: Re: 2.6.23-rc3-mm1
Date: Fri, 24 Aug 2007 20:14:54 -0400
Message-ID: <20070825001454.GA23622@redhat.com>
References: <20070822020648.5ea3a612.akpm@linux-foundation.org> <46CF695D.1020008@imap.cc> <20070824170702.a2c51084.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:60014 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761356AbXHYAQo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Aug 2007 20:16:44 -0400
Content-Disposition: inline
In-Reply-To: <20070824170702.a2c51084.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Tilman Schmidt <tilman@imap.cc>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>, Andi Kleen <ak@suse.de>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

On Fri, Aug 24, 2007 at 05:07:02PM -0700, Andrew Morton wrote:

 > > FATAL: Error inserting processor (/lib/modules/2.6.23-rc3-mm1-testing/kernel/drivers/acpi/processor.ko): Input/output error
 > > WARNING: Error inserting processor (/lib/modules/2.6.23-rc3-mm1-testing/kernel/drivers/acpi/processor.ko): Input/output error
 > > 
 > > Aug 25 00:44:00 xenon powersaved[5356]: WARNING (CpufreqManagement:51) No capability cpufreq_control
 > > Aug 25 00:44:00 xenon powersaved[5356]: WARNING (CpufreqManagement:51) No capability cpufreq_control
 > 
 > Dunno, there're some significant-looking cpufreq changes in there, such as
 > cpufreq-allow-ondemand-and-conservative-cpufreq-governors-to-be-used-as-default.patch.
 > Maybe we went and chose a different governor for you?
 
More likely, he was using a cpufreq driver that required acpi
functionality, and because processor.ko went boom, the house of cards
came tumbling down.

I long for the olde days when acpi changes didn't end up with
finger pointing at cpufreq.

	Dave

-- 
http://www.codemonkey.org.uk
