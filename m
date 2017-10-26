From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH v5 1/2] mailbox: PCC: Move the MAX_PCC_SUBSPACES
 definition to header file
Date: Thu, 26 Oct 2017 15:19:26 -0600
Message-ID: <581addc9-479d-fa50-7f2a-d11803c454fc@codeaurora.org>
References: <1507712098-13035-1-git-send-email-george.cherian@cavium.com>
 <1507712098-13035-2-git-send-email-george.cherian@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:35392 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751305AbdJZVT3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Oct 2017 17:19:29 -0400
In-Reply-To: <1507712098-13035-2-git-send-email-george.cherian@cavium.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: George Cherian <george.cherian@cavium.com>, devel@acpica.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: lv.zheng@intel.com, robert.moore@intel.com, jassisinghbrar@gmail.com, lenb@kernel.org, rjw@rjwysocki.net


On 10/11/2017 2:54 AM, George Cherian wrote:
> Move the MAX_PCC_SUBSPACES definition to acpi/pcc.h file. In preparation to
> add subspace id support for cppc_acpi driver.
>
> Signed-off-by: George Cherian <george.cherian@cavium.com>
Reviewed-by: Prashanth Prakash <pprakash@codeaurora.org>

--
Thanks,
Prashanth
