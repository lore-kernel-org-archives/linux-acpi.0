From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/2] Make cppc acpi driver aware of pcc subspace ids
Date: Wed, 28 Jun 2017 23:20:13 +0200
Message-ID: <2438938.qNZk1AErMU@aspire.rjw.lan>
References: <1497363431-10002-1-git-send-email-george.cherian@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:42430 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751581AbdF1V1k (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 28 Jun 2017 17:27:40 -0400
In-Reply-To: <1497363431-10002-1-git-send-email-george.cherian@cavium.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: George Cherian <george.cherian@cavium.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, devel@acpica.org, lenb@kernel.org, jassisinghbrar@gmail.com, robert.moore@intel.com, lv.zheng@intel.com, Prashanth Prakash <pprakash@codeaurora.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Ashwin Chaugule <ashwinch@google.com>

On Tuesday, June 13, 2017 02:17:09 PM George Cherian wrote:
> The current cppc acpi driver works with only one pcc subspace id.
> It maintains and registers only one pcc channel even if the acpi table has 
> different pcc subspace ids. 
> 
> As per ACPI 6.2 spec  all PCC registers, for all processors in the same 
> performance domain (as defined by _PSD), must be defined to be in the same
> subspace. The series tries to address the same by making cppc acpi driver 
> aware of multiple possible pcc subspace ids.
> 
> Patch 1 : In preparation to share the MAX_PCC_SUBSPACE definition with cppc acpi
>           driver
> Patch 2 : Make the cppc acpi driver aware of multiple pcc subspace ids.
> 
> 
> George Cherian (2):
>   mailbox: PCC: Move the MAX_PCC_SUBSPACES definition to header file
>   ACPI / CPPC: Make cppc acpi driver aware of pcc subspace ids
> 
>  drivers/acpi/cppc_acpi.c | 179 +++++++++++++++++++++++++----------------------
>  drivers/mailbox/pcc.c    |   1 -
>  include/acpi/pcc.h       |   1 +
>  3 files changed, 97 insertions(+), 84 deletions(-)

I need Ashwing and Prashanth to look at this series and let me know what they
think.

Thanks,
Rafael

