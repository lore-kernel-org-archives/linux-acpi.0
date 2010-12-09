From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2/3] ACPICA: Fix access width for reset vector
Date: Thu, 09 Dec 2010 15:12:01 -0800
Message-ID: <4D016241.5090503@zytor.com>
References: <1291931204-5854-1-git-send-email-mjg@redhat.com> <1291931204-5854-2-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:36774 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752408Ab0LIXMQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Dec 2010 18:12:16 -0500
In-Reply-To: <1291931204-5854-2-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: x86@kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org, linux-kernel@vger.kernel.org

On 12/09/2010 01:46 PM, Matthew Garrett wrote:
> Section 4.7.3.6 of the ACPI specification requires that the register width
> of the reset vector be 8 bits. Windows simply hardcodes the access to be
> a byte and ignores the width provided in the FADT, so make sure that we
> do the same.
>
> Signed-off-by: Matthew Garrett<mjg@redhat.com>

Does anyone have an acpidump from a machine with an ALi 1535 southbridge?

	-hpa
