From: gengdongjiu <gengdongjiu@huawei.com>
Subject: Re: [PATCH] acpi: apei: fix the wrongly parse generic error status
 block
Date: Tue, 15 Aug 2017 09:14:34 +0800
Message-ID: <250ab5f5-7eb7-5339-f895-a77837721467@huawei.com>
References: <1502388412-20273-1-git-send-email-gengdongjiu@huawei.com>
 <9ea70eed-f743-0c8b-2a70-27ce4c0d8705@codeaurora.org>
 <ddb2070d-60c5-a476-c003-25814d0cf863@huawei.com>
 <1be489f7-c1c3-63dc-dc0d-af67e5fd03a1@huawei.com>
 <70ebfc99-0666-fa2b-8ed4-19e1f93194bd@codeaurora.org>
 <CAMj-D2DqEafgnOCsRjm8fSkj_R7_HWPnBxEijhoUV_LnU7VY6Q@mail.gmail.com>
 <571aed7f-39aa-b5f0-1ea2-2e57a588d22f@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:3082 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752839AbdHOBO7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Aug 2017 21:14:59 -0400
In-Reply-To: <571aed7f-39aa-b5f0-1ea2-2e57a588d22f@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Baicar, Tyler" <tbaicar@codeaurora.org>, gengdongjiu <gengdj.1984@gmail.com>
Cc: rjw@rjwysocki.net, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,Tyler,
   Yes, I will add a patch based on it, thanks a lot that you will also have a test.


On 2017/8/14 22:04, Baicar, Tyler wrote:
> This change works too, I think it just makes sense to have the iterations in the CPER and GHES code match. Do you want to add a patch to your patch here to change the CPER code as well? If so, I'll wait for that and test it out.
> 
> Thanks,
> Tyler

