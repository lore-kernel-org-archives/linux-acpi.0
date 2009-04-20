From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Add support for Eject hotkey in dell-wmi
Date: Mon, 20 Apr 2009 19:23:12 +0100
Message-ID: <20090420182312.GA2910@srcf.ucam.org>
References: <49ECBAE2.2080308@dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:48226 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229AbZDTSXP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Apr 2009 14:23:15 -0400
Content-Disposition: inline
In-Reply-To: <49ECBAE2.2080308@dell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Apr 20, 2009 at 01:11:46PM -0500, Mario Limonciello wrote:
> Hi:
> 
> I've gotten word that future Dell consumer laptops are transitioning
> several hotkeys to WMI instead.  Here's a patch to enable the first to
> enable the Eject hotkey.  I'm attaching it since my mail server
> (exchange) would mangle it otherwise.

Looks good - can you confirm that it'll be removed from the normal 
keyboard interface at the same time?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
