From: Alan Ott <alan@softiron.com>
Subject: Hotplug of Platform Device
Date: Mon, 12 Jun 2017 18:02:23 -0400
Message-ID: <deafa120-7562-7b58-5cb5-f7cb9d0bb304@softiron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-03.1984.is ([93.95.224.70]:34016 "EHLO mail-03.1984.is"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752383AbdFLWhi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 12 Jun 2017 18:37:38 -0400
Received: from localhost
        by mail-03.1984.is with esmtpsa (TLSv1.2:DHE-RSA-AES128-SHA:128)
        (Exim 4.84_2)
        (envelope-from <alan@softiron.com>)
        id 1dKXPn-00029i-Fn
        for linux-acpi@vger.kernel.org; Mon, 12 Jun 2017 22:02:27 +0000
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi all,

I'm creating a hardware platform and I want to make a platform device 
hot-pluggable using ACPI. The SoC I'm using (AMD A11xx) has ethernet 
on-board, and the main board has a plug-in card which contains a media 
converter and the actual network media jack. When the plug-in card is 
present I want the ethernet device to be shown in tools like ifconfig 
(-a), and when it's not present I want the ethernet device to not be shown.

In reading the spec, I feel like this could be implemented like a 
docking station or port replicator and that I should be able to make an 
ACPI device which is a dock (containing _DCK) and have my ethernet 
device be an ejection-dependent device (_EJD) of the dock, much like the 
example in section 6.3.2 of the ACPI spec.

When I do this though, it doesn't work. In the device removal case, the 
execution in the kernel goes through dock_notify() and 
hot_remove_dock_devices() which calls dock_hotplug_event() which fails 
because adev->hp is NULL, as there is no hotplug context. This makes 
some sense because the ethernet IP block on the SoC is memory-mapped and 
not capable of being hot-plugged.

My naive ideas about this are that even without a hotplug context, if 
the ACPI reports the device to be gone (and not to be used), that 
device_release_driver() could be called on each physical node in 
adev->physical_node_list, causing the driver(s) to be unloaded.

I've also tried doing this without using a docking station device[1], 
but the same things ultimately happen. Without a hotplug context, 
nothing happens to the physical device.

One thing that's not clear to me is whether a _DCK docking station 
Device is valid if it's not under a PCI node. The spec doesn't say this, 
but all the examples I can find in ACPI documents are this way.

Is there a way to do what I'm wanting to do that I'm missing, or am I 
completely misunderstanding how this works? Unfortunately the spec is 
ambiguous and real life examples are hard to come by.

Thanks for any help,

Alan.

[1] This second method is where the Notify() is called for the ethernet 
device itself (rather than using a dock device) and an _STA in the 
ethernet device returns that it's not present. I've seen this in one 
example.
