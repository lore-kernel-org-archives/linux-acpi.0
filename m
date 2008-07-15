From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 14/14] ACPI: Provide /sys/devices/system/cpu/cpuN/deconfigure
Date: Tue, 15 Jul 2008 19:06:32 +0200
Message-ID: <487CD918.6060405@linux.intel.com>
References: <20080715023344.2528.1836.stgit@blender.achiang> <20080715023455.2528.16193.stgit@blender.achiang>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga12.intel.com ([143.182.124.36]:45069 "EHLO
	azsmga102.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751818AbYGORGm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Jul 2008 13:06:42 -0400
In-Reply-To: <20080715023455.2528.16193.stgit@blender.achiang>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Chiang <achiang@hp.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Alex Chiang wrote:
> Provide a new sysfs interface for CPU deconfiguration.
> 
> Since no vendors can agree on terminology for related but slightly
> different features, provide a method for a platform to implement
> its own version of what it thinks 'deconfiguring' a CPU might be.
> 
> Provide an HP-specific CPU deconfiguration implementation.

Why are you ccing this to linux-arch? Dropped.

What is the standard status of these new SCFG and ECFG tables? Have they
been submitted for possible inclusion in ACPI? And is there a spec
available? I can't say I'm really thrilled with having HP specific
support in there.

It would be better at least if you could reserve the table names and 
then drop the HP DMI check. This is needed anyways, otherwise the 
standard at some point could add different ECFG/SCFG tables.

> + * After echo'ing 0 or 1 into deconfigure, cat'ing the file will
> + * return the next boot's status. However, the CPU will not actually
> + * be deconfigured until the next boot.

Now that seems like weird semantics for a public fixed API. What happens
when some other vendor adds hot deconfiguration?

My feeling is that this seems to be overly specific to your BIOS
and might better belong into some separate management tool. At least
until we can define a nice general API for this with clear semantics. 
For what systems is this anyways?

-Andi

