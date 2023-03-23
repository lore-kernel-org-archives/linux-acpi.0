Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C1FC6FD1C
	for <linux-acpi@archiver.kernel.org>; Thu, 23 Mar 2023 01:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjCWBTt (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 22 Mar 2023 21:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCWBTt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Mar 2023 21:19:49 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3507E2A6F3;
        Wed, 22 Mar 2023 18:19:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VeS86xT_1679534382;
Received: from 30.240.114.229(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VeS86xT_1679534382)
          by smtp.aliyun-inc.com;
          Thu, 23 Mar 2023 09:19:43 +0800
Message-ID: <7a850c66-65de-c98b-4779-b22624f943d8@linux.alibaba.com>
Date:   Thu, 23 Mar 2023 09:19:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH] ACPI: APEI: EINJ: warn on invalid argument when
 explicitly indicated by platform
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>
Cc:     "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        "benjamin.cheatham@amd.com" <benjamin.cheatham@amd.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zhuo.song@linux.alibaba.com" <zhuo.song@linux.alibaba.com>
References: <20230317073310.4237-1-xueshuai@linux.alibaba.com>
 <SJ1PR11MB6083FE558641F0E57FF1F5A4FC869@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CAJZ5v0iX8N9G7yMC3f90JDuHXvdDRcwepcusp0bEctGBhGSnCg@mail.gmail.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <CAJZ5v0iX8N9G7yMC3f90JDuHXvdDRcwepcusp0bEctGBhGSnCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 2023/3/23 AM12:52, Rafael J. Wysocki wrote:
> On Wed, Mar 22, 2023 at 5:13 PM Luck, Tony <tony.luck@intel.com> wrote:
>>
>>> Fix to return -EINVAL in the __einj_error_inject() error handling case
>>> instead of -EBUSY, when explicitly indicated by the platform in the status
>>> of the completed operation.
>>
>> Needs a bit longer description on the use case based on follow up discussion.
>> Key information is the EINVAL is an indicator to the user that the parameters they
>> supplied cannot be used for injection.
> 
> Right.
> 
> So Shuai, please resend the patch with a more elaborate changelog.

Ok, I will do it later.

> 
>> But for the code:
>>
>> Reviewed-by: Tony Luck <tony.luck@intel.com>
> 
> And add the above tag to it when resending.

Got it.

Thank you.

Best Regards.
Shuai
