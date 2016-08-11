From: Baoquan He <bhe@redhat.com>
Subject: Re: [Patch v3 2/2] x86/acpi: Remove the repeated lapic address
 override entry parsing
Date: Thu, 11 Aug 2016 22:21:27 +0800
Message-ID: <20160811142127.GB26981@x1.redhat.com>
References: <1469877001-18393-1-git-send-email-bhe@redhat.com>
 <1469877001-18393-2-git-send-email-bhe@redhat.com>
 <20160810140257.GB22965@gmail.com>
 <20160810141340.GA5477@x1.redhat.com>
 <20160811083742.GA3645@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55302 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750708AbcHKOVb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Aug 2016 10:21:31 -0400
Content-Disposition: inline
In-Reply-To: <20160811083742.GA3645@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: rjw@rjwysocki.net, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org

On 08/11/16 at 10:37am, Ingo Molnar wrote:
> 
> * Baoquan He <bhe@redhat.com> wrote:
> 
> > On 08/10/16 at 04:02pm, Ingo Molnar wrote:
> > > 
> > > * Baoquan He <bhe@redhat.com> wrote:
> > > 
> > > > ACPI MADT has a 32-bit field providing lapic address at which
> > > > each processor can access its lapic information. MADT also contains
> > > > an optional entry to provide a 64-bit address to override the 32-bit
> > > > one. However the current code does the lapic address override entry
> > > > parsing twice. One is in early_acpi_boot_init() because AMD NUMA need
> > > > get boot_cpu_id earlier. The other is in acpi_boot_init() which parses
> > > > all MADT entries.
> > > > 
> > > > So in this patch remove the repeated code in the 2nd part. Meanwhile
> > > > print lapic override entry information like other MADT entry, this
> > > > will be added to boot log.
> > > 
> > > it is not at all clear to me from this changelog whether the change is supposed to 
> > > change anything. If not then please spell it out explicitly:
> > > 
> > >   "This patch is not supposed to change any behavior."
> > 
> > I don't know if adding new information to boot log can be seen as
> > behavior change. If lapic override entry exist, the code change will
> > add one line of message to boot log:
> > 
> > 	LAPIC_ADDR_OVR (address[0xXXXXXXXX])
> > 
> > If this is not behavior change, I will add the sentence you suggested.
> 
> Yeah, you can write it:
> 
> 	"This patch is not supposed to change any runtime behavior, other than 
> 	 improving kernel messages."

Got it, will copy this to patch log and repost. Thanks a lot!

Thanks
Baoquan

