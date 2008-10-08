From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Buggy BIOS on the HP TX2500-series
Date: Wed, 8 Oct 2008 20:26:41 +0100
Message-ID: <20081008192641.GA1932@srcf.ucam.org>
References: <331496.52627.qm@web23007.mail.ird.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:47273 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754919AbYJHT0r (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Oct 2008 15:26:47 -0400
Content-Disposition: inline
In-Reply-To: <331496.52627.qm@web23007.mail.ird.yahoo.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Gandalf Kristensen <gandkri@yahoo.no>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

A patch went into the kernel earlier this year to ignore critical trip 
points that were below 0. Does that not deal with the issue?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
