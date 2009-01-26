From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] hp-wmi: set initial docking state
Date: Mon, 26 Jan 2009 14:38:08 +0000
Message-ID: <20090126143808.GA15597@srcf.ucam.org>
References: <200901261536.02809.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:51208 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172AbZAZOiN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Jan 2009 09:38:13 -0500
Content-Disposition: inline
In-Reply-To: <200901261536.02809.elendil@planet.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org

On Mon, Jan 26, 2009 at 03:36:01PM +0100, Frans Pop wrote:
> If the initial state is not set when the input device is set up, the
> first docking event after the module is loaded will be lost.
>     
> Signed-off-by: Frans Pop <elendil@planet.nl>
> Cc: Matthew Garrett <mjg59@srcf.ucam.org>
Acked-by: Matthew Garrett <mjg@redhat.com>

-- 
Matthew Garrett | mjg59@srcf.ucam.org
