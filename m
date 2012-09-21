From: Corey Minyard <tcminyard@gmail.com>
Subject: Re: [PATCH 1/2] ACPI: Reorder IPMI driver before any other ACPI drivers
Date: Thu, 20 Sep 2012 21:08:28 -0500
Message-ID: <505BCC1C.6000006@acm.org>
References: <1348177573-7537-1-git-send-email-mjg@redhat.com> <505BC0B4.4010306@mvista.com> <20120921012625.GA13396@srcf.ucam.org>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:42964 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754860Ab2IUCId (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Sep 2012 22:08:33 -0400
In-Reply-To: <20120921012625.GA13396@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Corey Minyard <cminyard@mvista.com>, yakui.zhao@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 09/20/2012 08:26 PM, Matthew Garrett wrote:
> On Thu, Sep 20, 2012 at 08:19:48PM -0500, Corey Minyard wrote:
>> On 09/20/2012 04:46 PM, Matthew Garrett wrote:
>>> Drivers may make calls that require the ACPI IPMI driver to have been
>>> initialised already, so make sure that it appears earlier in the build
>>> order.
>> The IPMI driver uses the ACPI namespace as an option to know the
>> address and characteristics of the device.  Does that still work?
> Yes, the ACPI interpreter is initialised earlier than the IPMI driver
> discovery.
>
Cool, I'm good with these, then.

Thanks,

-corey
