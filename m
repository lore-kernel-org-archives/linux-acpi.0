From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/4] acpi: change cpufreq tables to per_cpu variables
Date: Tue, 12 Feb 2008 15:33:56 -0800
Message-ID: <20080212153356.d2be3248.akpm@linux-foundation.org>
References: <20080208233738.108449000@polaris-admin.engr.sgi.com>
	<20080208233738.427702000@polaris-admin.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:41055 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759301AbYBLXef (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 Feb 2008 18:34:35 -0500
In-Reply-To: <20080208233738.427702000@polaris-admin.engr.sgi.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mike Travis <travis@sgi.com>
Cc: mingo@elte.hu, tglx@linutronix.de, ak@suse.de, clameter@sgi.com, steiner@sgi.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, len.brown@intel.com, linux-acpi@vger.kernel.org

On Fri, 08 Feb 2008 15:37:40 -0800
Mike Travis <travis@sgi.com> wrote:

> Change cpufreq tables from arrays to per_cpu variables in
> drivers/acpi/processor_thermal.c
> 
> Based on linux-2.6.git + x86.git

I fixed a bunch of rejects in "[PATCH 1/4] cpufreq: change cpu freq tables
to per_cpu variables" and it compiles OK.  But this one was beyond my
should-i-repair-it threshold, sorry.

