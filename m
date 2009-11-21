From: Erik Slagter <erik@slagter.name>
Subject: Re: No c2-c7 states on core i7
Date: Sat, 21 Nov 2009 18:45:21 +0100
Message-ID: <4B082731.30909@slagter.name>
References: <4B06A7A8.109@slagter.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from eriks.xs4all.nl ([83.160.41.216]:37980 "EHLO eriks.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756546AbZKURpU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 21 Nov 2009 12:45:20 -0500
Received: from nemesis.slagter.name (nemesis.ipv4.slagter.name [10.1.3.7])
	by nemesis.slagter.name (Postfix) with ESMTP id 4ACE03B179
	for <linux-acpi@vger.kernel.org>; Sat, 21 Nov 2009 18:45:22 +0100 (CET)
Received: from artemis.slagter.name (artemis-vlan3.ipv6.slagter.name [IPv6:2001:888:133a:103::1])
	by nemesis.slagter.name (Postfix) with ESMTP
	for <linux-acpi@vger.kernel.org>; Sat, 21 Nov 2009 18:45:22 +0100 (CET)
Received: from [IPv6:2001:888:133a:103::2] (skylla.ipv6.slagter.name [IPv6:2001:888:133a:103::2])
	by artemis.slagter.name (Postfix) with ESMTP id E7C933930B8D
	for <linux-acpi@vger.kernel.org>; Sat, 21 Nov 2009 18:45:21 +0100 (CET)
In-Reply-To: <4B06A7A8.109@slagter.name>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

As always this appears to be a BIOS problem (bug?)

As soon as you change the BASECLOCK setting, all C states are withdrawn. 
I think it's really idiotic, and I am really going to try to enable them 
anyway.

Interesting fact: the system uses almost exactly the same amount of 
power when C states are enabled by the BIOS and when they are disabled. 
Makes you wonder whether they actually do something at all. The linux 
counters really say they're called, anyway.

So if you don't want a power-wasting board, don't buy a Gigabyte EX58-UD3R.
