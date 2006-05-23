From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: DSDT on Averatec 1050
Date: Tue, 23 May 2006 13:33:29 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A45605AE@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:25867 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932154AbWEWUee convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 23 May 2006 16:34:34 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: Paul Wagner <paul_spam@gmx.at>, linux-acpi@vger.kernel.org

+    | PARSEOP_IO                    {$$ = TrCreateValuedLeafNode
(PARSEOP_IO, (ACPI_NATIVE_INT) "IO");}

I would imagine that we would want to type the node as
PARSEOP_NAMESTRING.

I think there are a few more like this, "DMA" comes to mind immediately.

Bob


> -----Original Message-----
> From: Thomas Renninger [mailto:trenn@suse.de]
> Sent: Friday, May 19, 2006 6:03 AM
> To: Moore, Robert
> Cc: Paul Wagner; linux-acpi@vger.kernel.org
> Subject: RE: DSDT on Averatec 1050
> 
> On Thu, 2006-05-11 at 10:56 -0700, Moore, Robert wrote:
> > May have gotten lost in the noise, please send to me.
> 
> Attached are two patches:
>  1) Fixes compiler nameclash if IO keyword is used as field
declaration
>  2) If (generic, dsdt.dsl) output file is already created with
> insufficient
>     privileges to the current user, iasl -d dsdt segfaults.
>     This patch makes iasl to exit gracefully.
> 
>       Thomas
