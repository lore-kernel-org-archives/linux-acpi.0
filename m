From: Peter Clifton <pcjc2@cam.ac.uk>
Subject: Re: HP Compaq nc6320
Date: Thu, 12 Oct 2006 00:53:04 +0100
Message-ID: <1160610784.7763.3.camel@pcjc2lap>
References: <1160604516.5349.14.camel@pcjc2lap>
	 <1160605036.8599.1.camel@pcjc2lap>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ppsw-3.csi.cam.ac.uk ([131.111.8.133]:10669 "EHLO
	ppsw-3.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1161282AbWJKXxI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 Oct 2006 19:53:08 -0400
Received: from acce212d.ipt.aol.com ([172.206.33.45]:64830 helo=[192.168.1.70])
	by ppsw-3.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.153]:465)
	with esmtpsa (LOGIN:pcjc2) (SSLv3:RC4-MD5:128)
	id 1GXnsn-00015S-Ac (Exim 4.63) for linux-acpi@vger.kernel.org
	(return-path <pcjc2@cam.ac.uk>); Thu, 12 Oct 2006 00:53:05 +0100
In-Reply-To: <1160605036.8599.1.camel@pcjc2lap>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

On Wed, 2006-10-11 at 23:17 +0100, Peter Clifton wrote:
> On Wed, 2006-10-11 at 23:08 +0100, Peter Clifton wrote:
> > I decided to revert the HP bios back to F.06, and now - to my
> surprise,
> > on boot, I get an extra SSDT! (The CpuPm one).
> 
> [snip]
> 
> > Perhaps even booting windows
> > (to downgrade to F.06) had some effect on the bios to bring back the
> > SSDT? Perhaps it is only in the F.06.
> 
> Further to this.. the Battery / AC adapter status monitoring seems to
be
> working now aswell (if booting with ec_intr=0). I just booted with out
> ec_intr=0, and it isn't working :(
> 
> I'm just about to check with the F.06 DSDT again, as my override DSDT
is
> based on F.08. (There isn't much difference between them though)

Of course, this was _necessary_, as the namespaces between the two DSDT
is different, and the SSDT won't play nice if it can't find the correct
objects, methods, etc...

Wierdly, I've lost the Battery/AC adapter status monitoring again, with
or without ec_intr=0.

> How odd!

Gets odder!

Peter C.



