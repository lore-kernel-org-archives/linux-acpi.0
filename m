From: jono <lejono@gmail.com>
Subject: Resume from suspend not working in Lenovo Helix (2nd gen)
Date: Fri, 1 May 2015 21:14:31 +0100
Message-ID: <CAJXMp+qsGW8YysD=AeNdL7f74qC8kwHgudqBJHtvaLP4PcQ2NQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:32859 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049AbbEAUOb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 May 2015 16:14:31 -0400
Received: by oica37 with SMTP id a37so77190856oic.0
        for <linux-acpi@vger.kernel.org>; Fri, 01 May 2015 13:14:31 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,
New Lenovo Helix 2nd generation, running fresh install of kernel
4.1.0rc1 (or previous kernels), and Ubuntu 15.04. The laptop fails to
resume after a suspend or lid closure. I've recompiled the kernel with
ACPI_DEBUG=y and attach the output from dmesg. Another user has put up
some info at:
http://www.thinkwiki.org/wiki/Installing_Kubuntu_15.04_on_a_Thinkpad_Helix_2nd_generation
Best,
Jonathan
