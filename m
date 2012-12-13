From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [RFC PATCH 02/11] drivers/base: Add hotplug framework code
Date: Wed, 12 Dec 2012 21:02:45 -0700
Message-ID: <1355371365.18964.89.camel@misato.fc.hp.com>
References: <1355354243-18657-1-git-send-email-toshi.kani@hp.com>
	 <1355354243-18657-3-git-send-email-toshi.kani@hp.com>
	 <20121212235418.GB22764@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:31056 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753698Ab2LMELr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Dec 2012 23:11:47 -0500
In-Reply-To: <20121212235418.GB22764@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: rjw@sisk.pl, lenb@kernel.org, akpm@linux-foundation.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, bhelgaas@google.com, isimatu.yasuaki@jp.fujitsu.com, jiang.liu@huawei.com, wency@cn.fujitsu.com, guohanjun@huawei.com, yinghai@kernel.org, srivatsa.bhat@linux.vnet.ibm.com

On Wed, 2012-12-12 at 15:54 -0800, Greg KH wrote:
> On Wed, Dec 12, 2012 at 04:17:14PM -0700, Toshi Kani wrote:
> > Added hotplug.c, which is the hotplug framework code.
> 
> Again, better naming please.

Yes, I will change it to be more specific, something like
"sys_hotplug.c".

Thanks,
-Toshi

