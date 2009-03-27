From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: "ACPI: EC: missing confirmations, switch off interrupt mode"
	wastes time on startup
Date: Fri, 27 Mar 2009 10:10:39 +0000
Message-ID: <9b2b86520903270310x78193514l44b89ed6d3088cf8@mail.gmail.com>
References: <4e5e476b0903260847m1de3e976ne20279df359176cf@mail.gmail.com>
	 <9b2b86520903260958r790e5459r553308311522e88f@mail.gmail.com>
	 <4e5e476b0903261454h1525c30chdc86dbcb1cf3cb5c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:47852 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752AbZC0KKn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Mar 2009 06:10:43 -0400
In-Reply-To: <4e5e476b0903261454h1525c30chdc86dbcb1cf3cb5c@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corrado Zoccolo <czoccolo@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux acpi <linux-acpi@vger.kernel.org>

On 3/26/09, Corrado Zoccolo <czoccolo@gmail.com> wrote:
> On Thu, Mar 26, 2009 at 5:58 PM, Alan Jenkins
> <sourcejedi.lkml@googlemail.com> wrote:
>> On 3/26/09, Corrado Zoccolo <czoccolo@gmail.com> wrote:
>>
>> Currently there is no option to force polling, sorry.  I'm _guessing_
>> this was a deliberate omission.  But I can sympathise that even 0.5s
>> boot delay is bad on a netbook.
>>
> Yes. Do you think that changing olpc_ec_timeout kernel parameter may
> help in getting the timeout sooner?
>

No, that's something different.  There's no boot option to change the timeout.

>> Feel free to create a new bugzilla entry.  You can attach the full
>> output of dmesg, but acpidump is probably not required.  What would be
>> really helpful is if you could file on bugzilla, and attach a full
>> debug trace.  I.e. as well as the normal dmesg, attach the dmesg
>> output after recompiling with this change:
>>
>
> bug: http://bugzilla.kernel.org/show_bug.cgi?id=12949
> full debug dmesg: http://bugzilla.kernel.org/attachment.cgi?id=20695

Great.
