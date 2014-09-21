From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 0/3] ACPI: Improve behaviour on Apple hardware
Date: Sun, 21 Sep 2014 02:22:42 +0200
Message-ID: <2602701.nnkzbmBANY@vostro.rjw.lan>
References: <cover.1411211725.git.andreas.noever@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60177 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751393AbaIUAC6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 20 Sep 2014 20:02:58 -0400
In-Reply-To: <cover.1411211725.git.andreas.noever@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: andreas.noever@gmail.com, matthew.garrett@nebula.com
Cc: lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.or, linux-pci@vger.kernel.org, bhelgaas@google.com, Matthew Garrett <mjg59@srcf.ucam.org>

On Saturday, September 20, 2014 01:19:44 PM andreas.noever@gmail.com wrote:
> From: Andreas Noever <andreas.noever@gmail.com>
> 
> This is a resend of Matthew's patches from https://lkml.org/lkml/2014/6/1/165
> which are needed to fully support Thunderbolt on Apple hardware:
> > Apple hardware behaves differently depending on whether or not the OS claims
> > to be Darwin. Failing to report Darwin results in some hardware being
> > disabled.  However, claiming to be Darwin also alters the behaviour of
> > battery reporting and PCI handling. These patches add support for reporting
> > Darwin support and fixing up the behavioural quirks that are exposed as a
> > result.
> Without these patches the firmware will cut power to the controller after
> suspend (at the latest) and the thunderbolt driver will fail.
> 
> I have reordered them such that the two battery fixes/quirks come before the
> _OSI change that breaks battery reporting. I have also merged "ACPI: Don't call
> PCI OSC on Apple hardware when claiming to be Darwin" into "ACPI: Support
> _OSI("Darwin") correctly" to avoid (temporarily) breaking hotplug events and
> modified the patch to not touch ACPICA, as requested by Rafael.

This looks good to me, but I'd like Matthew to say a word here.

Mattew, is this fine by you?

Rafael

