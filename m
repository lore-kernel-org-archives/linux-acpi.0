From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 3/3] ACPI: Enable Windows ioport access compatibility
	on Windows-compatible systems
Date: Wed, 19 May 2010 17:38:02 +0100
Message-ID: <20100519163802.GA26175@srcf.ucam.org>
References: <1274283791-3380-1-git-send-email-mjg@redhat.com> <1274283791-3380-3-git-send-email-mjg@redhat.com> <201005191025.59005.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:47283 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753976Ab0ESQiN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 19 May 2010 12:38:13 -0400
Content-Disposition: inline
In-Reply-To: <201005191025.59005.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org, robert.moore@intel.com, lenb@kernel.org

On Wed, May 19, 2010 at 10:25:58AM -0600, Bjorn Helgaas wrote:

> What's the basis for the Win 2000 check?  Is the intent that we
> do this for all Windows versions?  Wikipedia claims Windows 98 had
> ACPI support, but there's no ACPI_OSI_WIN_98 definition.

The aim is to do this for all Windows versions, but Windows < 2000 
didn't provide an _OSI method - instead there's a _OS string that the 
firmware can strcmp. It's not really practical to figure out what the 
firmware's looking for in that case, and given that nobody else has 
complained about this with luck we'll be fine.

> Is there a reason why we wouldn't just set ignore_high_ioport_bits = TRUE
> always?

My only concern is that there may be a machine that was never intended 
for use with Windows and which has an incorrect io port declared. In 
that case we'd /potentially/ break an otherwise working machine. I think 
the probability of this being the case is astronomically small, but it 
probably makes sense to check. If x86 gains more ioports in future and 
Windows supports that, we can limit the check to systems that don't 
claim support for that newer version of Windows.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
