From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH] ACPI / IPMI: allow ACPI_IPMI with IPMI_SSIF
Date: Thu, 23 Mar 2017 10:56:07 -0500
Message-ID: <f444a7c8-037c-d6dd-3cef-769960c95d08@codeaurora.org>
References: <1490284420-26657-1-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1490284420-26657-1-git-send-email-okaya@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 03/23/2017 10:53 AM, Sinan Kaya wrote:
> +	depends on IPMI_SI||IPMI_SSIF

Blank spaces around ||.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
