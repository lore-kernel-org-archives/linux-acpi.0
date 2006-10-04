From: Richard Hughes <hughsient@gmail.com>
Subject: Lenovo 3000 N100: no battery rate
Date: Wed, 04 Oct 2006 21:35:41 +0100
Message-ID: <1159994141.2821.12.camel@hughsie-laptop.localdomain>
Reply-To: hughsient@gmail.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:17104 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751095AbWJDUf6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 4 Oct 2006 16:35:58 -0400
Received: by ug-out-1314.google.com with SMTP id o38so117734ugd
        for <linux-acpi@vger.kernel.org>; Wed, 04 Oct 2006 13:35:57 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hey,

My new Lenovo 3000 N100 works great with ACPI Linux of the box -- with
one exception.

"cat /proc/acpi/battery/BAT1/state" *always* reports "present rate: 0
mA" - which means I get no rate information for gnome-power-manager, and
hence no graphs or data on the power usage.

As the author of gnome-power-manager this is a bad thing :-)

I've checked out my DSDT with iasl and there are no reported problems.
I'm also running 2.6.18 and using the latest (1.02 bios) I don't know
where or how to start debugging this so I'm asking for advice.

Thanks guys,

Richard Hughes


