From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: Re: Common boot/shutdown issues with the latest 2.6.37 (Mostly Asus
 laptops)
Date: Fri, 04 Feb 2011 00:13:23 +0200
Message-ID: <4D4B2883.4020701@pardus.org.tr>
References: <556624.21214.qm@web28409.mail.ukl.yahoo.com> <201101312352.30883.rjw@sisk.pl> <4D4B19D3.2080800@pardus.org.tr> <201102032304.46724.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <201102032304.46724.rjw@sisk.pl>
Sender: platform-driver-x86-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: =?UTF-8?B?UmljaGFyZCBTY2jDvHR6?= <r.schtz@t-online.de>, Lionel Debroux <lionel_debroux@yahoo.fr>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 04.02.2011 00:04, Rafael J. Wysocki wrote:

>
> I guess we see a few different problems here.
>
> Can you remind me, please, what the known workarounds are?

OK in summary:

ASUS X71S - Doesn't boot without nolapic
ASUS F50SV - Doesn't boot without nolapic (latest tried and working 2.6.31)
ASUS N61JQ - X out of Y shutdown hangs (Cured with nolapic too)

Note that nolapic is the finer grained fix. acpi=off fixes the issue too.

Doesn't seem to be related to idle as processor.max_cstates=0 didn't help.

This is 2.6.37, intel_idle enabled with 2 upstream patches mentioned 
before + the mm fix.


-- 
Pardus Linux
http://www.pardus.org.tr/eng
