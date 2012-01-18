From: lucas.gary@gmail.com
Subject: Re: APEI: Can not request iomem region for GARs
Date: Wed, 18 Jan 2012 08:20:11 -0800 (PST)
Message-ID: <3229730.1980.1326903611960.JavaMail.geo-discussion-forums@prog27>
References: <fa.VBW83nzmCUJkL7i8PnQCE+XJLbw@ifi.uio.no> <fa.tJPpWxTvpszc3I1v45J3M2ECj9E@ifi.uio.no>
 <fa.tL8DWu2lMG0ACwU85eZnSJgwW4c@ifi.uio.no> <fa.ND4Vxr1bDKbI4wO4Neh3v3LnNi8@ifi.uio.no>
 <fa.ujRlmAar6Re/yHHbpRR2c1B+waM@ifi.uio.no> <fa.Wg29YXcB/Uo8sZJfJS4lt54jnMc@ifi.uio.no>
Reply-To: fa.linux.kernel@googlegroups.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pz0-f56.google.com ([209.85.210.56]:49802 "EHLO
	mail-pz0-f56.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753397Ab2ARQ3N (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Jan 2012 11:29:13 -0500
Received: by dadp15 with SMTP id p15so3988675dad.1
        for <linux-acpi@vger.kernel.org>; Wed, 18 Jan 2012 08:29:12 -0800 (PST)
In-Reply-To: <fa.Wg29YXcB/Uo8sZJfJS4lt54jnMc@ifi.uio.no>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: fa.linux.kernel@googlegroups.com
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi, I'm just googling this problem.

I've just ran a preupgrade on my box (Supermicro 7046A) and I'm now getting this on boot:

Loading Linux 3.1.9-1.fc16.x86_64 ...
Loading initial ramdisk ...
[2.135273] APEI: Can not request iomem region region <00000000bf795eba-00000000bf795ebc> for GARS

It always ran this message but now on reboot it's halting at the message.

I realize this isn't a kernel support forum but it's the only place I've seen the message being discussed.

Does anyone know of kernel arguments I could pass in to disable the request (based on what I understand this has never worked so presumably there's no impact to disabling the function).

Or if there's some bios setting that would allow the function to succeed.

I'm going to post this in the FC16 support forum as well as the supermicro support forum and if I find anything interesting I'll follow up from there if anyone is interested?
