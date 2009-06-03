From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: ACPI Exception (evregion-0422): AE_ERROR, Returned by Handler
	for [PCI_Config] [20090320]
Date: Wed, 3 Jun 2009 03:44:53 +0100
Message-ID: <20090603024453.GA28009@srcf.ucam.org>
References: <dd18b0c30906021102h43b8ecc4u9e67687de129bca1@mail.gmail.com> <1243992286.9076.5.camel@rzhang-dt> <dd18b0c30906021911u4c2359daje01b0477a6bd23ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:54495 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346AbZFCCo5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Jun 2009 22:44:57 -0400
Content-Disposition: inline
In-Reply-To: <dd18b0c30906021911u4c2359daje01b0477a6bd23ff@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Justin Mattock <justinmattock@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Jun 02, 2009 at 07:11:41PM -0700, Justin Mattock wrote:

> alright(Ill have to do that when I get a chance)
> As for the error message after looking into it more today
> I notice this message fired off as soon as I compiled
> and loaded the nvidia module.

It looks like the nvidia driver is triggering an evaluation of the _PS0 
method on your graphics hardware. This ought to just power up your 
hardware. In the process it's trying to write to PCI configuration 
space, and some kind of error is being generated as a result - the debug 
output doesn't obviously make it possible to work out what.

If your graphics hardware still works then it's not an issue, but 
there's the possibility that this is a Linux bug which might generate 
real problems in some other situation.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
