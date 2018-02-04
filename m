From: "Marty E. Plummer" <hanetzer@startmail.com>
Subject: acpi: sbs* 'correct' ACPI setup/requirements assistance
Date: Sat, 3 Feb 2018 22:08:57 -0600
Message-ID: <20180204040856.foo33masxtphaba7@proprietary-killer.fossland>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx-out1.startmail.com ([145.131.90.139]:37367 "EHLO
        mx-out1.startmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbeBDEOu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 3 Feb 2018 23:14:50 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, lenb@kernel.org

Greetings,

I'm currently working on a coreboot port to the hp g7-2247us[1] and am
looking to implement the needed bits to enable smart battery support in
the acpi tables, and am running into a some issues and potential
misunderstandings as to how it should be handled.

Currently I end up with the following message in dmesg:

sbs: probe of ACPI0002:000 failed with error -62

Which is drivers/acpi/sbshc.c:wait_transaction_complete -ETIME; it was
my understanding that the _EC field 0xYYZZ should be the offset of the
EC ram's for the various SMBus stuff and 0xZZ should be the ec _QZZ
query method to handle it (gathered from some macbook acpi tables I've
located online which implement it). I believe the proper hardware is
there for this to work)

Any suggestions or pointers on this would be of great help.

Regards,

Marty

1: https://review.coreboot.org/c/coreboot/+/23352
