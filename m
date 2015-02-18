From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] ACPI / LPSS: Always disable I2C host controllers
Date: Wed, 18 Feb 2015 17:24 +0100
Message-ID: <3131713.PiPjN0B77i@vostro.rjw.lan>
References: <1424260217-7719-1-git-send-email-mika.westerberg@linux.intel.com> <20150218125408.GR1508@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57167 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752069AbbBRQAq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Feb 2015 11:00:46 -0500
In-Reply-To: <20150218125408.GR1508@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Yang A Fang <yang.a.fang@intel.com>, Yu Chen <yu.c.chen@intel.com>, Graham Whaley <graham.whaley@gmail.com>

On Wednesday, February 18, 2015 02:54:08 PM Mika Westerberg wrote:
> On Wed, Feb 18, 2015 at 01:50:16PM +0200, Mika Westerberg wrote:
> > On Baytrail and Braswell the BIOS might leave the I2C host controllers
> > enabled, probably because it uses them for its on purposes. This is fine in
>                                                  ^^^^^^^^^^^
> As pointed out by Graham Whaley, it should say "own purposes".
> 
> Rafael, do you want me to resend this patch?

No need if the code changes are correct, I can fix up the changelog. :-)


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
