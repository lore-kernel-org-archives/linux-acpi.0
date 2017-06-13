From: George Cherian <gcherian@caviumnetworks.com>
Subject: Re: [PATCH-internal 0/2] Make cppc acpi driver aware of pcc subspace
 ids
Date: Tue, 13 Jun 2017 19:46:03 +0530
Message-ID: <593FF3A3.9060006@caviumnetworks.com>
References: <1497363313-9936-1-git-send-email-george.cherian@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bn3nam01on0049.outbound.protection.outlook.com ([104.47.33.49]:7309
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752515AbdFMOQY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 13 Jun 2017 10:16:24 -0400
In-Reply-To: <1497363313-9936-1-git-send-email-george.cherian@cavium.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: George Cherian <george.cherian@cavium.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, devel@acpica.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, jassisinghbrar@gmail.com, robert.moore@intel.com, lv.zheng@intel.com

Sorry Ignore this series!!!

On 06/13/2017 07:45 PM, George Cherian wrote:
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
>            driver
> Patch 2 : Make the cppc acpi driver aware of multiple pcc subspace ids.
>
>
> George Cherian (2):
>    mailbox: PCC: Move the MAX_PCC_SUBSPACES definition to header file
>    ACPI / CPPC: Make cppc acpi driver aware of pcc subspace ids
>
>   drivers/acpi/cppc_acpi.c | 179 +++++++++++++++++++++++++----------------------
>   drivers/mailbox/pcc.c    |   1 -
>   include/acpi/pcc.h       |   1 +
>   3 files changed, 97 insertions(+), 84 deletions(-)
>
