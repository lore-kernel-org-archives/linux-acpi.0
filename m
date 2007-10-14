From: dev <dev.akhawe@gmail.com>
Subject: Hibernate shuts off comp but shutdown now -h doesn't
Date: Sun, 14 Oct 2007 18:56:33 +0530
Message-ID: <ecf35a1b0710140626x214f02c8vd470eb1d76d4264b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.188]:57935 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751900AbXJNN0e (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 14 Oct 2007 09:26:34 -0400
Received: by fk-out-0910.google.com with SMTP id z23so1262867fkz
        for <linux-acpi@vger.kernel.org>; Sun, 14 Oct 2007 06:26:33 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: kernelnewbies <kernelnewbies@nl.linux.org>, linux-acpi@vger.kernel.org

Hey,
 I have a P4 2.8 GHz 915 , ASUS Mobo , Slackware linux 12 running
kernel 2.6.23 right now , but have used most of the major (2.6.*)
releases since 2.6.17

My computer on shutdown now -h never shut down. A "power down" is
printed on the screen and the monitor goes black, but the comp never
actually shutdown. I always had to kill power manually. I tried with
the generic kernel supplied with slackware (everything is a module) as
well as the huge kernel (everything is compiled in) as well as my own
kernel builds since 2.6.18. Nothing made by comp actually halt on its
own. I assumed it was a faulty ACPI on my computer, and didn't think
much of it.

I installed the latest 2.6.23 kernel. After installing , the shutdown
now -h command still doesn't work. But I tested out the
hibernate/suspend to disk via:

echo shutdown >> /sys/power/disk
echo disk >> /sys/power/state

In this case, the system halts down.

I want to know : if the hibernate / suspend to disk can halt my
computer why can't shutdown now -h. Any reasons for this / fix ?

Regards,
dev

Also , a 'halt' entry in my grub's menu.lst shuts down my computer just fine.
