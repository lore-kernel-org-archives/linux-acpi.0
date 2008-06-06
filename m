From: "Henrique de Moraes Holschuh" <hmh@hmh.eng.br>
Subject: Re: bug? acpi p-state + ondemand keeps dropping max freq
Date: Fri, 06 Jun 2008 16:47:38 -0300
Message-ID: <1212781658.28267.1257170963@webmail.messagingengine.com>
References: <48486920.4040006@intel.com>
 <20080606041358.GA3457@khazad-dum.debian.net>
 <48496714.6030005@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:59973 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752298AbYFFTrj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Jun 2008 15:47:39 -0400
Content-Disposition: inline
In-Reply-To: <48496714.6030005@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Kok, Auke" <auke-jan.h.kok@intel.com>
Cc: linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, cpufreq@lists.linux.org.uk, Dave Jones <davej@codemonkey.org.uk>

On Fri, 06 Jun 2008 09:34:28 -0700, "Kok, Auke" <auke-jan.h.kok@intel.com> said:
> Henrique de Moraes Holschuh wrote:
> > On Thu, 05 Jun 2008, Kok, Auke wrote:
> >> This renders my Dothan to utterly poor speeds. (standard T43)
> > 
> > Which ThinkPad T43 model and BIOS revision?
> > 
> > I have a T43 2687DDU with the latest BIOS, and I have never seen
> > anything like that happening.  Is it overheating or something like that?
> 
> T43 2668NU3 Version: 1YET59WW (1.24 )

Older version of the planar card, but should be close enough to the
2687 I have...

Your BIOS is horribly old, and your EC firmware is very old too.  You
really should upgrade to BIOS 1.29 (1YET65WW) and EC 1.06.  Lenovo has
CDs you can use to upgrade even without Windows.  thinkwiki.org has the 
links to the support pages with the downloads.

After you upgrade, go into the BIOS configuration screen, and set everything
related to Speedstep and performance management to highest performance.  You
can let the BIOS do BUS power management, and you should let it do screen
brightness power management, but don't let it mess with the processor speed
or the disks.   It can have bad interactions with Linux power management.

> hardly overheating:
> 
>   Thermal zone 1 : ok, 49 C

It is probably a bad interaction from SMBIOS power management with the native
Linux power management.

BTW: install thinkpad-acpi and lm-sensors 3.0, and you will be able to see the
11 thermal zones the EC controls in a T43.


-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

