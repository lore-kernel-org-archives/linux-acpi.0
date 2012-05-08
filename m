From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/2] x86/acpi: Call acpi_enter_sleep_state via an asmlinkage
 C function from assembler.
Date: Tue, 08 May 2012 02:35:25 -0400
Message-ID: <4FA8BEAD.8070806@kernel.org>
References: <1334769518-7660-1-git-send-email-konrad.wilk@oracle.com> <1334769518-7660-3-git-send-email-konrad.wilk@oracle.com> <4F8F28BF.6010003@zytor.com> <201204182302.51868.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:59182 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181Ab2EHGf3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 May 2012 02:35:29 -0400
In-Reply-To: <201204182302.51868.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, ming.m.lin@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org, "Brown, Len" <len.brown@intel.com>

On 04/18/2012 05:02 PM, Rafael J. Wysocki wrote:

> On Wednesday, April 18, 2012, H. Peter Anvin wrote:
>> On 04/18/2012 10:18 AM, Konrad Rzeszutek Wilk wrote:
>>>
>>> Suggested-by: H. Peter Anvin <hpa@zytor.com>
>>> [v2: Remove extra assembler operations, per hpa review]
>>> Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>>
>> Reviewed-by: H. Peter Anvin <hpa@zytor.com>
>>
>> Len, your tree or mine?


I think it was a mistake to apply this.
Instead we should have removed the code that it fixed.

-Len
