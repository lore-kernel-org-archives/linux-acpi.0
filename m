From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Necessity of SMM/SMI use on ACPI x86 systems
Date: Sun, 3 Apr 2011 16:34:36 +0100
Message-ID: <20110403153436.GA30667@srcf.ucam.org>
References: <SNT111-DS81E1BD67986CA3A41C144A7A00@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:55913 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048Ab1DCPel (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Apr 2011 11:34:41 -0400
Content-Disposition: inline
In-Reply-To: <SNT111-DS81E1BD67986CA3A41C144A7A00@phx.gbl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: limp <johnkyr83@hotmail.com>
Cc: linux-acpi@vger.kernel.org

On Sun, Apr 03, 2011 at 12:40:47PM +0100, limp wrote:

> Can anyone advise me if it's possible to write ACPI AML BIOS code that does
> whatever it was intended to be executed in SMM? In general, is there any
> *strong* argument saying that (at least) current systems cannot completely
> eliminate the use of SMIs?

It's a turing-complete language with full access to the hardware, so 
there's no reason why you can't entirely eliminate SMIs. The usual 
reason not to would be to retain commonality of code for non-ACPI 
environments like the setup screen.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
