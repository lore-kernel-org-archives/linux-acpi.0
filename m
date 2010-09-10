From: Thomas Renninger <trenn@suse.de>
Subject: Re: [Devel] False positive iasl compiler error on resource object?
Date: Fri, 10 Sep 2010 13:59:48 +0200
Message-ID: <201009101359.48393.trenn@suse.de>
References: <201009101133.31663.trenn@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43441 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753217Ab0IJL7u (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 10 Sep 2010 07:59:50 -0400
In-Reply-To: <201009101133.31663.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: devel@acpica.org
Cc: linux-acpi@vger.kernel.org, bjorn.helgaas@hp.com

On Friday 10 September 2010 11:33:31 Thomas Renninger wrote:
> I have a machine with a _CRS function which shows:
Looks like this (wrong?) check got introduced between:
20100304 (does not show the error) and
20100702 (shows this on quite some machines).

Version 20100806 still has this check.

       Thomas
