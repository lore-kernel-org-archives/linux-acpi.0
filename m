From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [RFC] EC registers - Adding sysfs interface?
Date: Wed, 14 Nov 2007 00:40:49 -0200
Message-ID: <20071114024049.GA10677@khazad-dum.debian.net>
References: <200711131724.31868.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:35746 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755082AbXKNDBG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 13 Nov 2007 22:01:06 -0500
Content-Disposition: inline
In-Reply-To: <200711131724.31868.carlos@strangeworlds.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: astarikovskiy@suse.de, linux-acpi@vger.kernel.org

On Tue, 13 Nov 2007, Carlos Corbacho wrote:
> I'm considering writing a sysfs interface for the EC registers, and was 
> wondering if you would be ok with such a patch (before I start work on it)?

I have exactly such a beast in thinkpad-acpi (using /proc, though),
inherited from ibm-acpi who has had it for a LONG while.  So, I feel
entitled to share some of my experiences with it...

To make it short:

1. It is dangerous.  There is no other way to look at it.  Even reads can
   have side-effects on some boxes.   Writing can do *very* dangerous
   things.  So, it is a "use it only when told to by someone who actually
   knows what it does" tool for the vast majority out there.

2. Users will enable it even if they don't know what they're doing, and they
   will use it as if it were just yet another toy, no matter how many
   warnings you give them.  They will place scripts using it on Wikis, and
   you will get to hear about it for a long, long time.

3. Unless you stick *heavy* warnings, and require explicit enabling through
   module parameters/kernel command line, distros will enable it and *you*
   will get the blame and complains when it blows up something.

4. A binary attribute that can handle mmap() is a much better interface
   IMHO (or just use a plain UNIX char device).

So, while I am *for* adding such a thing (it has proved to be useful on
thinkpads), I'd say you should at least require a lot of steps to enable it,
and I do NOT mean a sysfs "write 1 here to enable" attribute.

I am against the idea of providing this as a regular (non-debug) tool for
usespace to poke at, for the simple reason that once you have "userspace
drivers" messing with it, all hope is lost to track the hardware state on
write-only registers.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
