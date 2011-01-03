From: Giacomo <delleceste@gmail.com>
Subject: vga switcheroo not working / crashing the machine on i915/nvidia
 hybrid. (ASUS U30JC)
Date: Mon, 3 Jan 2011 12:32:49 +0100
Message-ID: <AANLkTinRHN50G8iHR1dxgS+6GraGYpYuEUqjhYoLThv3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:37218 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753095Ab1ACLcu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Jan 2011 06:32:50 -0500
Received: by qwa26 with SMTP id 26so13279996qwa.19
        for <linux-acpi@vger.kernel.org>; Mon, 03 Jan 2011 03:32:50 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello.

In my double-carded ASUS U30JC (nvidia + intel i915) I do the following:

stop X

This is the output of /sys/kernel/debug/vgaswitcheroo/switch

daphne linux # cat /sys/kernel/debug/vgaswitcheroo/switch
0: :Pwr:0000:01:00.0
1:+:Pwr:0000:00:02.0 (intel graphic card in use, ok)

echo "DDIS" > /sys/kernel/debug/vgaswitcheroo/switch does not change
the output above (intel remains marked as active)

echo "OFF" > /sys/kernel/debug/vgaswitcheroo/switch

seems to switch off Nvidia card, because the output above becomes:
0: :Off:0000:01:00.0
1:+:Pwr:0000:00:02.0

restarting X completely freezes the machine, black screen (need to power down
by
pressing the power button).


ASUS U30JC Nvidia (nouveau) + intel i915.

Kernel 2.6.35
x11-base/xorg-server 1.9.2.902
x11-drivers/xf86-video-nouveau 0.0.16_pre20101010

Shutting down the Nvidia graphic card via acpi_call
https://github.com/mkottman/acpi_call
produces the same freeze after trying to restart X.

Same problem with kernel 2.6.36 and acpi_call.
Did not try vga switcheroo on 2.6.36 due to problems with that kernel
https://bugzilla.kernel.org/show_bug.cgi?id=24542

The branch in the drm-testing repo
http://git.kernel.org/?p=linux/kernel/git/airlied/drm-testing.git;a=shortlog;h=refs/heads/drm-nvidia-switch
does not solve the issue.


echo "OFF" > /sys/kernel/debug/vgaswitcheroo/switch

produces in dmesg:

Dec  8 00:06:18 daphne kernel: VGA switcheroo: switched nouveau off
Dec  8 00:06:18 daphne kernel: [drm] nouveau 0000:01:00.0: Disabling fbcon
acceleration...
Dec  8 00:06:18 daphne kernel: [drm] nouveau 0000:01:00.0: Unpinning
framebuffer(s)...
Dec  8 00:06:18 daphne kernel: [drm] nouveau 0000:01:00.0: Evicting buffers...
Dec  8 00:06:18 daphne kernel: [drm] nouveau 0000:01:00.0: Idling channels...
Dec  8 00:06:18 daphne kernel: [drm] nouveau 0000:01:00.0: Suspending GPU
objects...
Dec  8 00:06:19 daphne kernel: [drm] nouveau 0000:01:00.0: And we're gone!
Dec  8 00:06:19 daphne kernel: nouveau 0000:01:00.0: PCI INT A disabled
Dec  8 00:06:19 daphne kernel: nouveau 0000:01:00.0: power state changed by
ACPI to D3

which seems to be correct.

The crash taking place when restarting X does not leave any trace on dmesg.

Thanks in advance.

Giacomo.
Elettra Synchrotron Radiation Facility
Trieste, IT.

--
Giacomo S.
http://www.giacomos.it

- - - - - - - - - - - - - - - - - - - - - -

* iqfire-wall, un progetto
  open source che implementa un
  filtro di pacchetti di rete per Linux,
  e` disponibile per il download qui:
  http://sourceforge.net/projects/ipfire-wall

* Informazioni e pagina web ufficiale:
  http://www.giacomos.it/iqfire/index.html

- - - - - - - - - - - - - - - - - - - - - -

 . ''  `.
:   :'    :
 `.  ` '
    `- Debian GNU/Linux -- The power of freedom
        http://www.debian.org
