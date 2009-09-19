From: Neil Wilson <neil@aldur.co.uk>
Subject: Ethernet dropped packets/overruns on Lenovo N100 when ACPI is on
Date: Sat, 19 Sep 2009 17:12:38 +0100
Message-ID: <50d9f33a0909190912u5595d223i7e28d45ff126809@mail.gmail.com>
References: <50d9f33a0909190130x198cb287vc3c4b032016ab59c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f206.google.com ([209.85.219.206]:63608 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751192AbZISQMf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 19 Sep 2009 12:12:35 -0400
Received: by ewy2 with SMTP id 2so2074851ewy.17
        for <linux-acpi@vger.kernel.org>; Sat, 19 Sep 2009 09:12:38 -0700 (PDT)
In-Reply-To: <50d9f33a0909190130x198cb287vc3c4b032016ab59c@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I hope this is the right list to shed some light on this kernel problem:

http://bugzilla.kernel.org/show_bug.cgi?id=13830
referring to further detail at
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/401891

When I use 'acpi=off' or 'acpi=ht' I can run the Realtek network
interface on the Lenovo at full speed with no problems.

Once I switch ACPI on, or use any of the other ACPI control flags then
I start to
get network errors when I put the interface under load. Errors,
overruns and dropped packets all go up in tandem.

I was wondering if you had any suggestions as to how to debug this
further and hopefully get it fixed.

The problem has existed in all versions of the kernel I have
available, (down to 2.6.24). Diagnostic output from the machine is
attached to the Launchpad bug above.

--
Neil Wilson
