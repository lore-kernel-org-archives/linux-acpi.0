From: Jon Masters <jonathan@jonmasters.org>
Subject: Re: [Linaro-acpi] [RFC] ACPI on arm64 TODO List
Date: Thu, 18 Dec 2014 00:04:18 -0500
Message-ID: <54926052.5000105@jonmasters.org>
References: <548F9668.6080900@linaro.org> <9355623.14GfrLxEB0@wuerfel> <20141216154842.GI19412@leverpostej> <5490D042.3060901@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from edison.jonmasters.org ([173.255.233.168]:57323 "EHLO
	edison.jonmasters.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbaLRFE1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Dec 2014 00:04:27 -0500
In-Reply-To: <5490D042.3060901@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Al Stone <al.stone@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>
Cc: "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Olof Johansson <olof@lixom.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 12/16/14, 7:37 PM, Al Stone wrote:
> On 12/16/2014 08:48 AM, Mark Rutland wrote:

>> I am rather concerned about the relationship between items described
>> with _DSD and ACPI's existing device model. Describing the relationship
>> between devices and their input clocks, regulators, and so on defeats
>> much of the benefit ACPI is marketed as providing w.r.t. abstraction of
>> the underlying platform (and as Arnd mentioned above, that's not the
>> kind of platform we want to support with ACPI).
>
> My belief is that all those things should be set up into a known good
> state by UEFI on initial boot.

Correct. There should never be a situation in which any clocks are 
explicitly exposed in the DSDT. Clock state should be set as a side 
effect of calling ACPI methods to transition device state. _DSD is 
intended to implement simple additions to the core spec, such as 
metadata describing the MAC address, interface type, and PHY on a 
network device. But it should never be used to expose clock nets.

I've spoken with nearly everyone building a 64-bit ARM server using ACPI 
and in nearly every case also reviewed their tables. Nobody is going to 
be so foolish on day one. The trick to some of the ongoing 
discussion/planning is to ensure that guidance prevents mistakes later.

Jon.

