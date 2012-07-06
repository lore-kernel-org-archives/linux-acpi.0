From: Khalid Aziz <khalid.aziz@hp.com>
Subject: Re: [PATCH] ACPI: Add ACPI CPU hot-remove support
Date: Fri, 06 Jul 2012 14:09:21 -0600
Message-ID: <4FF745F1.9030103@hp.com>
References: <1340981479-6521-1-git-send-email-toshi.kani@hp.com>  <4FF711DE.1030108@gmail.com> <1341602020.16730.695.camel@misato.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:12647 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052Ab2GFUJX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Jul 2012 16:09:23 -0400
In-Reply-To: <1341602020.16730.695.camel@misato.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Toshi Kani <toshi.kani@hp.com>
Cc: Jiang Liu <liuj97@gmail.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 07/06/2012 01:13 PM, Toshi Kani wrote:

>
> For step 2) and 4), I am wondering if they are relevant to CPU hotplug
> these days.  In ACPI namespace, a processor object represents a logical
> processor (or a core when hyper-threading is disabled).  A physical
> processor (i.e. a socket) usually has multiple cores, and memory
> controller and bus interface are part of the socket functionality.
> Hence, I think step 2) and 4) belong to socket-level hot-removal
> operation, which can be implemented as container hot-remove when a
> socket is represented with a container object.

What does it mean to eject just a core in that case? If there are seven
other cores in the physical processor and you get a request to eject
one core, what would you expect kernel to do - simply move all processes
and interrupts off of that core, take it out of scheduling consideration
and simply idle the core? If yes, how is that any different from simply
offlining a core? If you are ejecting individual cores at a time, do you
keep track of how many you have ejected and then eject the entire physical
CPU along with memory and IOH associated with the socket when the last
core is ejected?

-- 
Khalid
====================================================================
Khalid Aziz                                         Unix Systems Lab
(970)898-9214                                        Hewlett-Packard
khalid.aziz@hp.com                                  Fort Collins, CO

