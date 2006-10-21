From: Dave Jones <davej@redhat.com>
Subject: Re: [patch 8/8] acpi-cpufreq: remove dead code
Date: Sat, 21 Oct 2006 01:31:39 -0400
Message-ID: <20061021053139.GA24927@redhat.com>
References: <200610202130.k9KLUUfN003257@shell0.pdx.osdl.net> <200610210128.07621.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:52685 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932222AbWJUFcO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 21 Oct 2006 01:32:14 -0400
Content-Disposition: inline
In-Reply-To: <200610210128.07621.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: akpm@osdl.org, linux-acpi@vger.kernel.org

On Sat, Oct 21, 2006 at 01:28:06AM -0400, Len Brown wrote:
 > I would expect to see this same change in both speedstep-centrino.c and acpi-cpufreq.c, no?

Indeed, especially as longterm acpi-cpufreq is going to be the
more interesting of the two.

I'll merge this patch up though, and make the acpi-cpufreq change myself.

Thanks,

	Dave
 
-- 
http://www.codemonkey.org.uk
