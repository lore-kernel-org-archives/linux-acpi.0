From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 8/8] ACPI / trace: Add trace interface for eMCA driver
Date: Tue, 15 Oct 2013 22:24:35 +0530
Message-ID: <20131015165435.GA2777@naverao1-tp.ibm.com>
References: <1381473166-29303-1-git-send-email-gong.chen@linux.intel.com>
 <1381473166-29303-9-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e28smtp08.in.ibm.com ([122.248.162.8]:38338 "EHLO
	e28smtp08.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932874Ab3JOQy7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Oct 2013 12:54:59 -0400
Received: from /spool/local
	by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
	Tue, 15 Oct 2013 22:24:56 +0530
Content-Disposition: inline
In-Reply-To: <1381473166-29303-9-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, bp@alien8.de, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, m.chehab@samsung.com

On 2013/10/11 02:32AM, Chen Gong wrote:
> Use trace interface to elaborate all H/W error related
> information.
> 
> Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
> ---
<snip>
> +TRACE_EVENT(extlog_mem_event,
> +	TP_PROTO(u32 etype,
> +		char *dimm_loc,
> +		const uuid_le *fru_id,
> +		char *fru_text,
> +		u64 error_count,
> +		u32 severity,
> +		u64 phy_addr,
> +		char *mem_loc),

[Adding Mauro...]

This looks very similar to the trace event I wrote a while back,
which was similar to the one provided by ghes_edac:
http://thread.gmane.org/gmane.linux.kernel.pci/24616

Seems to me this has the same issues we previously discussed w.r.t
EDAC conflicts...


Regards,
Naveen

