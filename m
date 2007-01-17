From: Peter Clifton <pcjc2@cam.ac.uk>
Subject: RE: i810, mergedfb and lid switch and acpi video
Date: Wed, 17 Jan 2007 14:23:39 +0000
Message-ID: <1169043819.6273.10.camel@localhost>
References: <1C601A6A3344064EB423D0C1E83B717BE6FD77@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:34178 "EHLO
	ppsw-9.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932330AbXAQOXt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Jan 2007 09:23:49 -0500
In-Reply-To: <1C601A6A3344064EB423D0C1E83B717BE6FD77@pdsmsx411.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: emisca <emisca.ml@gmail.com>
Cc: xorg@lists.freedesktop.org, linux-acpi@vger.kernel.org

SORRY - sent back to Luming by mistake - meant to send to all.

On Wed, 2007-01-17 at 12:20 +0800, Yu, Luming wrote:

> But there is NO _BQC. Instead of _BQC, there do have a _BCQ in DSDT.
> Is this a bug of BIOS? Acpi video drvier needs _BQC to get the
> current brightness level, and to get the next level to set on
receiving
> notification of 0x86 (Increase Brightness) , 0x87 (decrease
Brightness).

I can ACK that my HP had a similar typo / feature with its intel based
video:

00:02.0 VGA compatible controller: Intel Corporation Mobile 
945GM/GMS/940GML Express Integrated Graphics Controller (rev 03)

The _BQC is absent, but a strange _BCQ is there - which looks to give
the correct functionality.

The ONLY place I can find any reference to _BCQ is in a couple of
Windows Vista design documents about making display brightness work with
Vista.

Thank you Microsoft, for that typo - presuming thats what it is!

Peter Clifton


