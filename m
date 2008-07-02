From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: dsdt buggy acpi
Date: Wed, 2 Jul 2008 11:09:35 +0100
Message-ID: <20080702100935.GA699@srcf.ucam.org>
References: <dd18b0c30806302339q7b3effybf8a7f619b009262@mail.gmail.com> <200807011619.53339.rjw@sisk.pl> <dd18b0c30807010918p48cfbe2bnb7e4a2bf00a01638@mail.gmail.com> <20080702082555.0959ef2b@linux360.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:48212 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763201AbYGBKJk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jul 2008 06:09:40 -0400
Content-Disposition: inline
In-Reply-To: <20080702082555.0959ef2b@linux360.ro>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Eduard - Gabriel Munteanu <eduard.munteanu@linux360.ro>
Cc: Justin Mattock <justinmattock@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Wed, Jul 02, 2008 at 08:25:55AM +0300, Eduard - Gabriel Munteanu wrote:

> Just one note here: DSDTs have nothing to do with the kernel. This is
> just broken firmware. The most one can do _in-kernel_ is blacklist some
> functionality or create a workaround, but this only happens for widely
> used stuff. Broken DSDTs aren't widely used stuff, they are written by
> the machine's vendor (the laptop's manufacturer for example, but this
> could be different for desktops) and differ a lot from one machine to
> another.

We've made a huge number of workarounds for buggy DSDT implementations.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
