From: Ben Jencks <ben@bjencks.net>
Subject: Re: [PATCH] ACPI: Disable Windows 8 compatibility for some Lenovo
 ThinkPads
Date: Wed, 13 Feb 2013 16:09:52 -0500
Message-ID: <511C0120.80707@bjencks.net>
References: <1360599681-24781-1-git-send-email-seth.forshee@canonical.com> <20130211175213.GA25139@srcf.ucam.org> <20130211190617.GH13768@thinkpad-t410> <20130211190914.GA27364@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vc0-f173.google.com ([209.85.220.173]:45604 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752010Ab3BMVJz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Feb 2013 16:09:55 -0500
Received: by mail-vc0-f173.google.com with SMTP id fy7so1060786vcb.4
        for <linux-acpi@vger.kernel.org>; Wed, 13 Feb 2013 13:09:55 -0800 (PST)
In-Reply-To: <20130211190914.GA27364@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Seth Forshee <seth.forshee@canonical.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, joeyli <jlee@suse.com>

On 02/11/2013 02:09 PM, Matthew Garrett wrote:
> On Mon, Feb 11, 2013 at 01:06:17PM -0600, Seth Forshee wrote:
>> On Mon, Feb 11, 2013 at 05:52:13PM +0000, Matthew Garrett wrote:
>>> So the problem is that userspace is writing values that don't happen to 
>>> be aligned with the values the hardware reacts to, and so nothing gets 
>>> changed?
>>
>> Yes. The values are valid according to to _BCL, but _BCM is discarding
>> any values that aren't contained in an array named BRTW. BRTW is
>> literally the object returned by _BCL returns for !Windows 2012. Here's
>> a link to the AML if you'd like to take a look.
> 
> Right. My concern here is that Windows clearly doesn't trigger the 
> issue, and so there's some chance that we'll see similar issues on other 
> machines. Disabling Windows 8 compatibility isn't really an option. One 
> choice might be to have the ACPI video driver set all intermediate 
> values if the system makes the Windows 8 OSI call?

Stupid hack idea: what about trying all the levels _BCL reports and
seeing which ones change _BQC? Then filter out any that don't really
exist. It might make bootup look odd, seeing the backlight quickly scan
through all brightness levels, but it's only once per boot.

-Ben

