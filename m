From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 1/3] ACPI: Ignore the upper bits of SystemIO addresses
Date: Wed, 19 May 2010 10:18:46 -0600
Message-ID: <201005191018.46799.bjorn.helgaas@hp.com>
References: <1274283791-3380-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0014.houston.hp.com ([15.201.24.17]:29444 "EHLO
	g4t0014.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522Ab0ESQS6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 19 May 2010 12:18:58 -0400
In-Reply-To: <1274283791-3380-1-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-acpi@vger.kernel.org, robert.moore@intel.com, lenb@kernel.org

On Wednesday, May 19, 2010 09:43:09 am Matthew Garrett wrote:
> Various machines (https://bugzilla.redhat.com/show_bug.cgi?id=585756 for
> instance) contain SystemIO spaces with addresses > 16 bits. acpica throws
> an error for this, while Windows silently ignores the upper 16 bits and
> carries on happily. Provide support for the latter behaviour for bug
> compatibility.
> 

> +	if (acpi_gbl_ignore_high_ioport_bits)
> +		/* Windows only uses the lower 16 bits of an address.
> +		   Emulate that */
> +		address &= 0xffff;

I think this is a good idea.  But it makes me a little bit nervous
to change addresses supplied by the firmware without any user-visible
indication at all.  Is it worth doing a WARN_ONCE() sort of thing
when we truncate?

I know you experimented quite a bit to confirm that Windows does this
sort of masking.  Do you have any notes about that experimentation
that would be useful to add to the bugzilla?

Bjorn
