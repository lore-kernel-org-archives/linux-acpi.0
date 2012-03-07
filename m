From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [Patch] Eject button for button driver
Date: Wed, 7 Mar 2012 09:05:40 +0000
Message-ID: <20120307090540.GA3379@srcf.ucam.org>
References: <4F57155B.6080401@ts.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:47346 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262Ab2CGJFp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Mar 2012 04:05:45 -0500
Content-Disposition: inline
In-Reply-To: <4F57155B.6080401@ts.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rainer Koenig <Rainer.Koenig@ts.fujitsu.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, Mar 07, 2012 at 08:59:23AM +0100, Rainer Koenig wrote:

>                 Name(_HID, EISAID("PNP0C32"))   // HID ACPI button device

PNP0C32 devices are documented in 
http://download.microsoft.com/download/9/c/5/9c5b2167-8017-4bae-9fde-d599bac8184a/DirAppLaunch_Vista.doc 
- binding this in the button driver would make it impossible to write a 
full driver. There's an existing driver floating around under the name 
"quickstart". A better approach would be to tidy that up and make sure 
it works for your case, and then submit that.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
