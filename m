From: =?UTF-8?B?Q3Jpc3RpYW4gUm9kcsOtZ3Vleg==?= <crrodriguez@opensuse.org>
Subject: Re: acpi_backlight=vendor no longer working around buggy laptop from
 hell
Date: Sun, 28 Jul 2013 21:28:35 -0400
Message-ID: <51F5C543.10103@opensuse.org>
References: <51F40114.9060607@opensuse.org> <51F5BFF6.7080506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51F5BFF6.7080506@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaron Lu <aaron.lwe@gmail.com>
Cc: linux-kernel@vger.kernel.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

El 28/07/13 21:05, Aaron Lu escribi=C3=B3:

> So does adding nox2apic still work for you with latest Linus' tree?

Yes, nox2apic makes things work again, but has always puzzled me why=20
acpi_backlight=3Dvendor made it work previously with no apparent bad si=
de=20
effect..

>> The only possible hint in the logs I could ever find is:
>>
>> [    3.844586] [Firmware Bug]: ACPI(PEGP) defines _DOD but not _DOS
>
> This is subtle, meaning the BIOS doesn't provide the required method.

Yeah, I wonder what Windows 7/8 is doing..does not seem to care about t=
hat..
