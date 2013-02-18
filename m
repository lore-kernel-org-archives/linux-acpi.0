From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2] APM idle: register apm_cpu_idle via cpuidle
Date: Mon, 18 Feb 2013 14:30:34 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1302181429570.17024@pobox.suse.cz>
References: <5118B776.6090604@linaro.org> <1360623789-12247-1-git-send-email-lenb@kernel.org> <17242de27db147c4f828d6089016e1f485c038fb.1360623445.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57817 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751073Ab3BRNam (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 18 Feb 2013 08:30:42 -0500
In-Reply-To: <17242de27db147c4f828d6089016e1f485c038fb.1360623445.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

On Mon, 11 Feb 2013, Len Brown wrote:

> From: Len Brown <len.brown@intel.com>
> 
> Update APM to register its local idle routine with cpuidle.
> 
> This allows us to stop exporting pm_idle to modules on x86.
> 
> The Kconfig sub-option, APM_CPU_IDLE, now depends on on CPU_IDLE.
> 
> Compile-tested only.

I will test it on APM hardware and report back to you.

Do you then want me to take it through my tree, or are you going to push 
the whole patchset as a whole?

-- 
Jiri Kosina
SUSE Labs
