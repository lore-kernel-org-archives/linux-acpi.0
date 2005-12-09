From: "Brown, Len" <len.brown@intel.com>
Subject: RE: ACPI owner_id limit too low
Date: Thu, 8 Dec 2005 23:32:13 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30055EA5DF@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751277AbVLIEcZ@vger.kernel.org>
Content-class: urn:content-classes:message
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@hp.com>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

Hi Alex,

Yes, ACPICA 20051202 upped the limit to 255 from 32,
but as it is mixed in with some other large changes,
I'm thinking I'll that release soak until the opening
of 2.6.17.

So if you need a higher limit in 2.6.15 we can
push this simpler patch, of if Linus shuts down
2.6.15 when we returns we can send it to stable to
get into 2.6.15.*

thanks,
-Len
