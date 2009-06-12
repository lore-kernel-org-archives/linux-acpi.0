From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] PM updates for 2.6.31
Date: Fri, 12 Jun 2009 13:19:22 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0906121317320.3237@localhost.localdomain>
References: <200906122202.08345.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53252 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754282AbZFLUVX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 12 Jun 2009 16:21:23 -0400
In-Reply-To: <200906122202.08345.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, Cornelia Huck <cornelia.huck@de.ibm.com>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ingo Molnar <mingo@elte.hu>, Jaswinder Singh Rajput <jaswinder@kernel.org>, Lauro Salmito <laurosalmito@gmail.com>, Magnus Damm <damm@igel.co.jp>, Wu Fengguang <fengguang.wu@intel.com>, Sergio Luis <sergio@larces.uece.br>



On Fri, 12 Jun 2009, Rafael J. Wysocki wrote:

> Hi Linus,
> 
> Please pull power management updates for 2.6.31 from:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git for-linus
> 
> They are cleanups and code rearrangements mostly, in particular:
> 
> * arch/x86/power/cpu_(32|64) unification from Sergio Luis (Ingo saw
>   these patches and his opinion was that they should better go
>   through the suspend tree)
> 
> * Removal of some unused files and PM callbacks, function renames
>   from Magnus Damm and Alan Stern
> 
> * Rearrangements of the code under kernel/power from me and
>   Cornelia Huck
> 
> * Two patches related to the memory shrinking (for the record, Pavel
>   doesn't like the "PM/Suspend: Do not shrink memory before suspend"
>   patch, so please let me know if I should drop it)
> 
> * A couple of bug fixes
> 
> 
>  arch/x86/power/cpu.c             |  259 +++++++++++
>  arch/x86/power/cpu_32.c          |  148 ------
>  arch/x86/power/cpu_64.c          |  174 -------
>  kernel/power/disk.c              |  955 --------------------------------------
>  kernel/power/hibernate.c         |  955 ++++++++++++++++++++++++++++++++++++++
>  kernel/power/hibernate_nvs.c     |  135 ++++++
>  35 files changed, 2056 insertions(+), 2194 deletions(-)

Please add rename detection to your pull script (and --summary, for that 
matter). This _should_ have looked like

 33 files changed, 984 insertions(+), 1122 deletions(-)

because it would have detected this:

 rename arch/x86/power/{cpu_64.c => cpu.c} (62%)
 delete mode 100644 arch/x86/power/cpu_32.c
 rename kernel/power/{disk.c => hibernate.c} (96%)

instead of counting those as some huge patches that add/remove code.

		Linus
