From: Erik Slagter <erik@slagter.name>
Subject: c1/c1e/c3/c6/c7 on linux
Date: Sun, 22 Nov 2009 12:46:16 +0100
Message-ID: <4B092488.5040801@slagter.name>
References: <4B06A7A8.109@slagter.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from eriks.xs4all.nl ([83.160.41.216]:40026 "EHLO eriks.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751143AbZKVLqM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Nov 2009 06:46:12 -0500
Received: from nemesis.slagter.name (nemesis.ipv4.slagter.name [10.1.3.7])
	by nemesis.slagter.name (Postfix) with ESMTP id 90C873B4AD
	for <linux-acpi@vger.kernel.org>; Sun, 22 Nov 2009 12:46:16 +0100 (CET)
Received: from artemis.slagter.name (artemis-vlan3.ipv6.slagter.name [IPv6:2001:888:133a:103::1])
	by nemesis.slagter.name (Postfix) with ESMTP
	for <linux-acpi@vger.kernel.org>; Sun, 22 Nov 2009 12:46:16 +0100 (CET)
Received: from [IPv6:2001:888:133a:103::2] (skylla.ipv6.slagter.name [IPv6:2001:888:133a:103::2])
	by artemis.slagter.name (Postfix) with ESMTP id 368363930B8D
	for <linux-acpi@vger.kernel.org>; Sun, 22 Nov 2009 12:46:16 +0100 (CET)
In-Reply-To: <4B06A7A8.109@slagter.name>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Ik have two machines, a dell laptop with a mobile core2duo T9300 and a 
gigabyte desktop with a core i7 920. Both advertise all of these 
C-states c1/c1e/c3/c6/c7 in the specs (although the core2duo doesn't 
have c7 I believe).

It's not clear at all how linux handles these. The kernel on the T9300 
says it uesde C1/C2/C3 of "type" C1/C2/C3, the core i7 says exactly the 
same.

Is this a WiP? A bios issue? It looks like I am missing some states?

The kernel I am using is 2.6.31.6
