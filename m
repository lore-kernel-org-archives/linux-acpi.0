From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [PATCH 2/2] ACPI: Store NVS state even when entering suspend
	to RAM
Date: Thu, 10 Jun 2010 12:41:15 +0300
Message-ID: <1276162875.18013.5.camel@dell20>
References: <1275078735-1866-1-git-send-email-mjg@redhat.com>
	 <1275078735-1866-2-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64612 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008Ab0FJJlY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Jun 2010 05:41:24 -0400
In-Reply-To: <1275078735-1866-2-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

On Fri, 2010-05-28 at 16:32 -0400, Matthew Garrett wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=13931 describes a bug where
> a system fails to successfully resume after the second suspend. Maxim
> Levitsky discovered that this could be rectified by forcibly saving
> and restoring the ACPI non-volatile state. The spec indicates that this
> is only required for S4, but testing the behaviour of Windows by adding
> an ACPI NVS region to qemu's e820 map and registering a custom memory
> read/write handler reveals that it's saved and restored even over suspend
> to RAM. We should mimic that behaviour to avoid other broken platforms.
Any chance to see this patch in 2.6.35?

Best regards,
	Maxim Levitsky

