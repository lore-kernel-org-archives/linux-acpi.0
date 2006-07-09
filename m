From: "Brown, Len" <len.brown@intel.com>
Subject: RE: ACPI not working on DELL Inspiron 1150
Date: Sun, 9 Jul 2006 17:19:25 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6ECF9E1@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:43825 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1161160AbWGIVT2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Jul 2006 17:19:28 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?iso-8859-1?Q?Rusl=E1n_Ledesma_Garza?= <ruslanledesmag@hotmail.com>, linux-acpi@vger.kernel.org

 
>>but I wonder
>>if the fact that my DST says "MSFT" could be the cause of ACPI not
>>working propertly.
>
>:-)  This means it was built with the MSFT ASL compiler.  Sometimes
>that is an issue, but we try to handle those issues and re-building
>the firmwarwe with Intel's compiler is okay for debugging, but not
>supportable.

oof, don't want to get quoted on that one out of context:-)
If the VENDOR uses Intel's compiler, that is goodness,
and it means that the ASL interpreter used in Linux will
not trip over various implementation issues in other compilers.

However, if the USER re-builds their firmware, with Intel's compiler
(or any other, for that matter), their system can not be supported
by the system vendor, or any Linux vendor either.

cheers,
-Len
