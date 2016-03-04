From: Xiao Guangrong <guangrong.xiao@linux.intel.com>
Subject: Re: [PATCH v2] nfit: Continue init even if ARS commands are
 unimplemented
Date: Fri, 4 Mar 2016 11:28:42 +0800
Message-ID: <56D900EA.2060802@linux.intel.com>
References: <1457044781-15443-1-git-send-email-vishal.l.verma@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:4983 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755790AbcCDD27 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 Mar 2016 22:28:59 -0500
In-Reply-To: <1457044781-15443-1-git-send-email-vishal.l.verma@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vishal Verma <vishal.l.verma@intel.com>, linux-nvdimm@lists.01.org
Cc: linux-acpi@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, "Zhang, Haozhong" <haozhong.zhang@intel.com>


CCed: Haozhong.

On 03/04/2016 06:39 AM, Vishal Verma wrote:
> If firmware doesn't implement any of the ARS commands, take that to
> mean that ARS is unsupported, and continue to initialize regions without
> bad block lists. We cannot make the assumption that ARS commands will be
> unconditionally supported on all NVDIMMs.
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Reported-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>

Thank you for the fix, Vishal! it looks good to me.

However, It is haozhong's credit as he is the one reported the bug not
me. :)

