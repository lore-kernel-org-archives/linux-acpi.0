From: Max Asbock <masbock@linux.vnet.ibm.com>
Subject: Re: APEI: ERST table in ACPI NVS not supported
Date: Mon, 04 Feb 2013 09:06:24 -0800
Message-ID: <510FEA90.8060503@linux.vnet.ibm.com>
References: <5108100B.9040907@linux.vnet.ibm.com> <20130204092018.GA22035@gchen.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139]:41447 "EHLO e9.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753654Ab3BDRIP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 4 Feb 2013 12:08:15 -0500
Received: from /spool/local
	by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <masbock@linux.vnet.ibm.com>;
	Mon, 4 Feb 2013 12:08:14 -0500
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 12B69C90045
	for <linux-acpi@vger.kernel.org>; Mon,  4 Feb 2013 12:08:13 -0500 (EST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r14H8C91287522
	for <linux-acpi@vger.kernel.org>; Mon, 4 Feb 2013 12:08:12 -0500
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r14H6p81004348
	for <linux-acpi@vger.kernel.org>; Mon, 4 Feb 2013 10:06:51 -0700
In-Reply-To: <20130204092018.GA22035@gchen.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: gong.chen@intel.com, linux-acpi@vger.kernel.org, ying.huang@intel.com, naveen.n.rao@in.ibm.com

On 02/04/2013 01:20 AM, Chen Gong wrote:
> On Tue, Jan 29, 2013 at 10:08:11AM -0800, Max Asbock wrote:
>
>
> we have systems that declare the memory range for ERST in ACPI NVS.
> Because ACPI NVS is marked 'busy' by e820_reserve_resources() the
> call to request_mem_region(erst_erange.base, erst_erange.size, "APEI
> ERST") made from erst_init() fails and we get:
> ERST: Can not request iomem region<0x        7e91f000-0x
> 7e920c00>  for ERST.
>
> I did notice that quite some effort was made to add code to avoid
> resource conflicts between APEI and ACPI NVS. But ERST still goes
> straight to request_mem_region() which is bound to fail. I am
> assuming this should go through apei_resources_request() instead or
> I am missing something?
>
> If my understanding is right, after ERST resource is requested via
> apei_resources_request and when requesting error log address range,
> you meet an NVS conflict, right?
>
> If so, NVS must be excluded. But I'm afraid if error range is
> separated into two parts thus some errors will be lost. Would you
> please paste errage address range and conflicted NVS range?
ACPI NVS is:

[    0.000000] BIOS-e820: [mem 0x000000007e6a5000-0x000000007ebc5fff] 
ACPI NVS

ERST erange is:

0x7e91f000-0x7e920c00

which is a single range entirely within ACPI NVS.

thanks,
Max



