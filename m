From: Andrew Morton <akpm@osdl.org>
Subject: Re: [Ubuntu PATCH] disable ACPI on some Phoenix BIOS
Date: Wed, 21 Jun 2006 18:46:35 -0700
Message-ID: <20060621184635.22ed5276.akpm@osdl.org>
References: <4498DA03.2020001@oracle.com>
	<20060621105208.GB6416@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:37535 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030492AbWFVBqo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Jun 2006 21:46:44 -0400
In-Reply-To: <20060621105208.GB6416@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: randy.dunlap@oracle.com, linux-acpi@vger.kernel.org, len.brown@intel.com

On Wed, 21 Jun 2006 11:52:08 +0100
Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> On Tue, Jun 20, 2006 at 10:32:51PM -0700, Randy Dunlap wrote:
> > Disable ACPI on some Phoenix BIOS, or the system will freeze.
> 
> Yeah, this was a quick workaround. I think we'd probably be better off 
> figuring out /why/ the system was freezing, but, well.

How do we find out whose machine had the problem?
