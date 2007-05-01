From: Goulven Guillard <lecotegougdelaforce@free.fr>
Subject: Acpid won't start at boot anymore
Date: Tue, 01 May 2007 15:16:06 +0200
Message-ID: <46373D96.9050707@free.fr>
Reply-To: lecotegougdelaforce@free.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1-g19.free.fr ([212.27.42.27]:43823 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031214AbXEANNw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 1 May 2007 09:13:52 -0400
Received: from [192.168.0.3] (cro67-1-82-229-251-158.fbx.proxad.net [82.229.251.158])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 3878DB934E
	for <linux-acpi@vger.kernel.org>; Tue,  1 May 2007 15:13:51 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,


Since I upgraded to Xorg 6.9 under FC4, I have an acpi problem.


First, during rhgb (Fedora's graphical boot interface, which uses X), I 
had the following error :
acpid : can't open /proc/acpi/event (device or resource busy)


I thus tried several things, like disabling the acpid service at boot 
and launch it in /etc/rc.d/rc just after the exit of rhgb, etc. However, 
even when it is completely disabled, the same error still appears in 
/var/log/Xorg.0.log :
(WW) Open ACPI failed (/proc/acpi/event) (Device or resource busy)


When gnome is launched, the /proc/acpi is full of acpi features like 
thermal_zone, battery & cie, though. But launching the "battery charge 
monitor" gnome applet fails : I have for this to start the acpid service 
by hand (which works fine, no error message !).


So, does anybody have a solution to start the acpi daemon automatically 
at boot ?


Thanks.


PS : For information, but I don't think it is related, the laptop is a 
Dell Latitude D620.

