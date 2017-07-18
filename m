From: Jeffrey Hugo <jhugo@codeaurora.org>
Subject: Re: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Tue, 18 Jul 2017 08:39:49 -0600
Message-ID: <c6b2f416-964f-2283-56b6-899485f39652@codeaurora.org>
References: <20170717215912.26070-1-toshi.kani@hpe.com>
 <20170717215912.26070-4-toshi.kani@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:42174 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751499AbdGROjx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Jul 2017 10:39:53 -0400
In-Reply-To: <20170717215912.26070-4-toshi.kani@hpe.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Toshi Kani <toshi.kani@hpe.com>, rjw@rjwysocki.net, bp@alien8.de
Cc: mchehab@kernel.org, tglx@linutronix.de, srinivas.pandruvada@linux.intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org

On 7/17/2017 3:59 PM, Toshi Kani wrote:
> The ghes_edac driver was introduced in 2013 [1], but it has not
> been enabled by any distro yet.   

Ubuntu is expected to enable this soon.

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
