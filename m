From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFD] How to tell ACPI drivers what the target sleep state is (was: Re: [PATCH 1/2] acpi choose sleep state help)
Date: Thu, 21 Jun 2007 09:35:58 -0700
Message-ID: <200706210935.59004.david-b@pacbell.net>
References: <1182220394.14837.9.camel@sli10-conroe.sh.intel.com> <20070621130312.GB18392@elf.ucw.cz> <200706211646.06594.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:26389 "HELO
	smtp111.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758540AbXFUQf6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Jun 2007 12:35:58 -0400
In-Reply-To: <200706211646.06594.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>, Shaohua Li <shaohua.li@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Thursday 21 June 2007, Rafael J. Wysocki wrote:

> So, can we make pm_message_t consist only of the target state?

Let's just finally get rid of pm_message_t.
