From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: Re: [PATCH 6/6] acpi: Return -ENOENT in acpi_table_parse() and fix
 wrong comment.
Date: Tue, 20 Aug 2013 09:19:34 +0800
Message-ID: <5212C426.7020006@cn.fujitsu.com>
References: <1376636809-10159-1-git-send-email-tangchen@cn.fujitsu.com>  <1376636809-10159-7-git-send-email-tangchen@cn.fujitsu.com> <1376940579.10300.474.camel@misato.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:28606 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751326Ab3HTBUx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 19 Aug 2013 21:20:53 -0400
In-Reply-To: <1376940579.10300.474.camel@misato.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Toshi Kani <toshi.kani@hp.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, lenb@kernel.org, rjw@sisk.pl, liwanp@linux.vnet.ibm.com, tj@kernel.org, akpm@linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On 08/20/2013 03:29 AM, Toshi Kani wrote:
> On Fri, 2013-08-16 at 15:06 +0800, Tang Chen wrote:
>> The comment about return value of acpi_table_parse() is incorrect.
>> This patch fix it.
>>
>> Furthermore, if the table is not found, return 1 means nothing, and
>> make it difficult to write the comment. So return -ENOENT when the
>> table is not found, and correct the comment.
>
> I am OK with the change, but the above description is not very clear.
> You should state that all callers only check if the function succeeded
> or not.  So, you are simplifying the semantics by returning -errno for
> all failure cases.
>
> Since you are making this change, I'd suggest you also update the stub
> function in linux/acpi.h to return -ENODEV as well.

OK, followed. And will merge patch 3 and 4 and resend them later.

Thanks for reviewing.


