From: Jesse Barnes <jesse.barnes@intel.com>
Subject: Re: [PATCH 1/7] vsprintf: fix io/mem resource width
Date: Mon, 26 Oct 2009 13:40:45 -0700
Message-ID: <20091026134045.39a92084@jbarnes-g45>
References: <20091006213259.4272.68068.stgit@bob.kio>
	<20091006213329.4272.6694.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:13537 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753052AbZJZUko (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 26 Oct 2009 16:40:44 -0400
In-Reply-To: <20091006213329.4272.6694.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Tue, 06 Oct 2009 15:33:29 -0600
Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

> The leading "0x" consumes field width, so leave space for it in
> addition to the 4 or 8 hex digits.  This means we'll print
> "0x0000-0x01df" rather than "0x00-0x1df", for example.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> ---

Applied this series to my linux-next tree, thanks.

-- 
Jesse Barnes, Intel Open Source Technology Center
