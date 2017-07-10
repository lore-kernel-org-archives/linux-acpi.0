From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH 0/2] Make cppc acpi driver aware of pcc subspace ids
Date: Mon, 10 Jul 2017 16:07:47 -0600
Message-ID: <3533fce6-2616-aad4-cee3-a9ff38ed37d9@codeaurora.org>
References: <1497363431-10002-1-git-send-email-george.cherian@cavium.com>
 <2438938.qNZk1AErMU@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:58902 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754221AbdGJWHu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Jul 2017 18:07:50 -0400
In-Reply-To: <2438938.qNZk1AErMU@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, George Cherian <george.cherian@cavium.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, devel@acpica.org, lenb@kernel.org, jassisinghbrar@gmail.com, robert.moore@intel.com, lv.zheng@intel.com, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Ashwin Chaugule <ashwinch@google.com>


On 6/28/2017 3:20 PM, Rafael J. Wysocki wrote:
> On Tuesday, June 13, 2017 02:17:09 PM George Cherian wrote:
>> The current cppc acpi driver works with only one pcc subspace id.
>> It maintains and registers only one pcc channel even if the acpi table has 
>> different pcc subspace ids. 
>>
>> As per ACPI 6.2 spec  all PCC registers, for all processors in the same 
>> performance domain (as defined by _PSD), must be defined to be in the same
>> subspace. The series tries to address the same by making cppc acpi driver 
>> aware of multiple possible pcc subspace ids.
>>
>> Patch 1 : In preparation to share the MAX_PCC_SUBSPACE definition with cppc acpi
>>           driver
>> Patch 2 : Make the cppc acpi driver aware of multiple pcc subspace ids.
>>
>>
>> George Cherian (2):
>>   mailbox: PCC: Move the MAX_PCC_SUBSPACES definition to header file
>>   ACPI / CPPC: Make cppc acpi driver aware of pcc subspace ids
>>
>>  drivers/acpi/cppc_acpi.c | 179 +++++++++++++++++++++++++----------------------
>>  drivers/mailbox/pcc.c    |   1 -
>>  include/acpi/pcc.h       |   1 +
>>  3 files changed, 97 insertions(+), 84 deletions(-)
> I need Ashwing and Prashanth to look at this series and let me know what they
> think.
Rafael/George,

I was on vacation last few weeks, I will go through this series this week and provide
feedback. Sorry about the delay.

--
Thanks,
Prashanth
