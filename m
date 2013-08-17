From: Ian Malone <ibmalone@gmail.com>
Subject: kernels 3.9.5 to 3.10.6 fail to boot on battery, vaio vgn-c2m/w
Date: Sat, 17 Aug 2013 20:54:53 +0100
Message-ID: <CAL3-7MrW0p-YuJBpiguoG7f0j7vgyJALhdSnh81uRM_5TR50Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ve0-f175.google.com ([209.85.128.175]:48393 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754411Ab3HQTyy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 17 Aug 2013 15:54:54 -0400
Received: by mail-ve0-f175.google.com with SMTP id oy10so2088174veb.20
        for <linux-acpi@vger.kernel.org>; Sat, 17 Aug 2013 12:54:53 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

Posted in Fedora bugzilla, but has failed to get any love there,
https://bugzilla.redhat.com/show_bug.cgi?id=991708

My laptop (Sony vgn-c2m/w
http://www.sony.co.uk/support/en/product/VGN-C2M_W/specifications
Intel Core 2 Duo T5500,  Intel 945GM, GMA950 graphics), fails to boot
on the most recent Fedora 19 kernels (latest is 3.10.6) when running
on battery. Running on PSU boots okay, and disconnecting power after
boot is okay. Using acpi=off boots successfully on battery (which is
why I thought it might be relevant here), but can't then read battery
level or adjust screen brightness.

lspci output and dmesg reports included in the Fedora bugzilla entry above.

Anything I can try here?

Thanks for your time.

-- 
imalone
http://ibmalone.blogspot.co.uk


-- 
imalone
http://ibmalone.blogspot.co.uk
