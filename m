From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] Resume from Memory very slow on 2.6.37+
Date: Tue, 18 Jan 2011 02:35:59 +0100
Message-ID: <201101180235.59498.rjw@sisk.pl>
References: <AANLkTimBEnKTuR5aQyXvpZX8grQPw1eCaVgP-k9yBXhv@mail.gmail.com> <201101180114.42664.rjw@sisk.pl> <AANLkTi=nGmW=3XGRzxJ1avbz-PcE_QSdVBddOM1yMiBh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:46257 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752589Ab1ARBgb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Jan 2011 20:36:31 -0500
In-Reply-To: <AANLkTi=nGmW=3XGRzxJ1avbz-PcE_QSdVBddOM1yMiBh@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, Jack Steiner <steiner@sgi.com>, Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Tuesday, January 18, 2011, Jeff Chua wrote:
> On Tue, Jan 18, 2011 at 2:55 AM, Brown, Len <len.brown@intel.com> wrote:
> > added Linux-acpi to cc
> >
> > any difference if you boot with acpi_sleep=nonvs ?
> 
> That works.
> 
> On Tue, Jan 18, 2011 at 8:14 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >> What happens if you replace the acpi_os_map_memory() in
> >> suspend_nvs_save() with ioremap_cache() and the acpi_os_unmap_memory() in
> >> suspend_nvs_free() with iounmap() ?
> >
> > IOW, can you please test if the patch below makes a difference?
> >  drivers/acpi/nvs.c |    6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> That works too.

Interesting.

Do you have CONFIG_RCU_CPU_STALL_DETECTOR set?  If not, please set it.  Then,
set CONFIG_RCU_CPU_STALL_TIMEOUT to something like 10 (in either case), run
a suspend-resume cycle and see if there are any CPU stalls reported in the
logs. 

We can avoid calling synchronize_rcu() in suspend_nvs_free(), but I'd like
to know _why_ it's stalling in there.

> Now I have another problem which might be totally unrelated. Just
> realized that my notebook can't suspend to "disk" ... used to work
> last week. So, something has changed as well. May be someone has
> already reported/fixed this.

Not that I know of.  What do you mean by "can't suspend"?

Rafael
