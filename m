From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [RFC] Allow notifications on method execution
Date: Fri, 20 Jun 2008 16:39:41 -0300
Message-ID: <20080620193941.GC20498@khazad-dum.debian.net>
References: <20080620152227.GA11828@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:51248 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751218AbYFTTjq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Jun 2008 15:39:46 -0400
Content-Disposition: inline
In-Reply-To: <20080620152227.GA11828@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi@hmh.eng.br

On Fri, 20 Jun 2008, Matthew Garrett wrote:
> Various bits of hardware (some Thinkpads, for example) will execute ACPI 
> methods in response to events but won't generate any notifications. It 
> would be nice to be able to receive notifications on those updates in 
> order to avoid polling. How about something like the following?

No comment on the code itself, but I have some about the whole idea.  If I
missed the point, please explain it to me.

Let me start pointing out that I am not really opposed to your idea, but I'd
like to know if it is the best way to go about it, first.

With such ACPI notifies, you could have HAL do some of the stuff kernel
drivers are doing.  So far so good (well, sort of).

But that is NOT necessarily the best, or even the correct way to do it.  You
could use ACPI "traps" sending events to userspace to know brightness
changed, but the proper way to have those events would be for the backlight
class to send uevents for such stuff, instead.

Remember that if ACPI core sends too much data to userspace directly, we
can't easily fix stuff in the drivers to present a more or less sanitized
view of things to userspace.

So I'd really like to know what you need it for?  What sort of hardware
events you'd like to be notified that thinkpad-acpi is not notifying you
about, for example?

Avoiding polling is ALWAYS a good thing.  But being careful about what you
export to userspace is ALWAYS wise as well.  I believe we can do both.

Even if it means we need to go around fixing half-completed sysfs classes
until they're good enough an API for us and userspace.  rfkill is a prime
example of the effort that might be needed.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
