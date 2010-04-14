From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [Acpi4asus-user] 1005PE's and backlight controls
Date: Wed, 14 Apr 2010 12:14:04 -0500
Message-ID: <v2vdb599ead1004141014qb02bc808l6aa29c3b5b23de51@mail.gmail.com>
References: <y2g3b2dfeb01004131934x67e23d80vc73dfd6d5af133fa@mail.gmail.com>
	 <t2i9b2b86521004140923x9c1aaa64p867674329ae158af@mail.gmail.com>
	 <20100414164030.GA14758@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gx0-f227.google.com ([209.85.217.227]:46459 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756186Ab0DNROH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Apr 2010 13:14:07 -0400
In-Reply-To: <20100414164030.GA14758@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Alan Jenkins <sourcejedi.lkml@googlemail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, acpi4asus-user@lists.sourceforge.net, platform-driver-x86@vger.kernel.org

On Wed, Apr 14, 2010 at 11:40 AM, Matthew Garrett <mjg59@srcf.ucam.org>=
 wrote:
> On Wed, Apr 14, 2010 at 05:23:22PM +0100, Alan Jenkins wrote:
>
>> I suggest you contact the ACPI video maintainer, Zhang Rui
>> <rui.zhang@intel.com>, and attach the output of "dmidecode". =A0The =
best
>> way would probably be to report the problem on bugzilla.kernel.org (=
on
>> the ACPI video driver).

Thanks for pointers.  Its sometimes difficult to know were to ask for
help.  I found two bugzilla reports that are related:

Mentions exact bug that I'm seeing but doesn't document the
acpi_backlight=3Dvendor work around.  I've added my information to it:

https://bugzilla.kernel.org/show_bug.cgi?id=3D15182

Similar issue reported by an HP Mini and a 1005P user:

https://bugzilla.kernel.org/show_bug.cgi?id=3D15532

>>
>> I think it will indeed be possible to blacklist your machine, becaus=
e
>> someone has already anticipated this problem :-).
>
> dmi blacklisting is almost certainly wrong. It's more likely that
> eeepc-laptop shouldn't be registering a backlight if
> acpi_video_backlight_support() is true, but we'll then want to
> investigate whether we also need to send the keyboard events through.

Does the acpi-video logic not have logic on its own to send key
events?  So I guess laptops that don't have custom modules to handle
this type of stuff don't get visual feedback from gnome-power-manager?

The visual indication is very nice to have although its a "feature"
that today the event isn't making it to gnome-power-manager.  If it
got involved, it would probably write to the /sys/* interfaces and I'd
get the non-linear brightness changes even for Fn-* changes.  If ACPI
video driver can be fixed to stop non-linear part then I'd like to
have the events somehow.

If you guys think letting key event go threw is correct behavior then
I may be able to provide a patch to eeepc-laptop for this.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
