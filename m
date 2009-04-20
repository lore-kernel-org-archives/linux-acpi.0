From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Add support for Eject hotkey in dell-wmi
Date: Mon, 20 Apr 2009 19:48:07 +0100
Message-ID: <20090420184807.GA3490@srcf.ucam.org>
References: <49ECBAE2.2080308@dell.com> <20090420182312.GA2910@srcf.ucam.org> <49ECBE35.9040003@dell.com> <20090420182848.GA3105@srcf.ucam.org> <49ECC279.2080607@dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:46660 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753485AbZDTSsN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Apr 2009 14:48:13 -0400
Content-Disposition: inline
In-Reply-To: <49ECC279.2080607@dell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Apr 20, 2009 at 01:44:09PM -0500, Mario Limonciello wrote:

>    I've checked with the BIOS teams further, and they indicated at the time
>    that this is enabled on those consumer systems, the hotkey should be
>    switched over to a mechanical key rather than a software key, so the
>    keyboard interface would not see this key.  The support in the BIOS to
>    turn on and off WMI would actually enable SMI hot key events instead
>    (which could then be serviced by dell-laptop).

Ah, ok, that's fine. As long as the event will only be delivered either 
via WMI or the keyboard controller then we should be good.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
