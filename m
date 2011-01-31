From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: Re: Common boot/shutdown issues with the latest 2.6.37 (Mostly Asus
 laptops)
Date: Mon, 31 Jan 2011 12:03:09 +0200
Message-ID: <4D4688DD.6030502@pardus.org.tr>
References: <556624.21214.qm@web28409.mail.ukl.yahoo.com> <201101302348.40509.rjw@sisk.pl> <4D467882.9060304@pardus.org.tr> <201101311050.49722.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <201101311050.49722.rjw@sisk.pl>
Sender: platform-driver-x86-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Lionel Debroux <lionel_debroux@yahoo.fr>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, colin.king@canonical.com
List-Id: linux-acpi@vger.kernel.org

On 31.01.2011 11:50, Rafael J. Wysocki wrote:
> On Monday, January 31, 2011, Ozan =C3=87a=C4=9Flayan wrote:
>> On 31.01.2011 00:48, Rafael J. Wysocki wrote:
>>
>>> Does booting with "nolapic" help on all of the affected systems?
>>>
>>> Also, does disabling the CPUidle during boot help?
>>>
>>> Finally, is the problem reproducible with CONFIG_NO_HZ unset?
>>
>> Well on two machines, nolapic cures the boot hang and on one machine=
 it
>> cures the random shutdown hangs.
>>
>> I'll compile a kernel with CONFIG_NO_HZ to see what happens but how =
do I
>> disable cpuidle during boot? I've checked the kernel-parameters.txt =
but
>> there's no cpuidle related boot parameter there.
>
> Booting with intel_idle.max_cstate=3D0 should do the trick.

Okay but on Asus X61S idle fallbacks to cpuidle:

intel_idle: MWAIT substates: 0x3122220
intel_idle: does not run on family 6 model 23

so forcing max_cstate to 0 will turn off the cpuidle on those machines =
too?


--=20
Pardus Linux
http://www.pardus.org.tr/eng
