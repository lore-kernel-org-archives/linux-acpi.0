From: Eugene Teo <eugeneteo@kernel.sg>
Subject: Re: [PATCH] acpi: debugfs: fix buffer overflows, double free
Date: Fri, 21 Jan 2011 17:37:49 +0800
Message-ID: <AANLkTik3TT-0L3OOw2t19tufnOKtLBSCUt91S5V6cg6N@mail.gmail.com>
References: <1295554086-23873-1-git-send-email-segoon@openwall.com>
	<ihbepu$jbj$2@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:62425 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001Ab1AUJhu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Jan 2011 04:37:50 -0500
In-Reply-To: <ihbepu$jbj$2@dough.gmane.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: WANG Cong <xiyou.wangcong@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org

On 1/21/11, WANG Cong <xiyou.wangcong@gmail.com> wrote:
> On Thu, 20 Jan 2011 23:08:06 +0300, Vasiliy Kulikov wrote:
>
>> File position is not controlled, it may lead to overwrites of arbitrary
>> kernel memory.  Also the code may kfree() the same pointer multiple
>> times.
>>
>> One more flaw is still present: if multiple processes open the file then
>> all 3 static variables are shared, leading to various race conditions.
>> They should be moved to file->private_data.
>>
>> Signed-off-by: Vasiliy Kulikov <segoon@openwall.com>
>
> Reviewed-by: WANG Cong <xiyou.wangcong@gmail.com>

Reviewed-by: Eugene Teo <eugeneteo@kernel.org>

Thanks, Eugene
