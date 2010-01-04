From: "Youquan,Song" <youquan.song@linux.intel.com>
Subject: Re: [PATCH]tickless: Fix tick nohz timer irq0 fail to increaase
Date: Mon, 4 Jan 2010 17:02:21 -0500
Message-ID: <20100104220221.GB16579@youquan-linux.bj.intel.com>
References: <20091214130233.GA3898@youquan-linux.bj.intel.com> <20100104104905.GA30574@youquan-linux.bj.intel.com> <20100104043650.6acfb056@infradead.org> <1262613649.6408.164.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:4426 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752193Ab0ADO12 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Jan 2010 09:27:28 -0500
Content-Disposition: inline
In-Reply-To: <1262613649.6408.164.camel@laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Arjan van de Ven <arjan@infradead.org>, "Youquan,Song" <youquan.song@linux.intel.com>, hpa@zytor.com, tglx@linutronix.de, akpm@linux-foundation.org, venkatesh.pallipadi@intel.com, suresh.b.siddha@intel.com, kent.liu@intel.com, chaohong.guo@intel.com, youquan.song@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "jens.axboe" <jens.axboe@oracle.com>

> Disabling nohz is funny indeed, one wonders why he does that.
I do not have real case for it. I look at nohz=off because 
1. OSV has such release notes to explain how to disable tickless.  
2. with some OSV config + latest kernel, it will result in kernel 
oops and it config disable tickless. I have reported it to acpi maillist
before.

Thanks.

-Youquan

