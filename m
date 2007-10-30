From: Carlos Corbacho <cathectic@slackadelic.com>
Subject: Re: [PATCH v4] ACPI: WMI: Add WMI-ACPI mapper driver
Date: Tue, 30 Oct 2007 22:52:30 +0000
Message-ID: <200710302252.30659.cathectic@slackadelic.com>
References: <200710300336.43696.cathectic@slackadelic.com> <200710301418.22639.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:47733 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752540AbXJ3Wvn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Oct 2007 18:51:43 -0400
In-Reply-To: <200710301418.22639.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, "Nashif, Anas" <anas.nashif@intel.com>

On Tuesday 30 October 2007 18:18:22 Len Brown wrote:
> When I consulted Anas about WMI, he recommended that Linux
> expose WMI via CIMOM.  I think that this means we'd need
> to invent a sysfs interface for this acpi->wmi driver
> to expose the hooks to a user-space daemon, which
> would then make sense of it in Linux's management framework.

The main problem to overcome with a sysfs interface is that a 
WMI-ACPI call takes multiple values (worst case scenario is a 
method, which takes three arguments - method id, instance and 
an input buffer).

We could try and do something like this for methods & data blocks:

/sys/firmware/acpi/wmi/<GUID>/ ->

type (method, event, data)
instance_count (maximum number of instances - method's & data only)

Then have the following directory for each possible instance:

/sys/firmware/acpi/wmi/<GUID>/<instance>/

Inside, we'd have two files:

method_id (methods only)
data

For data blocks, it's easy -> just read/ write from data (wmi.c could
also try to be clever, and set the correct read/ write permissions
by checking for appropriate methods).

For method calling -> This is more complicated, since we need to pass
a method id and the input data (and unlike instance, WMI-ACPI does not
define the maximum number of methods). We could do this by writing to 
a file called method_id first with the method_id we want to call, then 
read/ write to data (but I'm open to suggestions for a better interface).

Events would, I imagine, be some sort of polling, although probably
split over two files:

One file to tell the polling application of the event, another file
(say 'data'), containing the data associated with that event?

Unless there's another way we can export the events without polling?

-Carlos
-- 
E-Mail: cathectic@gmail.com
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
