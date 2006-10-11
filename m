From: Peter Clifton <pcjc2@cam.ac.uk>
Subject: Re: HP Compaq nc6320
Date: Wed, 11 Oct 2006 23:17:16 +0100
Message-ID: <1160605036.8599.1.camel@pcjc2lap>
References: <1160604516.5349.14.camel@pcjc2lap>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ppsw-2.csi.cam.ac.uk ([131.111.8.132]:9388 "EHLO
	ppsw-2.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1161562AbWJKWRV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 Oct 2006 18:17:21 -0400
Received: from acce212d.ipt.aol.com ([172.206.33.45]:60869 helo=[192.168.1.70])
	by ppsw-2.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.152]:465)
	with esmtpsa (LOGIN:pcjc2) (SSLv3:RC4-MD5:128)
	id 1GXmO5-0006IA-8Y (Exim 4.63) for linux-acpi@vger.kernel.org
	(return-path <pcjc2@cam.ac.uk>); Wed, 11 Oct 2006 23:17:17 +0100
In-Reply-To: <1160604516.5349.14.camel@pcjc2lap>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

On Wed, 2006-10-11 at 23:08 +0100, Peter Clifton wrote:
> I decided to revert the HP bios back to F.06, and now - to my
surprise,
> on boot, I get an extra SSDT! (The CpuPm one).

[snip]

> Perhaps even booting windows
> (to downgrade to F.06) had some effect on the bios to bring back the
> SSDT? Perhaps it is only in the F.06.

Further to this.. the Battery / AC adapter status monitoring seems to be
working now aswell (if booting with ec_intr=0). I just booted with out
ec_intr=0, and it isn't working :(

I'm just about to check with the F.06 DSDT again, as my override DSDT is
based on F.08. (There isn't much difference between them though)

How odd!

Peter C.


