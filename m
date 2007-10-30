From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC] [PATCH] PNP: request ioport and iomem resources used by active devices
Date: Tue, 30 Oct 2007 02:30:13 +0000
Message-ID: <20071030023012.GA6014@srcf.ucam.org>
References: <200710291525.31475.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:55943 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486AbXJ3Ca1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Oct 2007 22:30:27 -0400
Content-Disposition: inline
In-Reply-To: <200710291525.31475.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Adam Belay <ambx1@neo.rr.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Renninger <trenn@suse.de>

On Mon, Oct 29, 2007 at 03:25:31PM -0600, Bjorn Helgaas wrote:
> Reserve resources used by active PNP devices to prevent those resources
> from being assigned to other devices.

Yes, I think this is probably a safe approach to take.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
