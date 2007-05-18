From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Wanted: A program description of the ACPI driver 'battery'
Date: Fri, 18 May 2007 05:47:16 +0100
Message-ID: <20070518044715.GA28428@srcf.ucam.org>
References: <1179460442.5364.22.camel@MD97600>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:38202 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754750AbXERErX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 May 2007 00:47:23 -0400
Content-Disposition: inline
In-Reply-To: <1179460442.5364.22.camel@MD97600>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Detlef Lechner <Detlef.Lechner@gmx.net>
Cc: Mailingliste linux-acpi <linux-acpi@vger.kernel.org>

On Fri, May 18, 2007 at 05:54:02AM +0200, Detlef Lechner wrote:
> Hello,
> 
> Is there publicly available in the Internet a program description of the
> ACPI driver 'battery'

The ACPI specification is available from 
http://www.acpi.info/spec30a.htm . In summary, when queried via /proc, 
the driver evaluates specific ACPI functions. Battery information is 
passed back in a defined structure, and the driver formats this 
information and presents it to the reader.

> Among other things, I am interested to know if there are interferences
> with drivers sbs, i2c_ec and i2c_core which Ubuntu 7.04 also loaded
> automatically.

No.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
