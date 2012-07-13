From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI button: remove hotkey suspend acpi proc event
Date: Fri, 13 Jul 2012 07:48:01 +0100
Message-ID: <20120713064801.GA4910@srcf.ucam.org>
References: <1342160002-13427-1-git-send-email-acelan.kao@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:46422 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440Ab2GMGsH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Jul 2012 02:48:07 -0400
Content-Disposition: inline
In-Reply-To: <1342160002-13427-1-git-send-email-acelan.kao@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: AceLan Kao <acelan.kao@canonical.com>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Fri, Jul 13, 2012 at 02:13:22PM +0800, AceLan Kao wrote:

> I think it's safe not to generate the proc event while pressing the
> suspend hotkey, since "/proc/acpi/event" is deprecated. And system can
> enter S3 correctly without it.

Why does this happen via /proc, but not via evdev?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
