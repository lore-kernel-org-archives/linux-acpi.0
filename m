From: giggz <giggzounet@gmail.com>
Subject: Problem with the Fn+F3 key. acpi problem ?
Date: Sat, 12 Jan 2008 13:06:30 +0100
Message-ID: <fmaaj5$jsl$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:56730 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756842AbYALMIN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 12 Jan 2008 07:08:13 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JDf9n-0005Bu-1f
	for linux-acpi@vger.kernel.org; Sat, 12 Jan 2008 12:08:11 +0000
Received: from cam44-1-82-67-121-239.fbx.proxad.net ([82.67.121.239])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Sat, 12 Jan 2008 12:08:11 +0000
Received: from giggzounet by cam44-1-82-67-121-239.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Sat, 12 Jan 2008 12:08:11 +0000
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I have a laptop : aopen 1557. I'm running under debian sid with 2.6.23
under enlightenment 17.
I want to associate a script (which works fine) to a key (Fn+F3). This
key is for the video output switching and my script is a video output
switch using xrandr.
But when I try to associate Fn+F3 it doesn't work. I have try with the
xen command to catch the keycode, but nothing happends when I press on
the key. All the others Fn+F* works fine (help, hibernate, luminosity,
sound...).
So I want to report a bug, but I don't know if it is an acpi problem or
a xorg problem... If anyone could help me...?

Regards,
Guillaume

