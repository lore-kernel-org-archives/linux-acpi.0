From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 04/19] acpi: replace kmalloc+memset with kzalloc
Date: Wed, 20 Dec 2006 16:56:23 -0500
Message-ID: <200612201656.23986.lenb@kernel.org>
References: <200612192056.kBJKuBZX010017@shell0.pdx.osdl.net> <200612200043.19375.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35843 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030372AbWLTV5E (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Dec 2006 16:57:04 -0500
In-Reply-To: <200612200043.19375.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, yan_952@hotmail.com

On Wednesday 20 December 2006 00:43, Len Brown wrote:
> Cleanup patches like this make it very difficult to work with -mm,
> as they conflict with just about every possible change.
...
> Andrew, please do not accept cleanup patches in -mm
> that touch ACPI files.  It would be easier if they were
> sent to me and I got to choose when the "flag days" occur
> based on what other patches are in the queue to Linus.

That said, this one is applied.

thanks,
-Len

