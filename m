From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: msi s271 (1058)
Date: Tue, 25 Jul 2006 09:14:12 -0600
Message-ID: <200607250914.12836.bjorn.helgaas@hp.com>
References: <44BB64DC.50804@guetl.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel6.hp.com ([156.153.255.205]:29859 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S932402AbWGYPOY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Jul 2006 11:14:24 -0400
In-Reply-To: <44BB64DC.50804@guetl.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: andreas guetl <andreas@guetl.net>
Cc: linux-acpi@vger.kernel.org

On Monday 17 July 2006 04:22, andreas guetl wrote:
> i recently bought a msi s271 barebone and stuffed it with an amd turion
> x1 tl-56, 2gb ram and a harddisk. but linux won't start on it when acpi
> is enabled. i tried tons of kernel-configuration (both 64 and 32bit),
> boot-parameters and bios-versions. no success. only if acpi=off is
> appended. so i can't even dump its dsdt table.
> 
> does anyone know a method to get the dsdt table on windows? (windows x64
> that is).

Sorry, I don't know how to get the DSDT on Windows.

Can you open a report at http://bugzilla.kernel.org with the
information above and attach the dmesg log with "acpi=off".  If
you can use a serial console, net console, or digital camera to
capture the output when things fail, attach that, too.

What is the failure mode when ACPI is enabled?

Bjorn
