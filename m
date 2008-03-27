From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [RFC][PATCH] PM: Introduce new top level
 =?iso-8859-1?q?suspend=09and_hibernation_callbacks?= (rev. 2)
Date: Wed, 26 Mar 2008 22:48:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0803262246460.21714-100000@netrider.rowland.org>
References: <200803262146.39899.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:1028 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755740AbYC0CsU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Mar 2008 22:48:20 -0400
In-Reply-To: <200803262146.39899.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Oliver Neukum <oliver@neukum.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Alexey Starikovskiy <astarikovskiy@suse.de>, Johannes Berg <johannes@sipsolutions.net>, LKML <linux-kernel@vger.kernel.org>

On Wed, 26 Mar 2008, Rafael J. Wysocki wrote:

> What exactly do you whink would be wrong with using the error codes to avoid
> resuming the children of devices that failed to resume?

Nothing, I guess.  Drivers should work okay either way.

Alan Stern

