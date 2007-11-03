From: Thomas Meyer <thomas@m3y3r.de>
Subject: Re: [regression] v2.6.24-rc1-497-gb1d08ac: kde battery icon gone
Date: Sat, 03 Nov 2007 14:33:50 +0100
Message-ID: <472C78BE.6020201@m3y3r.de>
References: <472B5C01.7090508@m3y3r.de> <20071103063520.13EA59AFABF@smtp05.mtu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754912AbXKCNeT@vger.kernel.org>
In-Reply-To: <20071103063520.13EA59AFABF@smtp05.mtu.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-acpi@vger.kernel.org

Andrey Borzenkov schrieb:
> Thomas Meyer wrote:
>
>   
>> i just wanted to report this:
>>
>> in v2.6.24-rc1-497-gb1d08ac the kde battery icon is no longer displayed.
>>
>> with 2.6.23 shows the battery icon.
>>
>> current config:
>>
>> grep -i acpi .config
>> # Power management options (ACPI, APM)
>> CONFIG_ACPI=y
>> CONFIG_ACPI_SLEEP=y
>> # CONFIG_ACPI_PROCFS is not set
>>     
>
> And if you enable it (ACPI_PROCFS)?
>   
And there it is again...
