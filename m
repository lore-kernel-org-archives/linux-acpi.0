From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: RE: [PATCH 1/3]cpuidle take2: Core cpuidle infrastructure
Date: Tue, 27 Feb 2007 20:47:55 -0800
Message-ID: <EB12A50964762B4D8111D55B764A845401540255@scsmsx413.amr.corp.intel.com>
References: <20070227164427.GB2223@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:37277 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751627AbXB1Er7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Feb 2007 23:47:59 -0500
Content-class: urn:content-classes:message
In-Reply-To: <20070227164427.GB2223@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, linux-acpi@vger.kernel.org, Adam Belay <abelay@novell.com>, "Li, Shaohua" <shaohua.li@intel.com>, "Brown, Len" <len.brown@intel.com>

 

>-----Original Message-----
>From: Dave Jones [mailto:davej@redhat.com] 
>Sent: Tuesday, February 27, 2007 8:44 AM
>To: Pallipadi, Venkatesh
>Cc: linux-kernel; Andrew Morton; linux-acpi@vger.kernel.org; 
>Adam Belay; Li, Shaohua; Brown, Len
>Subject: Re: [PATCH 1/3]cpuidle take2: Core cpuidle infrastructure
>
>On Thu, Feb 22, 2007 at 01:52:57PM -0800, Venkatesh Pallipadi wrote:
>
> > Announcing 'cpuidle', a new CPU power management 
>infrastructure to manage
> > idle CPUs in a clean and efficient manner.
> > cpuidle separates out the drivers that can provide support 
>for multiple types
> > of idle states and policy governors that decide on what 
>idle state to use
> > at run time.
> > A cpuidle driver can support multiple idle states based on 
>parameters like
> > varying power consumption, wakeup latency, etc (ACPI 
>C-states for example).
> > A cpuidle governor can be usage model specific (laptop, server,
> > laptop on battery etc).
> > Main advantage of the infrastructure being, it allows 
>independent development
> > of drivers and governors and allows for better CPU power management.
>
>I played with this a little, and got puzzled.
>My quad core box used exactly the same amount of power whether the
>'ladder' governer was loaded & in use or not.  In both situations
>it was exactly the same as a vanilla 2.6.20
>
>I'd have expected it to use more until I loaded up 'ladder' to bring it
>on par featurewise with 2.6.20.  What did I miss?
>

Quad core what platform? How many C-states are supported in this
platform?

Current ladder is mostly like Policy embedded in ACPI today. But, Adam
has
been working on different policies that we want to experiment with as we
go along.

Thanks,
Venki
