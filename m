From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [RFC][PATCH 0/3] Introduce GPE refcounting (was: Re: Recent
 GPE patches - some questions.)
Date: Wed, 10 Feb 2010 23:29:53 +0200
Message-ID: <1265837393.8599.2.camel@maxim-laptop>
References: <4911F71203A09E4D9981D27F9D83085855AF782E@orsmsx503.amr.corp.intel.com>
	 <4911F71203A09E4D9981D27F9D83085855BBDA89@orsmsx503.amr.corp.intel.com>
	 <201002070031.54680.rjw@sisk.pl>  <201002070317.47029.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:56955 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640Ab0BJV36 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Feb 2010 16:29:58 -0500
Received: by bwz19 with SMTP id 19so596171bwz.28
        for <linux-acpi@vger.kernel.org>; Wed, 10 Feb 2010 13:29:57 -0800 (PST)
In-Reply-To: <201002070317.47029.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Moore, Robert" <robert.moore@intel.com>, Matthew Garrett <mjg@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>

On Sun, 2010-02-07 at 03:17 +0100, Rafael J. Wysocki wrote: 
> On Sunday 07 February 2010, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > On Wednesday 03 February 2010, Moore, Robert wrote:
> > > Matthew, 
> > > 
> > > Thanks for your response to my questions.
> > > 
> > > I've been thinking about these interfaces:
> > > 
> > > acpi_ref_runtime_gpe
> > > acpi_ref_wakeup_gpe
> > > acpi_unref_runtime_gpe
> > > acpi_unref_wakeup_gpe
> > > 

One minor, mostly off-topic question.
Currently to enable static wakeup one has to write /proc/acpi/wakeup.
Do you consider propagating device wakeup settings to acpi,
so /proc/acpi/wakeup could finally be deprecated?

Best regards,
Maxim Levitsky

