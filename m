From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: acpi-test tree on eeepc: EC error message on second resume
Date: Sat, 11 Oct 2008 21:30:57 +0200
Message-ID: <200810112130.57757.rjw@sisk.pl>
References: <48F0DB0C.7060201@tuffmail.co.uk> <48F0ED3A.9010001@tuffmail.co.uk> <48F0F2C6.6030000@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:59076 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759230AbYJKT0k (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 11 Oct 2008 15:26:40 -0400
In-Reply-To: <48F0F2C6.6030000@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, linux acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Saturday, 11 of October 2008, Alexey Starikovskiy wrote:
> Alan Jenkins wrote:
> > I think I found the problem.  The "input buffer empty" wait depends on
> > "interrupt mode" to work properly, and we don't immediately enable the
> > interrupt on resume.  The wait should have a polling fallback anyway, to
> > be consistent with the other transaction waits.
> > 
> > Alan
> Yep, I think something like attached patch may help:

[Can you please append patches instead of or apart from attaching them?
That would make it easier to comment them.]

if (!wait_event_timeout(ec->wait, ec_check_ibf0(ec),
-                               msecs_to_jiffies(ACPI_EC_DELAY))) {
+                               msecs_to_jiffies(ACPI_EC_DELAY)) &&
+           !ec_check_ibf0(ec)) {

Shouldn't this go under the spinlock?  Surely it can race with the GPE handler.

                pr_err(PREFIX "input buffer is not empty, "
                                "aborting transaction\n");

Thanks,
Rafael
