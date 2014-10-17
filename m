From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v5 00/12] Add ACPI _DSD and unified device properties support
Date: Fri, 17 Oct 2014 14:22:48 +0200
Message-ID: <61463835.95KdD3U9mE@vostro.rjw.lan>
References: <2660541.BycO7TFnA2@vostro.rjw.lan> <11223831.j9KAEfSQsY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59383 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751664AbaJQMD3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Oct 2014 08:03:29 -0400
In-Reply-To: <11223831.j9KAEfSQsY@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd@arndb.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Darren Hart <dvhart@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>

On Friday, October 17, 2014 02:01:33 PM Rafael J. Wysocki wrote:
> Hi Everyone,
> 
> Hving had a couple of chats with Grant and Arnd during LinuxCon EU/LPC, we
> now have version 5 taking all feedback into account (hopefully).
> 
> Changes have been made to patch [02/12] and to patches [09-12/12], although
> in patches [10-12/12] they are fairly minor.  I have retained the Greg's
> ACK on patch [02/12], because it is essentially the same that have been
> posted aleady and ACKed by him (Greg, please let me know if I shouldn't
> do that) and all the ACKs on the remaining patches except for patch [09/12]
> which is substantially different.  Still, if reviewers think that their
> ACKs don't apply any more, please let me know and I'll remove them.
> 
> Patch [02/12] now contains helper functions for all proprerty data types
> that can be accessed which call the existing of_ functions, because Grant
> preferred that.
> 
> Patch [09/12] introduces quite a new concept, which is the struct fwnode_handle
> structure containing one field (type) and embedded in struct device_node
> (type==FWNODE_OF) and struct acpi_device (type==FWNODE_ACPI).  In short, if
> we are passed a struct fwnode_handle pointer, we can get from it to the
> appropriate device node pointer (either struct acpi_device or struct device_node)
> using container_of() after we've checked the type.  This is needed for the code
> that needs to access child nodes of a device in case when they don't have
> struct device representations (whatever the reason).  This has been suggested
> by Grant and pretty much everyone involved agrees that it's better that the
> alternatives presented so far.

While at it, many thanks to Mika for testing the patches on MinnowBoard 1 and
MinnowBoard Max and fixing build problems with them while we've been having
fun at the conferences!  I wouldn't have been able to prepare the patchset
for posting without that work.

