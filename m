From: Luca Tettamanti <kronos.it@gmail.com>
Subject: Re: [2/4] 2.6.23-rc3: known regressions
Date: Tue, 14 Aug 2007 01:29:34 +0200
Message-ID: <20070813232934.GA1114@dreamland.darkstar.lan>
References: <46C098FD.1030601@googlemail.com> <46C09BFA.5090604@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hu-out-0506.google.com ([72.14.214.224]:60650 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937582AbXHMX3k (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Aug 2007 19:29:40 -0400
Received: by hu-out-0506.google.com with SMTP id 19so1280034hue
        for <linux-acpi@vger.kernel.org>; Mon, 13 Aug 2007 16:29:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <46C09BFA.5090604@googlemail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

Michal Piotrowski ha scritto: 
> Hi all,
> 
> Here is a list of some known regressions in 2.6.23-rc3.
> 
> Feel free to add new regressions/remove fixed etc.
> http://kernelnewbies.org/known_regressions
[...]
> 
> Subject         : FATAL: drivers/acpi/video: sizeof(struct acpi_device_id)=20 is not a modulo of the size of section __mod_acpi_device_table=48
> References      : http://lkml.org/lkml/2007/8/13/584
> Last known good : ?
> Submitter       : Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> Caused-By       : ?
> Handled-By      : ?
> Status          : unknown

Hi Michal,
this is the same as:

Modpost

Subject         : modpost bug breaks ia64 cross compilation
References      : http://lkml.org/lkml/2007/7/27/30
                  http://lkml.org/lkml/2007/7/27/418
Last known good : ?
Submitter       : Jan Dittmer <jdi@l4x.org>
Caused-By       : Thomas Renninger <trenn@suse.de>
                  commit 29b71a1ca74491fab9fed09e9d835d840d042690
Handled-By      : ?
Patch           : http://lkml.org/lkml/2007/8/2/211
Status          : patch was suggested

It affects every cross-compilaton from 32 bit host (e.g. x86) to a 64 bit
target (e.g. x86_64) and (AFAICS, I haven't tried) vice versa.
Very annoying :|

Luca
-- 
"New processes are created by other processes, just like new
 humans. New humans are created by other humans, of course,
 not by processes." -- Unix System Administration Handbook
