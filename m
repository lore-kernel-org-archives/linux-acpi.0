From: Kevin Wilson <wkevils@gmail.com>
Subject: /proc/acpi/processor directory
Date: Fri, 15 Mar 2013 18:03:54 +0200
Message-ID: <CAGXs5wXKmhHuHC7GPZEO9ASB6eKZNAzKE7x3kRnx6P6dNiXw7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:57807 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754537Ab3COQDz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Mar 2013 12:03:55 -0400
Received: by mail-ob0-f169.google.com with SMTP id ta14so3440180obb.14
        for <linux-acpi@vger.kernel.org>; Fri, 15 Mar 2013 09:03:54 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi, linux-acpi members,

I get on Fedora 18 on x86_64 this message when running
"acpitool -c" (from installed acpitool-0.5.1-5 rpm)


acpitool -c
...
  Bogomips               : 5242.94
  Function Show_CPU_Info : could not read directory /proc/acpi/processor/
  Make sure your kernel has ACPI processor support enabled.
....
what is the reason for this ?

Is there a way to build a kernel to enable this ?
rgs,
Kevin
