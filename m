From: Thomas Renninger <trenn@suse.de>
Subject: Re: ACPI Thermal workaround hooks
Date: Thu, 09 Aug 2007 19:33:45 +0200
Message-ID: <1186680825.8780.268.camel@queen.suse.de>
References: 11866388361593-git-send-email-len.brown@intel.com  <11866391363162-git-send-email-len.brown@intel.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:56598 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758459AbXHIRds (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Aug 2007 13:33:48 -0400
In-Reply-To: <11866391363162-git-send-email-len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

On Thu, 2007-08-09 at 01:58 -0400, Len Brown wrote:
> In response to the outcry after I deleted the trip-point
> overrides, here is how I think we can work-around
> thermal issues in a supportable way.
> 
> In particular, this series should address the issues
> on Knut's AOpen Award system here:
> http://bugzilla.kernel.org/show_bug.cgi?id=8842
> and give us the hooks to address analogous issues in
> other systems.
> 
> Please let me know what you think.

Thanks.
This is very much appreciated.

I like the idea of boot parameters, this avoids the seduction to build
tools on it and mis-use this as an official interface.

But where I like to see a sysfs interface for, is the passive trip point
and allow:
  a) lowering passive trip points
  b) let user define his own passive trip point if none
     is provided by BIOS

I don't remember whether every trip point gets it's own sysfs file. If
yes, adding a passive_user file, default -1 and the normal passive file
where the current active passive trip point value is shown, is how I
think this could be done.

I know you hate it, because it's not explicitly stated in ACPI spec,
works around it a bit and so on.
But this one is:
  1) safe (in respect to hardware and code)
  2) a very mighty feature

Please let us implement the spec a little loose at this point, M$ is
also doing it at other parts. Let's get some fruits not always the
stones...

Thanks,

   Thomas

