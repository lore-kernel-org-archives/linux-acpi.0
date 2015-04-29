From: Bastien Nocera <hadess@hadess.net>
Subject: Detecting that a battery is inside a dock?
Date: Wed, 29 Apr 2015 17:08:18 +0200
Message-ID: <1430320098.2525.105.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:33626 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423016AbbD2PIV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Apr 2015 11:08:21 -0400
Received: from mfilter37-d.gandi.net (mfilter37-d.gandi.net [217.70.178.168])
	by relay6-d.mail.gandi.net (Postfix) with ESMTP id 4070AFB9BA
	for <linux-acpi@vger.kernel.org>; Wed, 29 Apr 2015 17:08:20 +0200 (CEST)
Received: from relay6-d.mail.gandi.net ([217.70.183.198])
	by mfilter37-d.gandi.net (mfilter37-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id KhxsTBIdpHjh for <linux-acpi@vger.kernel.org>;
	Wed, 29 Apr 2015 17:08:15 +0200 (CEST)
Received: from nuvo (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
	(Authenticated sender: hadess@hadess.net)
	by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id CC6FCFB8F3
	for <linux-acpi@vger.kernel.org>; Wed, 29 Apr 2015 17:08:18 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hey,

I have access to a convertible Toshiba machine where the 2nd battery 
is in detachable keyboard. This is the decompiled DSDT:
https://hadess.fedorapeople.org/toshiba.dsl

There's no BAT0, BAT1 is in the screen, and BAT2 is in the keyboard.

BAT2 can be ejected (it has an _EJD method), but the dock code doesn't 
see it as having a battery:
$ pwd
/sys/devices/platform/dock.0
$ cat flags
16
$ cat type
dock_station

Any ideas what might be missing here?

I'd eventually like to be able to say that, if I can detect that the 
battery is inside the dock, to mark it as such in the UI[1] (even 
better would be to say it's "in the keyboard" but I'm not sure we can 
easily detect that).

[1]: https://bugzilla.gnome.org/show_bug.cgi?id=748592
