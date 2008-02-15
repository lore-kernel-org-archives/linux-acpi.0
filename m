From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: 2.6.25-rc1 regression - IBM ACPI backlight
Date: Fri, 15 Feb 2008 12:07:20 +0000
Message-ID: <20080215120720.GA31578@srcf.ucam.org>
References: <20080214103801.GB4366@ics.muni.cz> <20080214122452.GB12775@khazad-dum.debian.net> <20080215110213.GA5648@ics.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:39731 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967AbYBOMHf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Feb 2008 07:07:35 -0500
Content-Disposition: inline
In-Reply-To: <20080215110213.GA5648@ics.muni.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lukas Hejtmanek <xhejtman@ics.muni.cz>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Fri, Feb 15, 2008 at 12:02:13PM +0100, Lukas Hejtmanek wrote:

> 2.6.24 kernel has two acpi_video[01]. 2.6.25-rc1 does not, it contains only
> acpi_video0 (even in text mode in single user without X being loaded) which
> does not work at all.

Sigh. Ok. Could you attach the output of acpidump and lspci, please? 
I'll try to figure out why this is wrong.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
