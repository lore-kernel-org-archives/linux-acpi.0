From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH 6/6] cpufreq: Evaluate P1 before enter turbo mode
Date: Thu, 23 Dec 2010 14:38:59 +0000
Message-ID: <20101223143859.GA1402@srcf.ucam.org>
References: <1293085424-18212-1-git-send-email-youquan.song@intel.com> <1293085424-18212-2-git-send-email-youquan.song@intel.com> <1293085424-18212-3-git-send-email-youquan.song@intel.com> <1293085424-18212-4-git-send-email-youquan.song@intel.com> <1293085424-18212-5-git-send-email-youquan.song@intel.com> <1293085424-18212-6-git-send-email-youquan.song@intel.com> <1293085424-18212-7-git-send-email-youquan.song@intel.com> <20101223105730.GB18363@comet.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:36732 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752527Ab0LWOjQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Dec 2010 09:39:16 -0500
Content-Disposition: inline
In-Reply-To: <20101223105730.GB18363@comet.dominikbrodowski.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>, Youquan Song <youquan.song@intel.com>, davej@redhat.com, cpufreq@vger.kernel.org, venki@google.com, arjan@linux.intel.com, lenb@kernel.

On Thu, Dec 23, 2010 at 11:57:30AM +0100, Dominik Brodowski wrote:

> NACK. First of all, why is it only a "turbo mode" if it's 1000 kHz
> difference?

I believe that that's how it's supposed to be defined for Intel systems, 
but you're right that this doesn't belong in generic code. AMD have 
support for enabling/disabling their equivalent functionality through 
sysfs - I'd say that copying that interface and using it to limit the 
set of p-states provided to the core makes more sense.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
