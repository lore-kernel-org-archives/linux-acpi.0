From: Brian Rak <brak@gameservers.com>
Subject: Re: Hang while booting 4.15.7
Date: Thu, 8 Mar 2018 13:02:58 -0500
Message-ID: <758d865d-faf5-e5d9-f67d-7a76c433a9dd@gameservers.com>
References: <5fcd1a79-02c0-313a-5689-06cfa2c0219d@gameservers.com>
 <18aa7774-4915-3aa1-c9fb-e1ebde09c908@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <18aa7774-4915-3aa1-c9fb-e1ebde09c908@infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org



On 3/8/2018 12:49 PM, Randy Dunlap wrote:
> On 03/08/2018 08:21 AM, Brian Rak wrote:
>> We have some Dell servers running Intel Gold 6126 processors. Some of them hang on boot under 4.15.7,  but work fine on 4.14.14.  When they hang, we see the following on console:
>>
>> Error parsing PCC subspaces from PCCT
>> watchdog: BUG: soft lockup - CPU #16 stuck for 23s! [swapper/0:1]
>>
>> We see that PCC subspaces error under 4.14 as well, but it doesn't cause the machine to hang.
>>
>> So far we haven't been able to correlate these hangs with anything in particular.  Some machines will hang, some machines will boot.  They're otherwise identical as far as hardware and firmware goes.
>>
>> I've tried pcie_aspm=off, since that seems to be the next bit of code that's being executed.  This resulted in the machine booting a little further, but then oopsing somewhere in acpi_os_purge_cache. I'm not able to get a full trace there, as I don't have serial access easily available.
>>
>> Any suggestions?
>>
> Hi,
>
> The first thing that I would do is boot with:
>    ignore_loglevel initcall_debug
> on the kernel boot command line.
>
> That will add lots of messages and maybe give us a stronger hint about where
> the hang is actually happening.
>
> And then worst case (without a boot log via serial console or netconsole) is
> to take a photo of the screen with the oops messages.
>
> And if you are fairly certain that it's an ACPI issue, also write to the
> linux-acpi@vger.kernel.org mailing list.
>
Thanks!

I booted with those parameters, and this certainly seems like an ACPI 
issue.  During bootup, the machine paused here for about 20s:
https://www.dropbox.com/s/39us0tlhbzuay7t/2018-03-08%2012_52_35.png?dl=0

then it started printing this trace:
https://www.dropbox.com/s/nxdhm19wcitrgm0/2018-03-08%2012_53_04.png?dl=0

(I can't see to figure out a decent way to capture the beginning of the 
trace here, I'll have to see if I can get the serial console working)
