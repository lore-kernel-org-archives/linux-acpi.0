From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: Compaq X1050 multiple suspend problems (ACPI, PS2)
Date: Mon, 13 Feb 2006 15:56:26 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840AE81145@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr17.intel.com ([134.134.136.16]:30154 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751216AbWBMH4h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Feb 2006 02:56:37 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, linux-acpi@vger.kernel.org
Cc: Robert Hancock <hancockr@shaw.ca>

>Subject: Fw: Compaq X1050 multiple suspend problems (ACPI, PS2)
>
>
>
>Begin forwarded message:
>
>Date: Sun, 12 Feb 2006 23:26:39 -0600
>From: Robert Hancock <hancockr@shaw.ca>
>To: linux-kernel <linux-kernel@vger.kernel.org>
>Subject: Compaq X1050 multiple suspend problems (ACPI, PS2)
>
>
>The following is with a Compaq Presario X1050, Fedora Core 4 
>and Fedora 
>kernel version 2.6.15-1.1831_FC4.
>
>I'm trying to get suspend working on this laptop. It kind of 
>works with 
>a script which does
>
>echo -n mem > /sys/power/state
>
>to do the suspend, with calls in the suspend/restore to use vbetool to 
>save/restore the video state and re-POST the video after resume. 
>However, the keyboard was behaving wonky after resume (losing 
>characters) and ACPI seems unhappy.
>
>The full kernel output from boot, suspend and resume is attached. Note 
>the "sleeping function called from invalid context" warning out of the 
>ACPI code, the method execution failures in ACPI and synchronization 
>errors from the psmouse and keyboard drivers.
>
>I can provide some further info or debugging tests if desired.
>

Please try  2.6.16-rc3. There is a fix for :

ACPI-0412: *** Error: Handler for [EmbeddedControl] returned AE_TIME
