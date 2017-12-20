From: Raf <gibboris@gmail.com>
Subject: thinkpad E555, fan module not loaded
Date: Wed, 20 Dec 2017 12:30:01 -0300
Message-ID: <20171220153001.igq4g3urcqjkfsez@debovo.drzraf.me>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yb0-f180.google.com ([209.85.213.180]:40957 "EHLO
        mail-yb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754846AbdLTPaG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Dec 2017 10:30:06 -0500
Received: by mail-yb0-f180.google.com with SMTP id g198so9058991yba.7
        for <linux-acpi@vger.kernel.org>; Wed, 20 Dec 2017 07:30:06 -0800 (PST)
Received: from localhost ([190.175.180.70])
        by smtp.gmail.com with ESMTPSA id v69sm8242209ywg.41.2017.12.20.07.30.04
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Dec 2017 07:30:04 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I post here as a last ressort as advised at the end of this thread
https://www.spinics.net/lists/ibm-acpi-devel/msg04173.html

I own a Thinkpad E555/Kaveri which is overheating.
I noticed fan stopped working soon after a 4.9 => 4.12 (Debian Jessie =>
Stretch) upgrade.
BIOS is up to date, kernel is 4.12.
fan runs during BIOS & GRUB stages (or if booting acpi=off)
The main symptom seems to be that the "fan" module is not loaded.
I already provided information and a couple of ACPI tables in the above thread.

What more may I provide in order to efficiently help getting this
spotted & solved?
