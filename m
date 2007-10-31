From: Carlos Corbacho <cathectic@slackadelic.com>
Subject: Re: [PATCH v4] ACPI: WMI: Add WMI-ACPI mapper driver
Date: Wed, 31 Oct 2007 12:21:10 +0000
Message-ID: <200710311221.11137.cathectic@slackadelic.com>
References: <200710300336.43696.cathectic@slackadelic.com> <200710302252.30659.cathectic@slackadelic.com> <200710310018.19689.cathectic@slackadelic.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:48074 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757105AbXJaMU0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Oct 2007 08:20:26 -0400
In-Reply-To: <200710310018.19689.cathectic@slackadelic.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, "Nashif, Anas" <anas.nashif@intel.com>

On Wednesday 31 October 2007 00:18:19 Carlos Corbacho wrote:
> On Tuesday 30 October 2007 22:52:30 Carlos Corbacho wrote:
> > On Tuesday 30 October 2007 18:18:22 Len Brown wrote:
> > > When I consulted Anas about WMI, he recommended that Linux
> > > expose WMI via CIMOM.  I think that this means we'd need
> > > to invent a sysfs interface for this acpi->wmi driver
> > > to expose the hooks to a user-space daemon, which
> > > would then make sense of it in Linux's management framework.
> >
> > The main problem to overcome with a sysfs interface is that a
> > WMI-ACPI call takes multiple values.
>
> So, thinking this over more carefully, whilst sysfs can probably be used to
> export data, I'm not entirely convinced for using it to input arbitrary
> data types, unless there's some way we can get round this?

After sleeping on the matter, I'm now certain that sysfs is the wrong way to 
go for allowing userspace to access WMI-ACPI - we're trying to pass and 
return too much data for sysfs to handle.

So, what we can do is modify the proposed internal kernel calls for userspace 
(since a little sleep is a wonderful thing) to something like:

wmi_evaluate_method(const char* guid, __u32 instance, __u32 method id, void 
*input, __u32 input_size, void *output, __u32 output_size)

(wmi_evaluate_method could be shrunk to just _one_ buffer, since the WMI-ACPI 
spec suggests the mapper should only take & return one buffer).

wmi_query_data(const char* guid, __u32 instance, void *output, __u32 
output_size)

wmi_set_data(const char* guid, __u32 instance, void *input, __u32 input_size)

(Event handling is a little more tricky - we could create a 
new 'wmi_event_handler', and allow userspace or in kernel drivers to register 
this handler with the WMI-ACPI mapper, and avoid polling).

Then, we leave it up to OpenWBEM, etc to write their own backend to handle 
WMI-ACPI (I'm not sure if "provider" is the right terminology to use with 
WMI-ACPI, since we're just converting WMI calls to ACPI). This backend would 
take a WMI-ACPI method call, and convert that to the correct kernel function 
call (the kernel function then handles making the ACPI call and returning the 
results). Interpretation is left to the backend and its associated MOF.

(For the case of WMI not being built in, we define all the functions to return 
an error, or if WMI is enabled but there is no WMI-ACPI mapping device, wmi.c 
would return the errors instead).

Would this be an acceptable solution? (Len - If this is the case, where do we 
expose the wmi_* functions to userspace? linux/acpi.h, or create a new 
include file?)

-Carlos
-- 
E-Mail: cathectic@gmail.com
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
