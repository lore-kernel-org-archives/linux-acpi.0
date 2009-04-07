From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: sony-laptop: ACPI Exception when a Fn-Key is pressed
Date: Tue, 07 Apr 2009 10:13:17 +0800
Message-ID: <1239070397.3582.171.camel@localhost.localdomain>
References: <7a3045780904051727o3780c7d3hebb26028a1b4eba5@mail.gmail.com>
	 <20090406110154.GA25085@kamineko.org>
	 <7a3045780904060613x4ba373c6o7447e511d3841cfa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:59963 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751437AbZDGCMO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 6 Apr 2009 22:12:14 -0400
In-Reply-To: <7a3045780904060613x4ba373c6o7447e511d3841cfa@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rodrigo Luiz <rodrigo@gus-mg.org>
Cc: Mattia Dongili <malattia@linux.it>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Mon, 2009-04-06 at 21:13 +0800, Rodrigo Luiz wrote:
> On Mon, Apr 6, 2009 at 8:01 AM, Mattia Dongili <malattia@linux.it> wrote:
> >
> > Does booting with acpi_osi=Linux makes things any worse? (it should fix
> > the above error but might make some other functionality behave
> > differently).
> > Or eventually also see if there is a bios upgrade available for your
> > laptop.
> >
> 
Does the warning message exist when booting the previous kernel? For
example: 2.6.28 kernel.

Will you please try the following commit patch and see whether this issue still exists?
   >commit 7b46ecd5fcebf381a7bde966db352d8fb1b8e944
   >Author: Len Brown <len.brown@intel.com>
   >Date:   Wed Feb 25 18:00:18 2009 -0500
     >Revert "ACPI: make some IO ports off-limits to AML"

thanks.
> Booting with acpi_osi=Linux does not make any changes. Kernel show the
> same messages.
> 
> And there is no bios upgrade for my notebook :(
> 
> I forgot to say two things:
> 
> When I loaded the module, a new message appeared (booting with and
> without acpi_osi=Linux):
> 
> sony-laptop: Sony Notebook Control Driver v0.6.
> input: Sony Vaio Keys as /class/input/input9
> input: Sony Vaio Jogdial as /class/input/input10
> --> [Firmware Bug]: ACPI: ACPI brightness control misses _BQC function
> sony-laptop: brightness ignored, must be controlled by ACPI video driver
> 
> 
> And these errors show in any ACPI events (lid open/close, press power
> button ...), not just in Fn-Keys.
> 

