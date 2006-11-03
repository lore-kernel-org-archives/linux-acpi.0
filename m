From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: acpiphp makes noise on every lid close/open
Date: Thu, 2 Nov 2006 17:54:03 -0800
Message-ID: <20061102175403.279df320.kristen.c.accardi@intel.com>
References: <20061101115618.GA1683@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:42808 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1752932AbWKCBzC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Nov 2006 20:55:02 -0500
In-Reply-To: <20061101115618.GA1683@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, ACPI mailing list <linux-acpi@vger.kernel.org>

On Wed, 1 Nov 2006 12:56:18 +0100
Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
> 
> With 2.6.19-rc4, acpi complains about "acpiphp_glue: cannot get bridge
> info" each time I close/reopen the lid... On thinkpad x60. Any ideas?
> (-mm1 behaves the same).
> 									Pavel
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

Looks like acpi is sending a BUS_CHECK notification to acpiphp on the 
PCI Root Bridge whenever the lid opens up.

There is a bug here in that acpiphp shouldn't even be used on the X60 -
it has no hotpluggable slots.  This problem only occurs when acpiphp is
built in, as when a module it just doesn't load.  It appears to not clean
up after itself properly when it finds no ejectable slots and leaves the
acpi notifier installed for the PCI Root Bridge.  The message is printing
"cannot get bridge info" because it partially cleaned some stuff up (without
actually removing the notifier).  I'll put this bug into bugzilla since
I won't have time to fix right away:

http://bugzilla.kernel.org/show_bug.cgi?id=7452

Feel free to add yourself to the CC list if you are interested in being
notified when it is fixed.

Kristen
 
