From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/1] ACPI: ghes: Remove redundant platform_set_drvdata()
Date: Tue, 4 Jun 2013 09:04:07 +0530
Message-ID: <CAK9yfHwU-Xfy_K9cLXRX-cRssANZZ040DSe86O=JL9_riUvs-w@mail.gmail.com>
References: <1369827977-29975-1-git-send-email-sachin.kamat@linaro.org>
	<20130604031828.GA20448@gchen.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:48795 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756871Ab3FDDeI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Jun 2013 23:34:08 -0400
Received: by mail-ob0-f171.google.com with SMTP id dn14so8605778obc.30
        for <linux-acpi@vger.kernel.org>; Mon, 03 Jun 2013 20:34:07 -0700 (PDT)
In-Reply-To: <20130604031828.GA20448@gchen.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-acpi@vger.kernel.org, rjw@sisk.pl, lenb@kernel.org, Huang Ying <ying.huang@intel.com>, gong.chen@linux.intel.com

On 4 June 2013 08:48, Chen Gong <gong.chen@linux.intel.com> wrote:
> On Wed, May 29, 2013 at 05:16:17PM +0530, Sachin Kamat wrote:
>> Date: Wed, 29 May 2013 17:16:17 +0530
>> From: Sachin Kamat <sachin.kamat@linaro.org>
>> To: linux-acpi@vger.kernel.org
>> Cc: rjw@sisk.pl, lenb@kernel.org, sachin.kamat@linaro.org, Huang Ying
>>  <ying.huang@intel.com>
>> Subject: [PATCH 1/1] ACPI: ghes: Remove redundant platform_set_drvdata()
>> X-Mailer: git-send-email 1.7.9.5
>>
>> Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
>> driver is bound) removes the need to set driver data field to
>> NULL.
>>
> Your description doesn't give any meaningful explanation.

It just means that setting driver data to NULL is not necessary.

-- 
With warm regards,
Sachin
