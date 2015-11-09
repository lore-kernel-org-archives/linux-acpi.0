From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH] acpi: add support for extended IRQ to PCI link
Date: Sun, 8 Nov 2015 18:05:48 -0600
Message-ID: <563FE35C.6020504@codeaurora.org>
References: <1446998832-7023-1-git-send-email-okaya@codeaurora.org>
 <563F7418.4050203@codeaurora.org> <563FE2F5.3050802@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:60235 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751421AbbKIAFw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 8 Nov 2015 19:05:52 -0500
In-Reply-To: <563FE2F5.3050802@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org, cov@codeaurora.org, jcm@redhat.com
Cc: agross@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org

Sinan Kaya wrote:
>>
> 1020 is the maximum interrupt ID that can be directed to an ARM SPI
> interrupt according to ARM architecture.

IMHO, that's something that belongs in the patch description.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
