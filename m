From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Use 32-bit FADT values on X86
Date: Tue, 2 Dec 2008 01:14:56 +0000
Message-ID: <20081202011456.GA31706@srcf.ucam.org>
References: <20081201111713.GA26069@srcf.ucam.org> <1228179913.2713.45.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:48522 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751742AbYLBBPA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Dec 2008 20:15:00 -0500
Content-Disposition: inline
In-Reply-To: <1228179913.2713.45.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, Dec 02, 2008 at 09:05:13AM +0800, Zhang Rui wrote:
> On Mon, 2008-12-01 at 19:17 +0800, Matthew Garrett wrote:
> > The ACPI specification says that we should use the 64-bit address offsets
> > contained within the FADT if they exist. However, Windows uses the legacy
> > address.
> Including vista?

According to the information I have, yes.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
