From: Carlos Corbacho <cathectic@slackadelic.com>
Subject: Re: [PATCH v4] ACPI: WMI: Add WMI-ACPI mapper driver
Date: Wed, 31 Oct 2007 00:18:19 +0000
Message-ID: <200710310018.19689.cathectic@slackadelic.com>
References: <200710300336.43696.cathectic@slackadelic.com> <200710301418.22639.lenb@kernel.org> <200710302252.30659.cathectic@slackadelic.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:55099 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037AbXJaARd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Oct 2007 20:17:33 -0400
In-Reply-To: <200710302252.30659.cathectic@slackadelic.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, "Nashif, Anas" <anas.nashif@intel.com>

On Tuesday 30 October 2007 22:52:30 Carlos Corbacho wrote:
> On Tuesday 30 October 2007 18:18:22 Len Brown wrote:
> > When I consulted Anas about WMI, he recommended that Linux
> > expose WMI via CIMOM.  I think that this means we'd need
> > to invent a sysfs interface for this acpi->wmi driver
> > to expose the hooks to a user-space daemon, which
> > would then make sense of it in Linux's management framework.
>
> The main problem to overcome with a sysfs interface is that a
> WMI-ACPI call takes multiple values (worst case scenario is a
> method, which takes three arguments - method id, instance and
> an input buffer).

Also, for input, I don't know how to handle the size/ type problem[1] - only 
this user-space daemon would know what size/ type of buffer the input 
requires (via the relevant MOF in the management framework) - this 
information would also need to be conveyed through the sysfs interface to the 
mapper somehow.

e.g. If we write '1' (assume we have already set the method id somehow) 
to /sys/firmware/acpi/wmi/<guid>/<instance>/data

What type/ size is the correct size of the buffer parameter to be passed to 
ACPI - u8 (1 byte), u16 (2 bytes), u32 (4 bytes), etc?

So, thinking this over more carefully, whilst sysfs can probably be used to 
export data, I'm not entirely convinced for using it to input arbitrary data 
types, unless there's some way we can get round this?

-Carlos

[1] For a buffer to be passed to acpi_evaluate_object() as a parameter, we 
must know the size in bytes to use beforehand when we create the buffer - 
otherwise, if we pass an incorrectly sized buffer as a parameter, the 
acpi_evaluate_object() call will fail. However, WMI-ACPI does not specify 
this - so this information is known only to the MOF writer, or caller of the 
WMI method/ data set.
-- 
E-Mail: cathectic@gmail.com
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
