From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH] acpi: add support for extended IRQ to PCI link
Date: Sun, 8 Nov 2015 19:04:05 -0500
Message-ID: <563FE2F5.3050802@codeaurora.org>
References: <1446998832-7023-1-git-send-email-okaya@codeaurora.org>
 <563F7418.4050203@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <563F7418.4050203@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Timur Tabi <timur@codeaurora.org>, linux-acpi@vger.kernel.org, cov@codeaurora.org, jcm@redhat.com
Cc: agross@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org



On 11/8/2015 11:11 AM, Timur Tabi wrote:
> Sinan Kaya wrote:
>> -#define ACPI_MAX_IRQS        256
>> +#define ACPI_MAX_IRQS        1020
>
> Why 1020?  Why not 1024?
>
1020 is the maximum interrupt ID that can be directed to an ARM SPI 
interrupt according to ARM architecture.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
