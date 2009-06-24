From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 00/15] acpi4asus updates
Date: Wed, 24 Jun 2009 01:41:27 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0906240136300.32742@localhost.localdomain>
References: <1245180536-28009-1-git-send-email-corentincj@iksaif.net>
 <alpine.LFD.2.00.0906172241040.8921@localhost.localdomain>
 <alpine.LFD.2.00.0906180157380.8921@localhost.localdomain>
 <71cd59b00906190128h6de62133o9e8380e1992da59c@mail.gmail.com>
 <alpine.LFD.2.00.0906191535220.4325@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:63136 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867AbZFXFl2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Jun 2009 01:41:28 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KLQ001SCAH5SZC4@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 24 Jun 2009 00:41:31 -0500 (CDT)
In-reply-to: <alpine.LFD.2.00.0906191535220.4325@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: linux-acpi@vger.kernel.org


On Fri, 19 Jun 2009, Len Brown wrote:

> thanks for the refresh, Corentin, they're now applied.

Unfortunately, upstream scribbed more rfkill stuff on eeepc-laptop.c
I did take a swing at merging the conflicts, but got lost.
So it is probably best if you refresh those last 8 eeepc-laptop.c
patches and send them again.

Below is the log for what I was able to get in.

thanks,
Len Brown, Intel Open Source Technology Center

commit 21ab01e2fcbfcc0d1faba2b7336b3c0f7f3c1ac8
Author: Corentin Chary <corentincj@iksaif.net>
Date:   Fri Jun 19 14:52:11 2009 +0200

    asus-laptop: remove EXPERIMENTAL dependency
    
    Signed-off-by: Corentin Chary <corentincj@iksaif.net>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 2fcc23da5522b89677fb0af6043a88e88fdd09a2
Author: Corentin Chary <corentincj@iksaif.net>
Date:   Fri Jun 19 14:52:03 2009 +0200

    asus-laptop: use pr_fmt and pr_<level>
    
    Convert the unusual printk(ASUS_<level> uses to
    the more standard pr_fmt and pr_<level>(.
    
    Signed-off-by: Corentin Chary <corentincj@iksaif.net>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit b31d0fde89c905673ceed0404d5ae24f2261d7c7
Author: Corentin Chary <corentincj@iksaif.net>
Date:   Tue Jun 16 19:28:56 2009 +0000

    eeepc-laptop: cpufv updates
    
    Limit cpufv input to acceptables values.
    Add an available_cpufv file to show available
    presets.
    Change cpufv ouput format from %d to %#x, it won't
    break compatibility with existing userspace tools, but
    it provide a more human readable output.
    
    Signed-off-by: Corentin Chary <corentincj@iksaif.net>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit b7b700d4a473d56103e87e341ad555e8a7cce06d
Author: Corentin Chary <corentincj@iksaif.net>
Date:   Tue Jun 16 19:28:52 2009 +0000

    eeepc-laptop: sync eeepc-laptop with asus_acpi
    
    In the default Eee PC distribution, there is a modified
    asus_acpi driver. eeepc-laptop is a cleaned version of this
    driver. Sync ASL enum and getter/setters with asus_acpi.
    
    Signed-off-by: Corentin Chary <corentincj@iksaif.net>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 6122af3743a48dddae19810626dd7c9c8e6c1df8
Author: Corentin Chary <corentincj@iksaif.net>
Date:   Tue Jun 16 19:28:48 2009 +0000

    asus_acpi: Deprecate in favor of asus-laptop
    
    asus-laptop have been merged in the kernel two years ago,
    it is now stable and used by most distribution instead of
    the old asus_acpi driver.
    
    Signed-off-by: Corentin Chary <corentincj@iksaif.net>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 76593d6fb0a51cb0d666f37d91a990e36c068365
Author: Corentin Chary <corentincj@iksaif.net>
Date:   Tue Jun 16 19:28:47 2009 +0000

    acpi4asus: update MAINTAINER and KConfig links
    
    The bug tracker have moved from sourceforge to
    http://dev.iksaif.net . The homepage of the project
    is now http://acpi4asus.sf.net with links to the new
    bug tracker. No change for the mailing list.
    
    Signed-off-by: Corentin Chary <corentincj@iksaif.net>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 116bf2e010a0600371aede450351973821dfd9e2
Author: Corentin Chary <corentincj@iksaif.net>
Date:   Tue Jun 16 19:28:46 2009 +0000

    asus-laptop: platform dev as parent for led and backlight
    
    Makes asus-laptop platform device the parent device of
    backlight and led classes.
    
    With this patch, leds and backlight are also available in
    /sys/devices/platform/asus-laptop/ like thinkpad_acpi.
    
    Signed-off-by: Corentin Chary <corentincj@iksaif.net>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit cede2cb6ee9b0ddaa3dbc9939418ff177a831600
Author: Pekka Enberg <penberg@cs.helsinki.fi>
Date:   Tue Jun 16 19:28:45 2009 +0000

    eeepc-laptop: enable camera by default
    
    If we leave the camera disabled by default, userspace programs (e.g.
    Skype, Cheese) leave the user out in the cold saying that the machine
    "has no camera." Therefore, it's better to enable camera by default 
and
    let people who really don't want it just disable the thing.
    
    To reduce power usage you should enable USB autosuspend:
    echo -n auto > /sys/bus/usb/drivers/uvcvideo/*:*/../power/level
    
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
    Signed-off-by: Corentin Chary <corentincj@iksaif.net>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 57599cc997b81a7c4f764693a7316886a72067fe
Merge: fbe8cdd 586caae
Author: Len Brown <len.brown@intel.com>
Date:   Wed Jun 24 01:22:20 2009 -0400

    Merge branch 'bjorn-notify' into release
    
    Conflicts:
        drivers/platform/x86/eeepc-laptop.c
    
    Signed-off-by: Len Brown <len.brown@intel.com>

