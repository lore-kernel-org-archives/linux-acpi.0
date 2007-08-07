From: Carlos Corbacho <cathectic@gmail.com>
Subject: Re: [RFC][PATCH 0/5] ACPI: acer_acpi
Date: Tue, 7 Aug 2007 18:58:15 +0100
Message-ID: <200708071858.15695.cathectic@gmail.com>
References: <200707171544.57004.cathectic@gmail.com> <200707182058.40193.lenb@kernel.org> <1185358343.3968.57.camel@noname>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:11886 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781AbXHGR5c (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Aug 2007 13:57:32 -0400
Received: by ug-out-1314.google.com with SMTP id j3so104402ugf
        for <linux-acpi@vger.kernel.org>; Tue, 07 Aug 2007 10:57:31 -0700 (PDT)
In-Reply-To: <1185358343.3968.57.camel@noname>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: trenn@suse.de, linux-acpi@vger.kernel.org

Len,

On Wednesday 25 July 2007 11:12:23 Thomas Renninger wrote:
> On Wed, 2007-07-18 at 20:58 -0400, Len Brown wrote:
> > On Tuesday 17 July 2007 10:44, Carlos Corbacho wrote:
> > > The following five patches (against acpi test) add support for Acer
> > > laptops (2005 and newer) that define the PNP0C14 _HID device in ACPI
> > > (aka the Windows Management Instrumentation Device).
> >
> > no, PNP0C14 is not specific to acer,
> > and a platform-specific driver should not be necessary to handle it.
> >
> > I started a wmi.c a while back, and planned to get it out on the
> > list by the end of July.  I've got only one laptop that I can
> > test it on (an HP).  Perhaps you can help me test a generic wmi.c
> > on your Acer?
>
> Add me on the list of volunteers.
> If I find some time, I am eager to give it a test...

Is there any news yet on wmi.c?

-Carlos
-- 
E-Mail: cathectic@gmail.com
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
