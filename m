From: =?UTF-8?B?UmljaGFyZCBTY2jDvHR6?= <r.schtz@t-online.de>
Subject: Re: Common boot/shutdown issues with the latest 2.6.37 (Mostly Asus
 laptops)
Date: Mon, 31 Jan 2011 11:20:32 +0100
Message-ID: <4D468CF0.9040103@t-online.de>
References: <556624.21214.qm@web28409.mail.ukl.yahoo.com> <201101302348.40509.rjw@sisk.pl> <4D467882.9060304@pardus.org.tr> <201101311050.49722.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <201101311050.49722.rjw@sisk.pl>
Sender: platform-driver-x86-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>, Lionel Debroux <lionel_debroux@yahoo.fr>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, colin.king@canonical.com
List-Id: linux-acpi@vger.kernel.org

>> I'll compile a kernel with CONFIG_NO_HZ to see what happens but how =
do I
>> disable cpuidle during boot? I've checked the kernel-parameters.txt =
but
>> there's no cpuidle related boot parameter there.
>
> Booting with intel_idle.max_cstate=3D0 should do the trick.

intel_idle.max_cstate=3D0 causes a fallback to the acpi_idle driver. So=
 it=20
does not disable the C-states directly.

--=20
Regards,
Richard Sch=C3=BCtz
