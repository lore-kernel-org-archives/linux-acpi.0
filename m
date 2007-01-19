From: Len Brown <lenb@kernel.org>
Subject: Re: ACPI _SUN
Date: Fri, 19 Jan 2007 14:51:34 -0500
Message-ID: <200701191451.34693.lenb@kernel.org>
References: <80b0b9460701190156l7a7f95cdnc442787f7fb37b15@mail.gmail.com> <20070119163749.GU4945@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49922 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932864AbXASTxD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Jan 2007 14:53:03 -0500
In-Reply-To: <20070119163749.GU4945@poupinou.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bruno Ducrot <ducrot@poupinou.org>
Cc: Mohan Kumar Jami <mohan124885@gmail.com>, linux-acpi@vger.kernel.org

On Friday 19 January 2007 11:37, Bruno Ducrot wrote:
> On Fri, Jan 19, 2007 at 03:26:26PM +0530, Mohan Kumar Jami wrote:
> > Hi,
> > 
> > I have couple of questions related to _SUN object.
> > 
> > 1) Is _SUN object be present DSDT tables?
> 
> They are defined under DSDT or RSDT tables as any other ACPI objects
> populating the ACPI namespace.

The DSDT and all the SSDT's listed in the RSDT are all loaded at boot-time.

However, the BIOS AML can also explicitly Load additional "dynamic" SSDTs
at run-time -- and can also Unload an SSDT.
In this way, objects in the name space can appear and go away at run-time.

_SUN, Slot User Number, is an (optional) property of an object.
So for it to change at run-time, the object that contains it
would have to go away and then come back.

cheers,
-Len

> > 2) How this DSDT table get updated?
> 
> They can't be updated.
> 
> > 3) Is DSDT table is static binary file or it can be dynamically updated?
> 
> A DSDT table is not a static binary file.  On most i386 or amd64
> architectures, DSDT and SSDT are part of the BIOS.
> The BIOS uncompressed and copyied them into main memory at the
> POST stage since the ROM is too limited in size.
> 
> > 4) Who will update the DSDT tables?
> 
> By the customer via BIOS updates obtained from the vendor.
> 
> Cheers,
> 
