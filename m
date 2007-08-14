From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: [2/4] 2.6.23-rc3: known regressions
Date: Tue, 14 Aug 2007 08:37:13 +0200
Message-ID: <6bffcb0e0708132337n5d0fe2bbxe4ead92ebca2213a@mail.gmail.com>
References: <46C098FD.1030601@googlemail.com> <46C09BFA.5090604@googlemail.com>
	 <20070813232934.GA1114@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:60115 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755983AbXHNGhO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Aug 2007 02:37:14 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2079717wah
        for <linux-acpi@vger.kernel.org>; Mon, 13 Aug 2007 23:37:14 -0700 (PDT)
In-Reply-To: <20070813232934.GA1114@dreamland.darkstar.lan>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

On 14/08/07, Luca Tettamanti <kronos.it@gmail.com> wrote:
> Michal Piotrowski ha scritto:
> > Hi all,
> >
> > Here is a list of some known regressions in 2.6.23-rc3.
> >
> > Feel free to add new regressions/remove fixed etc.
> > http://kernelnewbies.org/known_regressions
> [...]
> >
> > Subject         : FATAL: drivers/acpi/video: sizeof(struct acpi_device_id)=20 is not a modulo of the size of section __mod_acpi_device_table=48
> > References      : http://lkml.org/lkml/2007/8/13/584
> > Last known good : ?
> > Submitter       : Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> > Caused-By       : ?
> > Handled-By      : ?
> > Status          : unknown
>
> Hi Michal,
> this is the same as:
>
> Modpost
>
> Subject         : modpost bug breaks ia64 cross compilation
> References      : http://lkml.org/lkml/2007/7/27/30
>                   http://lkml.org/lkml/2007/7/27/418
> Last known good : ?
> Submitter       : Jan Dittmer <jdi@l4x.org>
> Caused-By       : Thomas Renninger <trenn@suse.de>
>                   commit 29b71a1ca74491fab9fed09e9d835d840d042690
> Handled-By      : ?
> Patch           : http://lkml.org/lkml/2007/8/2/211
> Status          : patch was suggested

Indeed, thanks.

>
> It affects every cross-compilaton from 32 bit host (e.g. x86) to a 64 bit
> target (e.g. x86_64) and (AFAICS, I haven't tried) vice versa.
> Very annoying :|
>
> Luca

Regards,
Michal

-- 
LOG
http://www.stardust.webpages.pl/log/
