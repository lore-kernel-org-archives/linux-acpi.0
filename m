From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 2/3] ACPICA: Fix access width for reset vector
Date: Thu, 9 Dec 2010 23:26:01 +0000
Message-ID: <20101209232601.GA26343@srcf.ucam.org>
References: <1291931204-5854-1-git-send-email-mjg@redhat.com> <1291931204-5854-2-git-send-email-mjg@redhat.com> <4D016241.5090503@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:35099 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264Ab0LIX0K (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Dec 2010 18:26:10 -0500
Content-Disposition: inline
In-Reply-To: <4D016241.5090503@zytor.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org, linux-kernel@vger.kernel.org

On Thu, Dec 09, 2010 at 03:12:01PM -0800, H. Peter Anvin wrote:
> On 12/09/2010 01:46 PM, Matthew Garrett wrote:
>> Section 4.7.3.6 of the ACPI specification requires that the register width
>> of the reset vector be 8 bits. Windows simply hardcodes the access to be
>> a byte and ignores the width provided in the FADT, so make sure that we
>> do the same.
>>
>> Signed-off-by: Matthew Garrett<mjg@redhat.com>
>
> Does anyone have an acpidump from a machine with an ALi 1535 southbridge?

I've got one from an HP nx9005. It's only a revision 1 FADT, so there's 
no reset register defined.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
