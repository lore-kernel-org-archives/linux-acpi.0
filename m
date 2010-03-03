From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [patch 2/2] x86: Manage ENERGY_PERF_BIAS based on cpufreq
	governor
Date: Wed, 3 Mar 2010 16:40:07 +0000
Message-ID: <20100303164007.GA31365@srcf.ucam.org>
References: <20100303000649.757684000@intel.com> <20100303000849.278509000@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:55645 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754377Ab0CCQkZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Mar 2010 11:40:25 -0500
Content-Disposition: inline
In-Reply-To: <20100303000849.278509000@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: venkatesh.pallipadi@intel.com
Cc: Ingo Molnar <mingo@elte.hu>, H Peter Anvin <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Len Brown <lenb@kernel.org>, Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Have you done any measurements with this bit being set dynamically by 
ondemand depending on the target frequency?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
