From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH 0/2] Make cppc acpi driver aware of pcc subspace ids
Date: Mon, 3 Apr 2017 10:44:29 -0600
Message-ID: <ccc72eec-4a43-b976-0195-49a7c0029641@codeaurora.org>
References: <1490941442-11954-1-git-send-email-george.cherian@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:42114 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753022AbdDCQoc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Apr 2017 12:44:32 -0400
In-Reply-To: <1490941442-11954-1-git-send-email-george.cherian@cavium.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: George Cherian <george.cherian@cavium.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, devel@acpica.org
Cc: ashwin.chaugule@linaro.org, rjw@rjwysocki.net, lenb@kernel.org, jassisinghbrar@gmail.com, robert.moore@intel.com, lv.zheng@intel.com

Hi George,

On 3/31/2017 12:24 AM, George Cherian wrote:
> The current cppc acpi driver works with only one pcc subspace id.
> It maintains and registers only one pcc channel even if the acpi table has 
> different pcc subspace ids. The series tries to address the same by making 
> cppc acpi driver aware of multiple possible pcc subspace ids.
The current ACPI 6.1 spec restricts the CPPC to a single PCC subspace. See section:
8.4.7.1.9 Using PCC Registers, which states "If the PCC register space is used, all PCC
registers must be defined to be in the same subspace."

--
Thanks,
Prashanth
