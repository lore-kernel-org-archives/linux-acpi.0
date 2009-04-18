From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 4/8] acpi-cpufreq: Do not let get_measured perf depend on internal variable
Date: Sat, 18 Apr 2009 11:49:36 +0200
Message-ID: <200904181149.37228.trenn@suse.de>
References: <1239978132-6261-1-git-send-email-trenn@suse.de> <1239978132-6261-5-git-send-email-trenn@suse.de> <1239989077.4529.8644.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42033 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751253AbZDRJs7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 18 Apr 2009 05:48:59 -0400
In-Reply-To: <1239989077.4529.8644.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>

On Friday 17 April 2009 07:24:37 pm Pallipadi, Venkatesh wrote:
> Ack.
>
> I am not sure below printk is adding much value though, considering
> cpufreq_frequency_table_cpuinfo() that is initializing cpuinfo.max_freq
> is getting called just one line before this code.
It handles the BIOS bug case that P0 is not max_freq.
It should never happen...
Better would be to check at _PSS call time that all frequencies
are in the right order and throw a FW_BUG then (if that is not done already). 

Len can you apply this with the last hunk thrown out then, please.

Thanks,

    Thomas
