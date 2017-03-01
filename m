From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 1/4] Revert"x86/acpi: Set persistent cpuid <-> nodeid
 mapping when booting"
Date: Wed, 1 Mar 2017 11:51:04 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1703011137560.4005@nanos>
References: <1487580471-17665-1-git-send-email-douly.fnst@cn.fujitsu.com> <1487580471-17665-2-git-send-email-douly.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1487580471-17665-2-git-send-email-douly.fnst@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: mingo@kernel.org, peterz@infradead.org, rjw@rjwysocki.net, hpa@zytor.com, rafael@kernel.org, cl@linux.com, tj@kernel.org, akpm@linux-foundation.org, rafael.j.wysocki@intel.com, len.brown@intel.com, izumi.taku@jp.fujitsu.com, xiaolong.ye@intel.com, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 20 Feb 2017, Dou Liyang wrote:

> Currently, We make the mapping of "cpuid <-> nodeid" fixed at the booting time.
> It keeps consistent with the WorkQueue and avoids some bugs which may be caused
> by the dynamic assignment.
> 
> But, The ACPI table is unreliable and it is very risky that we use the entity
> which isn't related to a physical device at booting time.
> 
> Now, we revert our patches. Do the last mapping of "cpuid <-> nodeid" at
> hot-plug time, not at booting time where we did some useless work.
> It also can make the mapping of "cpuid <-> nodeid" fixed and avoid excessive
> use of the ACPI table.
> 
> The patch revert the commit dc6db24d24:
>   "x86/acpi: Set persistent cpuid <-> nodeid mapping when booting".

That changelog needs some massaging. Something like this:

  The mapping of "cpuid <-> nodeid" is established at boot time via ACPI
  tables to keep associations of workqueues and other node related items
  consistent across cpu hotplug.

  But, ACPI tables are unreliable and failures with that boot time mapping
  have been reported on machines where the ACPI table and the physical
  information which is retrieved at actual hotplug is inconsistent.

  Revert the mapping implementation so it can be replaced with a less error
  prone approach.

This clearly describes:

  1) The context

  2) The problem

  3) The solution (revert)

You don't have to explain what the new solution will be in the changelog of
the revert. For the revert it's only relevant WHY we do the revert.

Please avoid writing changelogs in 'we' form. Write it pure technical, like
a manual.

Also avoid phrases like: "The patch/This patch". We all know already that
this is a patch, otherwise it wouldn't have been sent.

Documentation/process/submitting-patches.rst says:

  Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
  instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
  to do frotz", as if you are giving orders to the codebase to change
  its behaviour.

Thanks,

	tglx
