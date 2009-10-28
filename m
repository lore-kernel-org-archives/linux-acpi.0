From: "Gangadhar, Mukesh" <mukesh.gangadhar@intel.com>
Subject: RE: [Linux-power-mgmt] RE: Please review power management abstract
 for	LF End User Summit
Date: Wed, 28 Oct 2009 22:53:13 +0530
Message-ID: <3CA6C6D9F70D314CA34352990B57DA1539C84C66@bgsmsx502.gar.corp.intel.com>
References: <E87738D94A6AD54789B5B8D1BAEB06CC6EED79B299@azsmsx503.amr.corp.intel.com>
 <2E9E6F5F5978EF44A8590E339E888CF90144294DEC@irsmsx503.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:50420 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753420AbZJ1RXf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Oct 2009 13:23:35 -0400
In-Reply-To: <2E9E6F5F5978EF44A8590E339E888CF90144294DEC@irsmsx503.ger.corp.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Kleen, Andi" <andi.kleen@intel.com>, "Brown, Len" <len.brown@intel.com>, "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>, "Mallick, Asit K" <asit.k.mallick@intel.com>, 'linux-powe

A topic on virtualization and power management would be useful...

Thanks

Mukesh

-----Original Message-----
From: linux-power-mgmt-bounces@linux.intel.com [mailto:linux-power-mgmt-bounces@linux.intel.com] On Behalf Of Kleen, Andi
Sent: Wednesday, October 28, 2009 10:37 PM
To: Brown, Len; Van De Ven, Arjan; Mallick, Asit K; 'linux-power-mgmt@linux.intel.com'; linux-acpi@vger.kernel.org
Subject: [Linux-power-mgmt] RE: Please review power management abstract for LF End User Summit

I would start with a power break down on a typical server.

Also at least mention things like power saving by not enabling ethernet
links.

-Andi

>-----Original Message-----
>From: Brown, Len 
>Sent: Wednesday, October 28, 2009 5:35 PM
>To: Van De Ven, Arjan; Mallick, Asit K; Kleen, Andi; 
>'linux-power-mgmt@linux.intel.com'; linux-acpi@vger.kernel.org
>Subject: Please review power management abstract for LF End User Summit
>
>I've been asked to present on server power management
>in a couple of weeks at the Linux Foundation End User Summit 
>in New York.
>
>Please review the abstract below -- I need to submit it today.
>
>I've also penciled in an outline for the talk below,
>let me know if there is something that server customers
>may want to hear about that I've forgotton to include.
>
>thanks!
>-Len
>
>
>
>Title: Topics in Linux Server Power Management
>-----
>Abstract:
>--------
>Today's high volume servers deploy several power management
>features originally developed for laptop computers.
>While Linux runs on laptops and thus already has support for
>these features, servers have performance constraints
>not generally found on laptops.
>
>This talk starts with an overview of power management features
>supported in Linux on high volumem servers, and then describes
>how to maximize power savings while still meeting
>server performance requirements.
>
>No previous knowledge of Linux power management features
>is necessary to benefit from this presentation.
>
>Outline:
>-------
>CPU Idle Power states (C-staes)
>	what they are
>	how to observe
>	knobs to debug/control
>
>	C1 vs C1E
>	core vs package C-states
>
>Processor Performance States (P-state)
>	what they are
>	how to observe
>	knobs to debug/control
>
>	ondemand vs. userspace
>
>Turbo Mode (Intel Dynamic Acceleration Technology)
>	what it is
>	how to observe
>	knobs to debug/control
>
>PM-QOS
>	what it is, how it works, how to use it
>
>Power Aware Scheduling
>	what it is, how to use it
>_______________________________________________
Linux-power-mgmt mailing list
Linux-power-mgmt@linux.intel.com
http://linux.intel.com/mailman/listinfo/linux-power-mgmt
