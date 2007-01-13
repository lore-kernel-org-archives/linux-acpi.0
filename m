From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: PROBLEM: CPU fan shuts down on load of fan.ko in kernel 2.6.18
 and later
Date: Sat, 13 Jan 2007 16:12:09 +0300
Message-ID: <45A8DAA9.3010300@linux.intel.com>
References: <beb91d720701110549r346991beh95547e912f68d98f@mail.gmail.com>	 <E3C0BCA40296C347AF7142161DB9FC8298EF3A@mssmsx411> <1e2af89e0701130429x7083b6d7we89174dd7e130364@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:23532 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422664AbXAMNMO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 13 Jan 2007 08:12:14 -0500
In-Reply-To: <1e2af89e0701130429x7083b6d7we89174dd7e130364@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Brett <matthew.brett@gmail.com>
Cc: "Karasyov, Konstantin A" <konstantin.a.karasyov@intel.com>, Salatiel Filho <salatiel.filho@gmail.com>, linux-acpi@vger.kernel.org

Matthew Brett wrote:
> Hi,
>
>> Unfortunately, thermal zones defined in your DSDT doesn't contain any 
>> trip points except critical, but the fan control requires at least 
>> one active trip point (_ACx) to be defined.
>> Also, there are no fan devices (i.e. device with 'PNP0C0B' HID) defined.
>>
>> This means, that no fan and minimal thermal control is available on 
>> your system through the ACPI functionality.
>
> Hmm - I guess I had the idea that my ACPI was broken, but in this
> case, the inadequacy of the ACPI means that the linux kernel had
> become dangerous for the hardware, in a way that Windows is not.  Is
> there any way of making it less likely that problems in the ACPI will
> shut off the fan?
>
Matthew,
If BIOS does not export fan controls to OS via DSDT, it means that BIOS 
wants to control fans via its own means (hardware), this doesn't mean 
that your machine is at risk, it only means that you are not allowed to 
tamper with it...

Regards,
    Alex.
