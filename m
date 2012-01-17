From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 3/5] intel_idle: Split up and provide per CPU initialization func
Date: Tue, 17 Jan 2012 14:26:40 +0100
Message-ID: <201201171426.40255.trenn@suse.de>
References: <1321569421-46220-1-git-send-email-trenn@suse.de> <1321569421-46220-4-git-send-email-trenn@suse.de> <4F15562B.1080406@kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55013 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754124Ab2AQN0m (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Jan 2012 08:26:42 -0500
In-Reply-To: <4F15562B.1080406@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, tj@kernel.org, bhelgaas@google.com

On Tuesday, January 17, 2012 12:06:19 PM Len Brown wrote:
> On 11/17/2011 05:36 PM, Thomas Renninger wrote:
> 
> > Function split up, should have no functional change
> 
> benefit?
The idea was:
Provide a basic init func which can be called in ACPI CPU hotplug
context safely before the CPU is brought up the first time and:
struct cpuinfo_x86
(like CPU features) of the new CPU is not set up yet.
Do the idle/throttling/... init later when the physically hotplugged
CPU is onlined the first time (and therefore got fully booted
and initialized).

While I had this working, I now have a better idea which does
not need this split:
When the ACPI CPU hotplug event is caught, fill up cpu_data(new_cpu)
data as much and good as possilbe, do something like:
memcpy(&cpu_data(new_cpu), &boot_cpu_data, sizeof(struct cpuinfo_x86);
and adjust:
phys_proc_id
cpu_core_id
apicid
initial_apicid
...
Then cpuidle (and throttling,...) can be initialized without the need
of booting up the CPU first.

Not sure whether the memcpy would succeed if the CPU is not (and never
was) online. From what I saw it should work, but I am not sure.
Tejun: Do you know that?

Another option would be what Bjorn Helgaas suggested:
Immediately online the CPU, but this would heavily interfere with
the current (generic code) approach, but after some thinking and
looking at the code: this shouldn't bring much benefit.

   Thomas
