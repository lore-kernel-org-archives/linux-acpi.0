From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH 0/6] cpufreq: Add sampling window to enhance ondemand
	governor power efficiency
Date: Thu, 23 Dec 2010 14:42:20 +0000
Message-ID: <20101223144220.GB1402@srcf.ucam.org>
References: <1293085424-18212-1-git-send-email-youquan.song@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:42453 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822Ab0LWOme (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Dec 2010 09:42:34 -0500
Content-Disposition: inline
In-Reply-To: <1293085424-18212-1-git-send-email-youquan.song@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Youquan Song <youquan.song@intel.com>
Cc: davej@redhat.com, cpufreq@vger.kernel.org, venki@google.com, arjan@linux.intel.com, lenb@kernel.org, suresh.b.siddha@intel.com, kent.liu@intel.com, chaohong.guo@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Youquan Song <youquan.song@linux.intel.com>

We've generally been assuming (rightly or wrongly) that getting into 
deep C states is preferable to being active (even at a lower frequency), 
and so the current behaviour of tending to rapidly switch to the maximum 
P state isn't inherently a problem. What kind of power savings are you 
benchmarking with this, and do you still see a saving if you just 
disable turbo mode?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
