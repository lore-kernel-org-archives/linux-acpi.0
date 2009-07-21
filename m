From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] hp-wmi: improve rfkill support
Date: Tue, 21 Jul 2009 12:26:07 +0100
Message-ID: <20090721112607.GA17377@srcf.ucam.org>
References: <4A65A2F9.1060509@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:49901 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753175AbZGUL0J (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Jul 2009 07:26:09 -0400
Content-Disposition: inline
In-Reply-To: <4A65A2F9.1060509@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Maciej Rutecki <maciej.rutecki@gmail.com>, linux acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Tue, Jul 21, 2009 at 12:14:01PM +0100, Alan Jenkins wrote:
> 1) Add support for reading the hardware blocked state.  Previously
>    we read a combination of the hardware and software blocked states,
>    reporting it as the software blocked state.  This caused some
>    confusing behaviour.
> 
> 2) The software state is persistent, mark it as such.
> 
> 3) Check rfkill in the resume handler.  Both the hard and soft
>    blocked states may change over hibernation.
> 
> Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
> Tested-by: Maciej Rutecki <maciej.rutecki@gmail.com>
Acked-by: Matthew Garrett <mjg@redhat.com>

-- 
Matthew Garrett | mjg59@srcf.ucam.org
