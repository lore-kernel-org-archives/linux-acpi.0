From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: PATCH [2/3]: Provide generic backlight support in IBM ACPI driver
Date: Tue, 18 Apr 2006 10:26:01 +0100
Message-ID: <20060418092601.GA14121@srcf.ucam.org>
References: <20060418082952.GA13811@srcf.ucam.org> <20060418083056.GA13846@srcf.ucam.org> <20060418091857.GB30628@osgiliath>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:54691 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1750724AbWDRJ0F (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Apr 2006 05:26:05 -0400
Content-Disposition: inline
In-Reply-To: <20060418091857.GB30628@osgiliath>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Tue, Apr 18, 2006 at 11:18:57AM +0200, Henrik Brix Andersen wrote:

> Wouldn't it be better to have ACPI_IBM and friends select
> BACKLIGHT_DEVICE?

Hmm. Probably, yes.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
