From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] ACPI: Disable Windows 8 compatibility for some Lenovo
 ThinkPads
Date: Tue, 02 Apr 2013 17:08:23 +0800
Message-ID: <515AA007.1050305@intel.com>
References: <1360599681-24781-1-git-send-email-seth.forshee@canonical.com> <5158E8A0.3050904@intel.com> <20130401130340.GA3269@thinkpad-t410>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:46345 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753812Ab3DBJHL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 2 Apr 2013 05:07:11 -0400
In-Reply-To: <20130401130340.GA3269@thinkpad-t410>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Seth Forshee <seth.forshee@canonical.com>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Ben Jencks <ben@bjencks.net>, joeyli <jlee@suse.com>, Matthew Garrett <mjg59@srcf.ucam.org>

On 04/01/2013 09:03 PM, Seth Forshee wrote:
> On Mon, Apr 01, 2013 at 09:53:36AM +0800, Aaron Lu wrote:
>> On 02/12/2013 12:21 AM, Seth Forshee wrote:
>>> The AML implementation for brightness control on several ThinkPads
>>> contains a workaround to meet a Windows 8 requirement of 101 brightness
>>> levels [1]. The implementation is flawed, as only 16 of the brighness
>>> values reported by _BCL affect a change in brightness. _BCM silently
>>> discards the rest of the values. Disabling Windows 8 compatibility on
>>> these machines reverts them to the old behavior, making _BCL only report
>>> the 16 brightness levels which actually work. Add a quirk to do this
>>> along with a dmi callback to disable Win8 compatibility.
>>
>> If we disable the _BQC(i.e. set cap._BQC=0) for these systems, will the
>> problem go away? If so, I think perhaps we can put these systems into a
>> _BQC quirk table and set cap._BQC=0 for them.
> 
> That helps a little, but we're still left with only 16 of the 101
> brightness levels causing any change in brightness. The firmware isn't
> rounding the "bad" values or anything like that; it just silently
> ignores them.

OK, and if GUI tool like g-s-d decides to go some more steps when
adjusting backlight level, it may always choose the non-functional
values. Hmm, doesn't seem to be an usable way then.

I really wondered, how Windows handled this, it should have the same
problem, unless they are not using the acpi video interface?

> 
> I submitted a second set of patches [1] which writes all intermediate
> values between the old and new brightness values and disables _BQC for
> these machines (empirically rather than using a quirk table), though no
> one seems to be interested in reviewing them.

Suppose we are at level 100, and the user sets the target level to be
20, then we will need to call _BCM 80 times?

Thanks,
Aaron

