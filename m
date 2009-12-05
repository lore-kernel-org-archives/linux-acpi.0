From: Grozdan <neutrino8@gmail.com>
Subject: Re: Can't compile 2.6.32
Date: Sat, 5 Dec 2009 03:12:54 +0100
Message-ID: <c5bd819b0912041812g394aa26eia1b839e1f0c3c98d@mail.gmail.com>
References: <173abc14-0cbc-4340-b21f-3e8bc15f02dd@default>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:44029 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753093AbZLECMt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Dec 2009 21:12:49 -0500
In-Reply-To: <173abc14-0cbc-4340-b21f-3e8bc15f02dd@default>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Sat, Dec 5, 2009 at 3:03 AM, Randy Dunlap <randy.dunlap@oracle.com> =
wrote:
>
> A bit more info on this. It seems there's a
> CONFIG_ACPI_CUSTOM_OVERRIDE_INITRAMFS in the "normal" SUSE source RPM
> package (which in my config is not enabled, but there is an option fo=
r
> that) and looking at the drivers/acpi/osl.c and the
> include/acpi/acpiosxf.h file, there's a define for this in the header
> which has acpi_load_override_tables(void); and also this is present i=
n
> the osl.c file.... see both attachments. I could not find the same
> thing in the kernel-default-vanilla source RPM package also present i=
n
> the repo.
>
> ~~~~~~~~~~~~~~~~~~ =A0reply: ~~~~~~~~~~~~~~~~~~~~~~~~
>
> You should take this up with the OpenSUSE people, not lkml.

Yeah I know, and what I've been planning to. But, I enabled this
option some minutes ago and tried to compile again. It passed
compilation of osl.c so I think it's all good now. There have been
quite a lot of complains about how SUSE configures and splits its
kernel packages; for the new 11.2 release, I've read a lot of them on
the SUSE forum where people couldn't even boot if the kernel-desktop
was selected and installed but had no problems with the
kernel-default. I don't know who configures these kernels (I don't use
SUSE configured/compiled kernels, only grab them from the build
service & configure/compile them myself) but it seems it's getting
progressively worse, not to mention in how many different packages
they've split the kernel and people are getting confused about this :(

Anyways, thanks so far ;)

>
> Thanks,
> ~Randy
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
