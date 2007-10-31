From: Carlos Corbacho <cathectic@slackadelic.com>
Subject: Re: [PATCH v4] ACPI: WMI: Add WMI-ACPI mapper driver
Date: Wed, 31 Oct 2007 10:56:00 +0000
Message-ID: <200710311056.00741.cathectic@slackadelic.com>
References: <200710300336.43696.cathectic@slackadelic.com> <20071030134701.GA11877@srcf.ucam.org> <200710301428.11471.cathectic@slackadelic.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:55881 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755014AbXJaKzP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Oct 2007 06:55:15 -0400
In-Reply-To: <200710301428.11471.cathectic@slackadelic.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Tuesday 30 October 2007 14:28:10 Carlos Corbacho wrote:
> There are also other technical problems with this, beyond my own personal
> disagreement - since WMI relies so heavily on ACPI (well, the driver here
> is really just a simple wrapper), then you would have to start exporting
> bits of ACPI to userspace to access WMI. As mentioned in the original
> patches - the mapper knows nothing about "types", this knowledge is known
> only by the caller - WMI just deals in acpi_buffer. My understanding is
> that ACPI would have to export the required functions and data structures
> so that userspace could provide then translate from acpi_buffer to the
> known type (unless there is another way round this to import and export the
> data to/ from userspace?)

To backtrack slightly - I'm wrong on this point; after sleeping on this for 
the night (and/ or application of cluebat), I can modify the functions to let 
userspace call them without exporting half of ACPI in the process.

However, I still believe that HAL is the wrong application to deal with WMI.

-Carlos
-- 
E-Mail: cathectic@gmail.com
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
