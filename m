From: Diego Calleja <diegocg@gmail.com>
Subject: Re: CONFIG_ACPI_PROCESSOR=y confuses the cpu scheduler
Date: Sun, 22 Jan 2006 20:16:06 +0100
Message-ID: <20060122201606.5d335156.diegocg@gmail.com>
References: <20060119012040.733335f4.diegocg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from uproxy.gmail.com ([66.249.92.197]:38150 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751340AbWAVUSq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jan 2006 15:18:46 -0500
Received: by uproxy.gmail.com with SMTP id s2so533946uge
        for <linux-acpi@vger.kernel.org>; Sun, 22 Jan 2006 12:18:45 -0800 (PST)
In-Reply-To: <20060119012040.733335f4.diegocg@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

El Thu, 19 Jan 2006 01:20:40 +0100,
Diego Calleja <diegocg@gmail.com> escribi=F3:

> If I compile CONFIG_ACPI_PROCESSOR in the kernel, one of the two cpus
> doesn't get scheduled any process. The CPU works and everything, it
> services interrupts and I can force processes to run on that CPU
> with taskset, but they won't get scheduled in that CPU no matter
> how much processes and load you put on the machine.


This has been reported by another person who found the culprit
commit: http://bugzilla.kernel.org/show_bug.cgi?id=3D5930
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
