From: "Brown, Len" <len.brown@intel.com>
Subject: RE: Linux kernel PnPBIOS
Date: Mon, 8 May 2006 22:29:36 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB65EAD16@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:27927 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751348AbWEIC3k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 May 2006 22:29:40 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Christian P. Schmidt" <schmidt@digadd.de>
Cc: linux-acpi@vger.kernel.org

>As the original author of the x86 pnp bios driver I recently received a
>request to add the API to access the information related to the BIOS
>Boot Specification (BBS), which is accessible through the PNP BIOS
>interface with functions 0x60 through 0x66.
>
>Seeing that a) there apparently are only few protected mode compatible
>versions out (both systems I tried a preliminary patch on 
>required major
>efforts and GPF fixing), and b) the PNP BIOS is basically obsolete I
>wonder if this information is available via ACPI so I can point out
>these facts and a better API to the interested person. Do you have any
>information on this?
>
>For your short reference, the BBS is meant to allow userspace programs
>request and set information on bootable devices and the order these
>devices are tried on.
>
>Best regards,
>Christian

Christian,
I'm not aware of specific ACPI hooks allowing a user to
observe or select device boot priority.

cc-ing the list in case others know better than me.

-Len
