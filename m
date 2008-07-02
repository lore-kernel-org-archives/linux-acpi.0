From: Eduard - Gabriel Munteanu <eduard.munteanu@linux360.ro>
Subject: Re: dsdt buggy acpi
Date: Wed, 2 Jul 2008 14:48:20 +0300
Message-ID: <20080702144820.29f7d43d@linux360.ro>
References: <dd18b0c30806302339q7b3effybf8a7f619b009262@mail.gmail.com>
	<200807011619.53339.rjw@sisk.pl>
	<dd18b0c30807010918p48cfbe2bnb7e4a2bf00a01638@mail.gmail.com>
	<20080702082555.0959ef2b@linux360.ro>
	<20080702100935.GA699@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from [194.117.236.238] ([194.117.236.238]:37616 "EHLO
	heracles.linux360.ro" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1759066AbYGBLtZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jul 2008 07:49:25 -0400
In-Reply-To: <20080702100935.GA699@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Justin Mattock <justinmattock@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Wed, 2 Jul 2008 11:09:35 +0100
Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> On Wed, Jul 02, 2008 at 08:25:55AM +0300, Eduard - Gabriel Munteanu
> wrote:
> 
> > Just one note here: DSDTs have nothing to do with the kernel. This
> > is just broken firmware. The most one can do _in-kernel_ is
> > blacklist some functionality or create a workaround, but this only
> > happens for widely used stuff. Broken DSDTs aren't widely used
> > stuff, they are written by the machine's vendor (the laptop's
> > manufacturer for example, but this could be different for desktops)
> > and differ a lot from one machine to another.
> 
> We've made a huge number of workarounds for buggy DSDT
> implementations.

Of course, I myself used a custom DSDT for my laptop. But I was saying
that these workarounds generally do not belong to the kernel realm.

This isn't the regular "Pentium F00F bug" stuff; instead bugs in DSDTs
consist of compiling issues, non-standard compliant, plainly bad
code, Windows-only stuff, which can all be unique for every model of a
laptop for example. While the kernel may be able to get around some of
that stuff, the kernel won't have any Asus, Acer etc. specific
workarounds.
