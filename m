From: Thomas Renninger <trenn@suse.de>
Subject: Re: ACPI patches for 2.6.38-merge
Date: Wed, 12 Jan 2011 16:23:29 +0100
Message-ID: <201101121623.30134.trenn@suse.de>
References: <1294827582-4620-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:53718 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754416Ab1ALPXc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Jan 2011 10:23:32 -0500
In-Reply-To: <1294827582-4620-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, matthew@wil.cx

On Wednesday 12 January 2011 11:18:54 Len Brown wrote:
> Here is the Queue of ACPI patches for 2.6.38-merge
> They apply on top of the ACPICA series I just sent.
> 
> Please let me know if you have troubles with any of them.
Could you also add:
https://bugzilla.kernel.org/attachment.cgi?id=43252

This is attachment of comment #4 in bug:
https://bugzilla.kernel.org/show_bug.cgi?id=26342

I could not runtime test it, but it's printk modification
only anyway.

Would be great if Matthew could have a quick look into dmesg of
his affected machine once he booted a recent, fixed rcX kernel
in some weeks. It's not worth to explicitly compile and
test the patch.

Thanks,

   Thomas
