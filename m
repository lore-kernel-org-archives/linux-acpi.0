From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Fan resume not working on nx6325 without userland assistance
Date: Tue, 22 Jan 2008 18:14:04 +0100
Message-ID: <200801221814.05416.rjw@sisk.pl>
References: <200801220241.43230.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:59098 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751785AbYAVRQt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 Jan 2008 12:16:49 -0500
In-Reply-To: <200801220241.43230.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>

On Tuesday, 22 of January 2008, Rafael J. Wysocki wrote:
> Hi,
> 
> It turns out that the following script (from openSUSE 10.3):
> 
> #############################################################
> # triggers the ACPI fan(s) after resume. Since ACPI drivers
> # have no suspend support, this is sometimes necessary.
> # see http://article.gmane.org/gmane.linux.acpi.devel/16643
> kick-fan()
> {
>         local FAN DUMMY STATE
>         for FAN in /proc/acpi/fan/*/state; do
>                 [ ! -e $FAN ] && continue
>                 read DUMMY STATE < $FAN
>                 if [ "$STATE" = "on" ]; then
>                         echo "kicking $FAN"
>                         echo -n 3 > $FAN
>                         echo -n 0 > $FAN
>                 fi
>         done
> }
> 
> case $1 in
>         thaw|resume)
>                 kick-fan
>                 ;;
> esac
> 
> is necessary to make the fan behave appropriately after a resume from RAM
> (I haven't checked resume from hibernation, but I guess the same thing happens)
> on HP nx6325 with 2.6.24-rc8 (and with previous kernels probably too).
> 
> It wasn't needed at one point, so something has regressed.  Sigh.

Ah, I didn't say that thermal management is completely busted after a resume
if the fan is not kicked from the user land (using the above script).  Usually
the fan is 100% on (that corresponds to all ACPI "fans" being on), but once it
had gone off and I was unable to turn it on by any means (including rising the
temperature to a dangerous level).

Greetings,
Rafael
