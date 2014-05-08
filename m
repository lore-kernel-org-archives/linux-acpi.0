From: Manuel Krause <manuelkrause@netscape.net>
Subject: Re: [RFC PATCH] Revert "ACPI / AC: convert ACPI ac driver to platform
 bus"
Date: Thu, 08 May 2014 03:32:32 +0200
Message-ID: <536ADEB0.90706@netscape.net>
References: <1399429108-15395-1-git-send-email-linux@roeck-us.net> <6536976.HgJVm3ut0E@vostro.rjw.lan> <20140507233155.GA14406@roeck-us.net> <2440587.zkE99e14QY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from omr-d02.mx.aol.com ([205.188.109.194]:64761 "EHLO
	omr-d02.mx.aol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573AbaEHBdH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 May 2014 21:33:07 -0400
In-Reply-To: <2440587.zkE99e14QY@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>

On 2014-05-08 01:50, Rafael J. Wysocki wrote:
> On Wednesday, May 07, 2014 04:31:55 PM Guenter Roeck wrote:
>> On Thu, May 08, 2014 at 01:43:55AM +0200, Rafael J. Wysocki wrote:
>>> On Tuesday, May 06, 2014 07:18:28 PM Guenter Roeck wrote:
>>>> This reverts commit cc8ef52707341e67a12067d6ead991d56ea017ca.
>>>>
>>>> This is an attempt to fix (or at least track down)
>>>> https://bugzilla.kernel.org/show_bug.cgi?id=71711.
>>>>
>>>> Cc: Zhang Rui <rui.zhang@intel.com>
>>>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>>>> Cc: Manuel Krause <manuelkrause@netscape.net>
>>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>>>
>>>> Conflicts:
>>>> 	drivers/acpi/ac.c
>>>> 	drivers/acpi/acpi_platform.c
>>>
>>> Queued up as a fix for 3.15, thanks!
>>>
>>
>> It should also find its way into 3.14.
>
> I've marked it for -stable too.  Thanks!
>
>

Thank you all for your work! Guenters patch also works for me 
with kernel 3.14.3 + BFS/CK + BFQ.
And, please, let me know when further testing/evaluation is needed.

Manuel
