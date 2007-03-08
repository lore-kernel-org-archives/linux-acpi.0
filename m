From: Meelis Roos <mroos@linux.ee>
Subject: Re: 2.6.21-rc1: more ACPI errors (EC__)
Date: Thu, 8 Mar 2007 17:48:22 +0200 (EET)
Message-ID: <Pine.SOC.4.64.0703081743160.17040@math>
References: <Pine.SOC.4.64.0702260842260.9705@math> <45EAA003.7020504@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.it.da.ut.ee ([193.40.5.67]:42871 "EHLO smtp2.it.da.ut.ee"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752276AbXCHPsY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 Mar 2007 10:48:24 -0500
In-Reply-To: <45EAA003.7020504@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

> please take a look at 8066 bug and patches there.

Tried patch from #9 there (with 21-rc3) and it seems to cure the problem 
for me (with IBM X20). Thanks!

-- 
Meelis Roos (mroos@linux.ee)
