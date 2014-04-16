From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/5] trace, RAS: Add basic RAS trace event
Date: Wed, 16 Apr 2014 15:10:31 +0200
Message-ID: <20140416131030.GC16741@pd.tnic>
References: <1395985981-20476-1-git-send-email-gong.chen@linux.intel.com>
 <1395985981-20476-2-git-send-email-gong.chen@linux.intel.com>
 <20140409194654.GR6529@pd.tnic>
 <20140416063301.GC11297@gchen.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:49771 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755622AbaDPNKg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Apr 2014 09:10:36 -0400
Content-Disposition: inline
In-Reply-To: <20140416063301.GC11297@gchen.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, m.chehab@samsung.com, rostedt@goodmis.org, linux-acpi@vger.kernel.org, arozansk@redhat.com

On Wed, Apr 16, 2014 at 02:33:01AM -0400, Chen, Gong wrote:
> On Wed, Apr 09, 2014 at 09:46:54PM +0200, Borislav Petkov wrote:
> > 
> > menuconfig RAS
> > 	bool "Reliability, Availability, Serviceability features"
> > 	help
> > 	  <A nice text about what this is going to contain, i.e. RAS stuff
> > 
> How about this:

Good. Just nitpicks below:

>          Reliability, availability, and serviceability (RAS) is a computer
>          hardware engineering term. Computers designed with higher levels
>          of RAS have a multitude of features that protect data integrity
>          and help them stay available for long periods of time without
>          failure.
> 
>          Reliability can be defined as the probability that it will produce

s/it/the system/. "it" is kinda misleading as to what we refer to.

>          correct outputs up to some given time. Reliability is enhanced by
>          features that help to avoid, detect and repair hardware faults.
> 
>          Availability is the probability a system is operational at a given
>          time, i.e. the amount of time a device is actually operating as the
>          percentage of total time it should be operating.
> 
>          Serviceability or maintainability is the simplicity and speed with
>          which a system can be repaired or maintained; if the time to repair
>          a failed system increases, then availability will decrease.

Nice!

>          Note that reliability and availability are distinct concepts:

capitalized: ... that Reliability and Availability are ...

>          Reliability is a measure of the ability of a system to function
>          correctly, including avoiding data corruption, whereas availability

ditto: Availability

>          measures how often it is available for use, even though it may not
>          be functioning correctly. For example, a server may run forever and
>          so have ideal availability, but may be unreliable, with frequent
>          data corruption.

Very good description! :-)

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
