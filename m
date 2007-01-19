From: Bruno Ducrot <ducrot@poupinou.org>
Subject: Re: ACPI _SUN
Date: Fri, 19 Jan 2007 17:37:49 +0100
Message-ID: <20070119163749.GU4945@poupinou.org>
References: <80b0b9460701190156l7a7f95cdnc442787f7fb37b15@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from poup.poupinou.org ([195.101.94.96]:14558 "EHLO
	poup.poupinou.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932566AbXASQxE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Jan 2007 11:53:04 -0500
Content-Disposition: inline
In-Reply-To: <80b0b9460701190156l7a7f95cdnc442787f7fb37b15@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mohan Kumar Jami <mohan124885@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Fri, Jan 19, 2007 at 03:26:26PM +0530, Mohan Kumar Jami wrote:
> Hi,
> 
> I have couple of questions related to _SUN object.
> 
> 1) Is _SUN object be present DSDT tables?

They are defined under DSDT or RSDT tables as any other ACPI objects
populating the ACPI namespace.

> 2) How this DSDT table get updated?

They can't be updated.

> 3) Is DSDT table is static binary file or it can be dynamically updated?

A DSDT table is not a static binary file.  On most i386 or amd64
architectures, DSDT and SSDT are part of the BIOS.
The BIOS uncompressed and copyied them into main memory at the
POST stage since the ROM is too limited in size.

> 4) Who will update the DSDT tables?

By the customer via BIOS updates obtained from the vendor.

Cheers,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
