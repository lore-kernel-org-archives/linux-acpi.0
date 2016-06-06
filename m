From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: ACPICA: ACPI 2.0, Interpreter: Fix MLC issues by switching to
 new TermList grammar for table loading
Date: Mon, 6 Jun 2016 13:24:56 +0300
Message-ID: <20160606102456.GA32247@mwanda>
References: <20160604140415.GA3344@mwanda>
 <1AE640813FDE7649BE1B193DEA596E883BBB9B78@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:18022 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951AbcFFKYt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Jun 2016 06:24:49 -0400
Content-Disposition: inline
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E883BBB9B78@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, Jun 06, 2016 at 10:05:12AM +0000, Zheng, Lv wrote:
> Hi, Dan
> 
> Thanks for the report.
> I'll double check it with C=2 enabled build.

It's a Smatch warning.

regards,
dan carpenter

