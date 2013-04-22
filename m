From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] ACPI: Disable Windows 8 compatibility for some Lenovo
 ThinkPads
Date: Mon, 22 Apr 2013 17:39:43 +0800
Message-ID: <5175055F.9000600@intel.com>
References: <1360599681-24781-1-git-send-email-seth.forshee@canonical.com> <1595406.DWIUmGvNI0@vostro.rjw.lan> <5173C858.10208@intel.com> <9174410.cA7eiWOPcn@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:8929 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755285Ab3DVJiS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 22 Apr 2013 05:38:18 -0400
In-Reply-To: <9174410.cA7eiWOPcn@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Aaron Lu <aaron.lu@intel.com>, Ben Jencks <ben@bjencks.net>, Seth Forshee <seth.forshee@canonical.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, joeyli <jlee@suse.com>, Matthew Garrett <mjg59@srcf.ucam.org>

On 04/22/2013 05:42 AM, Rafael J. Wysocki wrote:
> On Sunday, April 21, 2013 07:07:04 PM Aaron Lu wrote:
>> On 04/21/2013 06:06 AM, Rafael J. Wysocki wrote:
>>> On Friday, April 19, 2013 11:15:57 AM Aaron Lu wrote:
>>>> On 04/03/2013 03:04 PM, Ben Jencks wrote:
>>>>> On 04/02/2013 09:00 AM, Seth Forshee wrote:
>>>>>> On Tue, Apr 02, 2013 at 05:08:23PM +0800, Aaron Lu wrote:
>>>>>>>
>>>>>>> I really wondered, how Windows handled this, it should have the same
>>>>>>> problem, unless they are not using the acpi video interface?
>>>>>>
>>>>>> I can only guess.
>>>>>>
>>>>>> I think I remember reading that Windows 8 does smooth backlight
>>>>>> transitions, so it may well hit every intermediate brightness value.
>>>>>> Lenovo could also be supplying a driver which rounds values to the
>>>>>> nearest working value or uses some other interface or something else.
>>>>>
>>>>> Just checked; Windows 8 doesn't use the ACPI interface. It seems to have
>>>>> access to at least 100 distinct brightness levels.
>>>>
>>>> I just came across a document on win8 backlight control, it has words
>>>> like this:
>>>> "
>>>> In Windows 8, the primary mechanism by which a platform should expose
>>>> its display brightness control functionality is the Windows Display
>>>> Driver Model (WDDM) miniport Device Driver Interfaces (DDI).
>>>> "
>>>> So looks like, on win8, ACPI interface is not used for these systems.
>>>>
>>>> The link for the document is here:
>>>> http://msdn.microsoft.com/en-US/library/windows/hardware/jj159305
>>>
>>> OK, so what does that mean for the issue at hand?
>>
>> That means, we should not try to use acpi video interface to control
>> backlight on these systems if they are in win8 mode.
> 
> In that case, how are we going to indentify "these systems"?

Sorry, I don't know.

According to the following bug page:
https://bugzilla.kernel.org/show_bug.cgi?id=51231
"these systems" now include: thinkpad x230, t430s, t530, L430.

-Aaron

