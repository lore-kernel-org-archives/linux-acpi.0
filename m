From: John Belmonte <john@neggie.net>
Subject: Re: experimental patch for toshiba_acpi
Date: Thu, 26 Feb 2009 08:12:11 -0500
Message-ID: <a0c408570902260512t702b2575w417ef96dfa74a5bf@mail.gmail.com>
References: <E1LcL9o-0003qC-4s@tan.cit.nih.gov>
	 <20090225152409.GA4015@srcf.ucam.org>
	 <1235578705.4770.57.camel@penguin.lifesci.dundee.ac.uk>
	 <20090225165152.GA5981@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:57234 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752658AbZBZNMO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Feb 2009 08:12:14 -0500
Received: by qw-out-2122.google.com with SMTP id 5so955328qwi.37
        for <linux-acpi@vger.kernel.org>; Thu, 26 Feb 2009 05:12:11 -0800 (PST)
In-Reply-To: <20090225165152.GA5981@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Jonathan Buzzard <jonathan@buzzard.me.uk>, Charles@schwieters.org, linux-acpi@vger.kernel.org, Richard Hughes <hughsient@gmail.com>

On Wed, Feb 25, 2009 at 11:51 AM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Wed, Feb 25, 2009 at 04:18:25PM +0000, Jonathan Buzzard wrote:
>
>> Because it makes far more sense to have a user mode program to drive the
>> features, and for the kernel to provide the necessary thin layer to
>> access the features.
>
> It makes sense for the kernel to provide a consistent abstraction of
> hardware functionality where possible. Almost every kernel driver could
> be rewritten in userspace - that doesn't make it a good idea.

That argument would be most applicable if we were talking about adding
some new /dev interface-- but we're not.  Toshiba's HCI has been
around for a couple of decades; /dev/toshiba, which exposes it, has
been around for over 10 years; toshset, a useful and popular tool
which depends on /dev/toshiba, nearly as long as /dev/toshiba.

The proposed patch makes /dev/toshiba, and hence toshset, work on more
laptops-- it's a no-brainer to anyone with a practical mindset.
You've got Jonathan and Charles-- the two most-knowledgeable people on
Toshiba's firmware and /dev/toshiba in the free software community--
saying that it's not practical to jam all that functionality into the
kernel.  Please listen to them.

Regards,
--John
