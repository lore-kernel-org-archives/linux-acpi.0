From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 4/4] hp-wmi: add support for reporting tablet state
Date: Wed, 17 Jun 2009 23:56:46 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0906172351100.8921@localhost.localdomain>
References: <200906101940.n5AJenST028805@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:22461 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbZFRErx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Jun 2009 00:47:53 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KLF00G1G1MOK5M1@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 17 Jun 2009 22:56:48 -0500 (CDT)
In-reply-to: <200906101940.n5AJenST028805@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, mjg@redhat.com

Hi Andrew,
I've merged the original version of this patch from Matthew.

The version I got from you didn't apply, apparently because
it depends on a patch that I don't have?

thanks,
Len Brown, Intel Open Source Technology Center


< Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
...

72,73c68,69
<  static int hp_wmi_set_block(void *data, bool blocked)
< @@ -232,6 +246,15 @@ static ssize_t show_dock(struct device *
---
>  static int hp_wmi_wifi_set(void *data, enum rfkill_state state)
> @@ -244,6 +258,15 @@ static ssize_t show_dock(struct device *

...
116,117c112,113
<                               rfkill_set_sw_state(wifi_rfkill,
< @@ -369,18 +393,19 @@ static int __init hp_wmi_input_setup(voi
---
>                               rfkill_force_state(wifi_rfkill,
> @@ -381,18 +405,19 @@ static int __init hp_wmi_input_setup(void)


