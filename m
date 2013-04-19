From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] ACPI: Disable Windows 8 compatibility for some Lenovo
 ThinkPads
Date: Fri, 19 Apr 2013 11:15:57 +0800
Message-ID: <5170B6ED.2040408@intel.com>
References: <1360599681-24781-1-git-send-email-seth.forshee@canonical.com> <5158E8A0.3050904@intel.com> <20130401130340.GA3269@thinkpad-t410> <515AA007.1050305@intel.com> <20130402130000.GA12381@thinkpad-t410> <515BD48B.7000901@bjencks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:21629 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967861Ab3DSDOa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 18 Apr 2013 23:14:30 -0400
In-Reply-To: <515BD48B.7000901@bjencks.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ben Jencks <ben@bjencks.net>
Cc: Seth Forshee <seth.forshee@canonical.com>, Aaron Lu <aaron.lu@intel.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, joeyli <jlee@suse.com>, Matthew Garrett <mjg59@srcf.ucam.org>

On 04/03/2013 03:04 PM, Ben Jencks wrote:
> On 04/02/2013 09:00 AM, Seth Forshee wrote:
>> On Tue, Apr 02, 2013 at 05:08:23PM +0800, Aaron Lu wrote:
>>>
>>> I really wondered, how Windows handled this, it should have the same
>>> problem, unless they are not using the acpi video interface?
>>
>> I can only guess.
>>
>> I think I remember reading that Windows 8 does smooth backlight
>> transitions, so it may well hit every intermediate brightness value.
>> Lenovo could also be supplying a driver which rounds values to the
>> nearest working value or uses some other interface or something else.
> 
> Just checked; Windows 8 doesn't use the ACPI interface. It seems to have
> access to at least 100 distinct brightness levels.

I just came across a document on win8 backlight control, it has words
like this:
"
In Windows 8, the primary mechanism by which a platform should expose
its display brightness control functionality is the Windows Display
Driver Model (WDDM) miniport Device Driver Interfaces (DDI).
"
So looks like, on win8, ACPI interface is not used for these systems.

The link for the document is here:
http://msdn.microsoft.com/en-US/library/windows/hardware/jj159305

-Aaron

