From: Jeff Chua <jeff.chua.linux@gmail.com>
Subject: Re: [PATCH 8/8] ACPI / PM: Use existing ACPI iomaps for NVS
 save/restore (v2)
Date: Sat, 5 Feb 2011 23:31:23 +0800
Message-ID: <AANLkTi=nAhadVy6y6f4uOy0-pvTQrdwYgQ0y_4ukui2z@mail.gmail.com>
References: <201101201226.41021.rjw@sisk.pl>
	<201101250025.10817.rjw@sisk.pl>
	<201101250032.07423.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201101250032.07423.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg59@srcf.ucam.org>
List-Id: linux-acpi@vger.kernel.org

The suspend monster is back! The suspend-to-ram is fine, but upon
resume, screen is blank. Haven't bisected in case someone has also
done so.

It's very recent. ... between commit
831d52bc153971b70e64eccfbed2b232394f22f8 and
44f2c5c841da1b1e0864d768197ab1497b5c2cc1.

Thanks,
Jeff
