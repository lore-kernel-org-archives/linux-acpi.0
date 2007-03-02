From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Date: Fri, 2 Mar 2007 21:46:43 +0000
Message-ID: <20070302214643.GA10774@srcf.ucam.org>
References: <45D5EA88.7090300@redhat.com> <45D6DDCE.5050803@assembler.cz> <45D7461A.2040808@redhat.com> <20070218183805.5a4fd813.khali@linux-fr.org> <20070228213803.GA4877@ucw.cz> <20070301152655.f232db64.khali@linux-fr.org> <20070302114023.GD2163@elf.ucw.cz> <20070302150313.198b6053.khali@linux-fr.org> <20070302145709.GA3710@srcf.ucam.org> <20070302224155.143b8643.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:56056 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030198AbXCBVq6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Mar 2007 16:46:58 -0500
Content-Disposition: inline
In-Reply-To: <20070302224155.143b8643.khali@linux-fr.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Pavel Machek <pavel@ucw.cz>, Chuck Ebbert <cebbert@redhat.com>, Rudolf Marek <r.marek@assembler.cz>, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

On Fri, Mar 02, 2007 at 10:41:55PM +0100, Jean Delvare wrote:

> I like the patch, after adding some casts to the printf args it
> compiles fine. However you print warnings each time a resource has been
> reserved... without checking if it hasn't been reserved by ACPI itself!
> My machine looks like this:

Oops! I'll look into fixing that. Thanks, that's an excellent point...

-- 
Matthew Garrett | mjg59@srcf.ucam.org
