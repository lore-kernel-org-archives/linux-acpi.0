From: Hans Petter Selasky <hselasky@c2i.net>
Subject: Re: MacBookPro 5,1
Date: Sun, 17 Oct 2010 15:47:56 +0200
Message-ID: <201010171547.56445.hselasky@c2i.net>
References: <201010121209.06397.hselasky@c2i.net> <201010131958.02252.jkim@FreeBSD.org> <201010171056.12606.hselasky@c2i.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailfe07.swip.net ([212.247.154.193]:60617 "EHLO swip.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756379Ab0JQNql (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 17 Oct 2010 09:46:41 -0400
In-Reply-To: <201010171056.12606.hselasky@c2i.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: freebsd-acpi@freebsd.org
Cc: Jung-uk Kim <jkim@freebsd.org>, linux-acpi@vger.kernel.org

Hi,

CC'ing the Linux guys, hence I belive you are using the same ACPI code like in 
FreeBSD.

It appears that when a string is present in the extended interrupt descriptor 
(6.4.3.6, ACPIspec30.pdf), then this is not handled correctly, meaning that 
the precomputed buffer space when encoding to AML, is incorrect and that data 
is written beyond the destination buffer!

The error is catched on a MacBookPro 5,1 and is visible if you zero-pad all 
ACPI allocations to 4096 bytes, and verify that the freed buffer is not 
written beyond the allocation. Also the Extended interrupt descriptor must be 
the last element encoded in the AML.

The quick patch is to disable these elements. I tried to figure out why this 
happens, but this particular handling in the code looks very obfuscated to me.

src/sys/contrib/dev/acpica
%svk diff
=== resources/rsmisc.c
==================================================================
--- resources/rsmisc.c  (revision 213698)
+++ resources/rsmisc.c  (local)
@@ -311,6 +311,8 @@
 
 
         case ACPI_RSC_SOURCEX:
+               break;  /* RSC_SOURCEX is broken */
+
             /*
              * Optional ResourceSource (Index and String). This is the more
              * complicated case used by the Interrupt() macro
@@ -537,6 +539,8 @@
 
 
         case ACPI_RSC_SOURCEX:
+               break;  /* RSC_SOURCEX is broken */
+
             /*
              * Optional ResourceSource (Index and String)
              */


Any comments are welcome!

--HPS

Please keep me CC'ed.
