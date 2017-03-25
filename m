From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH] ACPI / IPMI: allow ACPI_IPMI with IPMI_SSIF
Date: Sat, 25 Mar 2017 10:03:33 -0400
Message-ID: <2b8eeebf-9ea0-70f7-8f34-d6f2f88106ed@codeaurora.org>
References: <1490284420-26657-1-git-send-email-okaya@codeaurora.org>
 <78897278-9240-6794-e99b-f3ff3013304f@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:47556 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751271AbdCYODn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 25 Mar 2017 10:03:43 -0400
In-Reply-To: <78897278-9240-6794-e99b-f3ff3013304f@acm.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: minyard@acm.org, linux-acpi@vger.kernel.org, timur@codeaurora.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org

On 3/24/2017 10:56 PM, Corey Minyard wrote:
> Oops, yes, this is an issue.
> 
> However, it should probably depend on IPMI_HANDLER, not the individual interface types.
> 

Thanks for the review. I posted V3 with your recommendation.

> -corey


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
