From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 2/2] ACPI: add DMI info to enable OSI(Linux) on
	PRIMEQUEST
Date: Mon, 26 May 2008 10:06:14 +0200
Message-ID: <20080526080614.GA28147@elf.ucw.cz>
References: <4816F9B9.3090609@jp.fujitsu.com> <4836660B.3080406@jp.fujitsu.com> <483667A4.9000606@jp.fujitsu.com> <20080525114308.GA5237@ucw.cz> <483A6D15.6030701@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754980AbYEZIFo@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <483A6D15.6030701@jp.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon 2008-05-26 16:56:05, Taku Izumi wrote:
>
> Thank you for your response.
>
>>> This patch adds DMI info to enable OSI(Linux) on PRIMEQUEST.
>>> (PRIMEQUEST is ia64 machine.)
>>
>> Why is it needed? Why needs your bios know whether it is Linux or BSD
>> or whatver running?
>
>   For memory hotplug support.
>   Memory hotplug doesn't work on PRIMEQUEST when OSI(Linux) is disabled.

So fix the BIOS: there's no reason why memory hotplug should not work
on BSD or Windows...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
