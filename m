From: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH resend] rtc-cmos: report wakeup event on ACPI RTC alarm
Date: Mon, 21 May 2012 17:38:22 -0700
Message-ID: <4FBADFFE.7030508@linaro.org>
References: <20120509231845.0301C9D401E@zog.reactivated.net> <201205102206.42891.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e2.ny.us.ibm.com ([32.97.182.142]:43207 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752657Ab2EVAjF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 May 2012 20:39:05 -0400
Received: from /spool/local
	by e2.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <john.stultz@linaro.org>;
	Mon, 21 May 2012 20:39:03 -0400
In-Reply-To: <201205102206.42891.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Daniel Drake <dsd@laptop.org>, Len Brown <lenb@kernel.org>, a.zummo@towertech.it, rtc-linux@googlegroups.com, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, pgf@laptop.org

On 05/10/2012 01:06 PM, Rafael J. Wysocki wrote:
> On Thursday, May 10, 2012, Daniel Drake wrote:
>> When the ACPI-driven RTC alarm wakes the system, report it as a wakeup
>> event. This allows userspace to determine that the reason for system
>> wakeup was RTC alarm.
>>
>> Signed-off-by: Daniel Drake<dsd@laptop.org>
> Len, John, any objections to this or may I take it for v3.5?
Seems reasonable. Although could this maybe be done more generically at 
the rtc infrastructure level instead of in the rtc-cmos driver?

thanks
-john

