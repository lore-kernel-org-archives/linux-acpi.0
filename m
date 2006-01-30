From: Bruno Ducrot <ducrot@poupinou.org>
Subject: Re: UBUNTU - acpi battery on ACER TRAVELMATE 4000 WLMI
Date: Mon, 30 Jan 2006 12:25:28 +0100
Message-ID: <20060130112528.GA18195@poupinou.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005DD43C6@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from poup.poupinou.org ([195.101.94.96]:57908 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP id S932192AbWA3L04
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 30 Jan 2006 06:26:56 -0500
Content-Disposition: inline
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3005DD43C6@hdsmsx401.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

Hi Len,

On Fri, Jan 27, 2006 at 02:05:23PM -0500, Brown, Len wrote:
> Also, you may find that the current speedstep-centrino
> is able to load on this system.  Without hard-coded tables
> for this processor family/model/stepping, it too would use
> the ACPI PSS, but it would use native MSR access, which
> is lower overhead than the IO port access used by acpi-cpufreq.
> (in the future, acpi-cpufreq and speedstep-centrino should
> be combined into a single driver)

Do you mean you want to combine all possible drivers into only
one?  That is at that time of writing:

acpi-cpufreq (IO version), speedstep-centrino, powernow-k7
and powernow-k8?

Well, it might be possible that some cpufreq devellopers
would be against this approach I'm afraid.

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
