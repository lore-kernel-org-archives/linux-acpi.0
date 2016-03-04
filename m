From: "Zhang, Haozhong" <haozhong.zhang@intel.com>
Subject: Re: [PATCH v2] nfit: Continue init even if ARS commands are
 unimplemented
Date: Fri, 4 Mar 2016 11:34:51 +0800
Message-ID: <20160304033451.GA6267@hz-desktop.sh.intel.com>
References: <1457044781-15443-1-git-send-email-vishal.l.verma@intel.com>
 <56D900EA.2060802@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:4114 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752995AbcCDDey (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 Mar 2016 22:34:54 -0500
Content-Disposition: inline
In-Reply-To: <56D900EA.2060802@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vishal Verma <vishal.l.verma@intel.com>, Xiao Guangrong <guangrong.xiao@linux.intel.com>
Cc: linux-nvdimm@lists.01.org, linux-acpi@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>

On 03/04/16 11:28, Xiao Guangrong wrote:
> 
> CCed: Haozhong.
> 
> On 03/04/2016 06:39 AM, Vishal Verma wrote:
> >If firmware doesn't implement any of the ARS commands, take that to
> >mean that ARS is unsupported, and continue to initialize regions without
> >bad block lists. We cannot make the assumption that ARS commands will be
> >unconditionally supported on all NVDIMMs.
> >
> >Cc: Dan Williams <dan.j.williams@intel.com>
> >Reported-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> 
> Thank you for the fix, Vishal! it looks good to me.
> 
> However, It is haozhong's credit as he is the one reported the bug not
> me. :)
> 

Thanks! I have tested on QEMU which has not implemented ARS yet and
this patch does work.

Tested-by: Haozhong Zhang <haozhong.zhang@intel.com>
