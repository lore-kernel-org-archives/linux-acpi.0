From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: A question about CONFIG_SERIAL_ACPI
Date: Thu, 25 Jan 2007 10:59:18 +0000
Message-ID: <20070125105918.GA12979@srcf.ucam.org>
References: <ac8af0be0701250223p6c201a4ci3c26673f33aef25@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:46019 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020AbXAYK70 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Jan 2007 05:59:26 -0500
Content-Disposition: inline
In-Reply-To: <ac8af0be0701250223p6c201a4ci3c26673f33aef25@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Forrest <forrest.zhao@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Thu, Jan 25, 2007 at 06:23:25PM +0800, Zhao Forrest wrote:
> Hi list,
> 
> I found that kernel 2.4.21 has CONFIG_SERIAL_ACPI, but 2.6 kernel and
> later 2.4 kernel remove this kernel config option.
> Has CONFIG_SERIAL_ACPI become the default option and been built into kernel?

The support has been merged into the PNP serial driver.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
