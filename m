From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [linux-pm] [RFC] why do we need run disk sync before entering?S3
Date: Sun, 24 May 2009 23:02:55 +0200
Message-ID: <200905242302.55640.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0905131000360.3004-100000@iolanthe.rowland.org> <200905231105.03828.oliver@neukum.org> <20090523094518.GB8782@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:43541 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753350AbZEXVCb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 24 May 2009 17:02:31 -0400
In-Reply-To: <20090523094518.GB8782@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.linux-foundation.org, Zhang Rui <rui.zhang@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

Am Samstag, 23. Mai 2009 11:45:18 schrieb Pavel Machek:
> suspend.sf.net, program s2both :-).

Cool. What happens if you crash after unfreezing user space but before you
declare the image invalid?

	Regards
		Oliver

