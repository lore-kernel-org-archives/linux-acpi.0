From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: A question about CONFIG_SERIAL_ACPI
Date: Thu, 25 Jan 2007 08:58:30 -0700
Message-ID: <200701250858.30758.bjorn.helgaas@hp.com>
References: <ac8af0be0701250223p6c201a4ci3c26673f33aef25@mail.gmail.com> <20070125105918.GA12979@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel7.hp.com ([156.153.255.213]:48700 "EHLO atlrel7.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030247AbXAYP7a (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 25 Jan 2007 10:59:30 -0500
In-Reply-To: <20070125105918.GA12979@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Zhao Forrest <forrest.zhao@gmail.com>, linux-acpi@vger.kernel.org

On Thursday 25 January 2007 03:59, Matthew Garrett wrote:
> On Thu, Jan 25, 2007 at 06:23:25PM +0800, Zhao Forrest wrote:
> > I found that kernel 2.4.21 has CONFIG_SERIAL_ACPI, but 2.6 kernel and
> > later 2.4 kernel remove this kernel config option.
> > Has CONFIG_SERIAL_ACPI become the default option and been built into kernel?
> 
> The support has been merged into the PNP serial driver.

To get the functionality that CONFIG_SERIAL_ACPI used to provide, you
now need:

	CONFIG_ACPI
	CONFIG_PNP
	CONFIG_PNPACPI
	CONFIG_SERIAL_8250
	CONFIG_SERIAL_8250_PNP

Most of those should be set by default, but sometimes people miss
CONFIG_PNPACPI.
