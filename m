From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: Re: Common boot/shutdown issues with the latest 2.6.37 (Mostly Asus
 laptops)
Date: Sun, 23 Jan 2011 18:49:05 +0200
Message-ID: <4D3C5C01.4040408@pardus.org.tr>
References: <4D3C3B1E.1080500@pardus.org.tr> <4D3C42A5.6060909@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <4D3C42A5.6060909@t-online.de>
Sender: platform-driver-x86-owner@vger.kernel.org
To: =?UTF-8?B?UmljaGFyZCBTY2jDvHR6?= <r.schtz@t-online.de>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, rjw@sisk.pl
List-Id: linux-acpi@vger.kernel.org

On 23.01.2011 17:00, Richard Sch=C3=BCtz wrote:

>
> Looks like these are all Intel machines. Do they use intel_idle for t=
he
> CPU powersaving features?
> (cat /sys/devices/system/cpu/cpuidle/current_driver)

Well at least on F50SV and N61JQ they use acpi_idle (this is what dmesg=
=20
output says).

I'll open a bug for N61JQ as I've got detailed information about it.


--=20
Pardus Linux
http://www.pardus.org.tr/eng
