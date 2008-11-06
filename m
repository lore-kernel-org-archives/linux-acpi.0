From: "=?ISO-8859-1?Q?B=E5rd_Kalbakk?=" <kalbakk@gmail.com>
Subject: Handling dock events in userspace
Date: Thu, 6 Nov 2008 11:52:21 +0100
Message-ID: <1a6fd8660811060252k772d6ecdy83029ff687b998a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:21208 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753311AbYKFKwX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Nov 2008 05:52:23 -0500
Received: by ug-out-1314.google.com with SMTP id 39so769824ugf.37
        for <linux-acpi@vger.kernel.org>; Thu, 06 Nov 2008 02:52:21 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi
I need to handle dock events from dock.ko in order to enable video
output on my Thinkpad Port Replicator. From the kernel I see that this
event occurring:

[  680.551956] ACPI: \_SB_.GDCK - undocking
[  704.534054] ACPI: \_SB_.GDCK - docking


The question is, how can I handle this event in userspace? I've tried
listening to acpi events with acpi_listen, and uevents with udevd, but
I get nothing.

I just glanced at the source and saw some uevent references, but
obviously this doesn't  automatically mean that it ends up in udevd.
Is there any way to accomplish this with the current driver?

\B=E5rd
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
