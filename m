From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [RFC PATCH]: ACPI: Automatically online hot-added memory
Date: Wed, 10 Mar 2010 08:28:03 -0500
Message-ID: <4B979E63.1070806@redhat.com>
References: <20100309141203.10037.62453.sendpatchset@prarit.bos.redhat.com>	 <20100309154243.GA26520@srcf.ucam.org>  <4B969305.9070103@redhat.com> <1268186225.3606.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:20820 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756464Ab0CJN2E (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Mar 2010 08:28:04 -0500
In-Reply-To: <1268186225.3606.25.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ykzhao <yakui.zhao@intel.com>
Cc: Matthew Garrett <mjg@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>


>
> Why do we need to see whether the memory is onlined before bringing cpu
> to online state? It seems that there is no dependency between cpu online
> and memory online.
>
>   

Yakui,

Here's a deeper look into the issue.  New Intel processors have an 
on-die memory controller and this means that as the socket comes and 
goes, so does the memory "behind" the socket.

ie) with new processors it is possible that an entire node which 
consists of memory and cpus comes and goes with the socket enable and 
disable.

The cpu bringup code does local node allocations for the cpu.  If the 
memory connected to the node (which is "behind" the socket) isn't 
online, then these allocations fail, and then the cpu bringup fails.

P.

