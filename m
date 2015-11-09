From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH] acpi: add support for extended IRQ to PCI link
Date: Mon, 9 Nov 2015 07:50:48 -0600
Message-ID: <5640A4B8.9020602@codeaurora.org>
References: <1446998832-7023-1-git-send-email-okaya@codeaurora.org>
 <56402E23.1070805@linux.intel.com> <56403311.2020806@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56403311.2020806@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>, Jiang Liu <jiang.liu@linux.intel.com>, linux-acpi@vger.kernel.org, cov@codeaurora.org, jcm@redhat.com
Cc: agross@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Sinan Kaya wrote:
>
> I'm concerned about this though since you warned. This used to consume
> 1024 bytes now 4096 bytes.
>
> static int acpi_irq_penalty[ACPI_MAX_IRQS] = {
>      PIRQ_PENALTY_ISA_ALWAYS,    /* IRQ0 timer */
> ...
> }

As long as it's not ever put on the stack, it should be fine.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
