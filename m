From: "Arend van Spriel" <arend@broadcom.com>
Subject: Re: REGRESSION: 3.10-rc1: Dell Latitude e6410 hangs within 3
 seconds
Date: Tue, 14 May 2013 22:38:54 +0200
Message-ID: <5192A0DE.90209@broadcom.com>
References: <5192363E.7040204@broadcom.com>
 <1396357.SFbZsj3Bmy@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1396357.SFbZsj3Bmy@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 05/14/2013 10:34 PM, Rafael J. Wysocki wrote:
> On Tuesday, May 14, 2013 03:03:58 PM Arend van Spriel wrote:
>> Laptop hangs pretty soon after booting. Workaround for me was to turn
>> off ACPI on kernel command line, ie. acpi=off
>>
>> Attached is my kernel configuration.
>
> Well, I have no idea what may be the source of this.

Me neither.

> Any chance to bisect?

can try. Rebuilding kernels can be a drag :-p

Regards,
Arend
