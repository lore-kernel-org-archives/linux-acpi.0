From: Len Brown <lenb@kernel.org>
Subject: Re: [Devel] Regarding ACPI library
Date: Thu, 24 Dec 2009 15:16:51 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0912241507390.4159@localhost.localdomain>
References: <6b4365880912231733v58fb8b84wf3bc896113328421@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_EsEuUj0SoHKIcj4R7Pbfsw)"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:56384 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753022AbZLXUQ5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Dec 2009 15:16:57 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KV600EEMB04FPJL@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 24 Dec 2009 14:16:55 -0600 (CST)
In-reply-to: <6b4365880912231733v58fb8b84wf3bc896113328421@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: nisha jain <jain61@gmail.com>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_EsEuUj0SoHKIcj4R7Pbfsw)
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

On Wed, 23 Dec 2009, nisha jain wrote:

> Hi All,
> 
> I am working on research related to Power management and control for single and multiprocessors and I came across ACPI standard. I want
> to get all CPU power information (c state and frequency p state information) for different applications and kernel processes running
> into system (with load).  I went through user manual of the ACPI and as per my understaning there is some information written by the
> ACPI HW/SW module and ACPI is already a part of most Linux kernels.I went through all the acpi site but there is no sample program to
> show its usage also i have installed the UNIX Format Source Code and Build Environment and  UNIX Format Test Suite of the ACPI and
> successfully compiled it. I am not sure how and which acpi APIs needs to be called to get such information and how to install the ACPI
> library...Also I want to control CPU frquency and state not sure how to achieve it using ACPI library?
> 
> I am using an environment with Intel Dual Core Tm processor and Ubuntu platform.

Hi Nisha,
ACPI is an interface between the hardware and the OS,
not an interface between the kernel and user-space.

So generally the ACPICA core is hidden inside the kernel
and not directly visible to user-space.

So your question is really about the Linux APIs for
user-space utilities to get to the stuff that is
implemented by ACPI.

On Linux, we endeavor to expose ACPI directly to application layer
only for debugging hooks -- eg the old /proc/acpi/*
and the new /sys/firmware/acpi/*

In general, we try to have generic policy code that doesn't
directly know if ACPI is involved in the underlying implementation.
For example, cpufreq abstracts ACPI P-states, cpuidle
abstracts ACPI C-states, thermal abstracts ACPI thermal & T-states,
power supply abstracts ACPI battery etc.

Note that the powertop application is available in most recent distros
to grab and summarize a lot of what you may be seeking.
It looks in /sys/devices/system/cpu/* for cpufreq and cpuidle info.

cheers,
-Len Brown
Intel Open Source Technology Center

--Boundary_(ID_EsEuUj0SoHKIcj4R7Pbfsw)--
