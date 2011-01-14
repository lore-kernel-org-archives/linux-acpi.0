From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 28/48] thermal: Add event notification to thermal framework
Date: Fri, 14 Jan 2011 10:58:58 +0100
Message-ID: <201101141058.59141.trenn@suse.de>
References: <1294827582-4620-1-git-send-email-lenb@kernel.org> <201101131207.01290.trenn@suse.de> <alpine.LFD.2.02.1101132232130.9760@x980>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:58934 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751688Ab1ANJ7B (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 14 Jan 2011 04:59:01 -0500
In-Reply-To: <alpine.LFD.2.02.1101132232130.9760@x980>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, "R.Durgadoss" <durgadoss.r@intel.com>

On Friday 14 January 2011 04:35:16 Len Brown wrote:
> > A dependency from the thermal driver to CONFIG_NET should
> > be avoided if possible.
> 
> Who is using CONFIG_THERMAL without CONFIG_NET today?
I am pretty sure there are productive HW configurations
which do not need any network support.
It's hard or say impossible to imagine and go through all
possible/sane HW/kernel configurations, but especially with
Atom going into the embedded direction, there are probably
(or will come up in the future) HW setups for X86 no ACPI
developer would ever have thought of.
And the chance that a specialized company tries to build
a special kernel for such devices is not zero.

Eh wait thermal is arch/ACPI independent.
The whole CONFIG_NET kernel option would be useless.
You argue: remove CONFIG_NET option and always compile it
into the kernel, because everyone wants to have network
support anyway?

Some other arguements:
  - The netlink specific code parts are nicer arranged and packed
    into an #ifdef/#endif, nice to remove/replace and to keep the
    overview
  - "depends on CONFIG_NET" in the thermal Kconfig looks (and is)
    totally wrong. Should this get spread all over the kernel?
  - randconfig fails. Funny, I saw this thread after submitting
    the patch. Even if randconfig gets extended to only test sane
    configs, !CONFIG_NET is one sane corner case which
    isn't tested every day, but should work. Ideal for
    an automated test tool.

Two sidenotes:
  - The exported thermal_netlink_event should be static and not
    exported in !CONFIG_NET case, my patch should get extended
    by that.
  - This should be discussed on lkml and not linux-acpi, I expect
    you get some more counter-arguements there
 
> Frankly, I'm tempted to make ACPI (falsely) depend on NET
> just to reduce the number of configs we have to test.
Be aware that it's not ACPI but the arch independent
thermal driver!

You also shouldn't let ACPI depend on NET if
there should be netlink patches added, as you say: it's wrong.
And complicating .config dependencies to
"reduce the number of configs we have to test." is
the wrong approach and others will come up with better ideas.
 
> I completely agree with your rename patch,
> the name exported shouldn't be so generic.
> Durgadoss, as Thomas suggests, please update that
> and the dependent driver at the same time.
A bit late for that. Don't know, but I expect there is a
mailinglist that you could have added to get some people
familiar with netlink to look at your patch. Maybe next
time...

   Thomas
