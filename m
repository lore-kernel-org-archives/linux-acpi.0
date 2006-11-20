From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] Show devices for active/passive cooling in thermal
	trip_points file
Date: Mon, 20 Nov 2006 17:20:22 +0100
Message-ID: <1164039623.3721.242.camel@queen.suse.de>
References: <1163973700.3562.13.camel@sublime.site>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:2748 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S966111AbWKTQUX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Nov 2006 11:20:23 -0500
In-Reply-To: <1163973700.3562.13.camel@sublime.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: len.brown@intel.com, fseidel@suse.de, Arjan van de Ven <arjan@linux.intel.com>

On Sun, 2006-11-19 at 23:01 +0100, Thomas Renninger wrote:
> Len, can you queue this one for after 2.6.19 inclusion, please.
> With this and a firmwarekit test it should be possible to identify
> not working fans as it happened on some HPs in 2.6.16 and later
> automatically.

Here is an example of how trip_points file looks like then, got some
time to boot on a machine with active trip points to make the intend of
the patch more obvious:

trip_points file:
-----------------
critical (S5):           105 C
passive:                 100 C: tc1=1 tc2=2 tsp=100 devices=C000
active[0]:               80 C: devices=C25C
active[1]:               65 C: devices=C25D
active[2]:               55 C: devices=C25E
active[3]:               35 C: devices=C25F

ls -d /proc/acpi/fan/*:
----------------------
/proc/acpi/fan/C25C
/proc/acpi/fan/C25D
/proc/acpi/fan/C25E
/proc/acpi/fan/C25F

ls -d /proc/acpi/processor/*:
-----------------------------
/proc/acpi/processor/C000

