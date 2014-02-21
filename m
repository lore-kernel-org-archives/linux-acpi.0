From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] ACPI/Processor: Rework processor throttling with
 work_on_cpu()
Date: Fri, 21 Feb 2014 11:06:30 +0100
Message-ID: <20140221100630.GA1121@krava.brq.redhat.com>
References: <20140220151721.GB32719@redhat.com>
 <1392960945-30741-1-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47181 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753331AbaBUKGi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Feb 2014 05:06:38 -0500
Content-Disposition: inline
In-Reply-To: <1392960945-30741-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: tj@kernel.org, oleg@redhat.com, lenb@kernel.org, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Feb 21, 2014 at 01:35:45PM +0800, Lan Tianyu wrote:
> acpi_processor_set_throttling() uses set_cpus_allowed_ptr() to make
> sure struct acpi_processor->acpi_processor_set_throttling() callback
> run on associated cpu. But the function maybe called in a worker which
> has been bound to a cpu. The patch is to replace set_cpus_allowed_ptr()
> with work_on_cpu().

testing the new patch.. so far so good ;-)

jirka
