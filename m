From: Garry Williams <gtwilliams@gmail.com>
Subject: Re: function keys
Date: Thu, 16 Mar 2006 20:04:52 -0500
Message-ID: <1142557492.3455.74.camel@localhost>
References: <200603152256.43735.marmon@montana.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.201]:5839 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750759AbWCQBEy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 16 Mar 2006 20:04:54 -0500
Received: by xproxy.gmail.com with SMTP id s14so358791wxc
        for <linux-acpi@vger.kernel.org>; Thu, 16 Mar 2006 17:04:54 -0800 (PST)
In-Reply-To: <200603152256.43735.marmon@montana.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: marmon@montana.com
Cc: linux-acpi@vger.kernel.org

On Wed, 2006-03-15 at 22:56 -0700, Franklin Marmon wrote:
> I am currently using an acpi driver for sony laptops (sony_acpi.c) which 
> provides an interface for reading that last pressed function key by means of 
> a /proc interface file. When read this file will show either 0 or the last 
> function key combination that was typed. It provides this value by using the 
> acpi_evaluate_object() function to obtain the value of "GHKE". A user space 
> program is currently used to read this value every N seconds and check for 
> events.
> 
> Is there an interrupt generated when one of these function keys is pressed and 
> is this interrupt currently handled by the acpi subsystem? If so, is there a 
> way to add this acpi device driver into a wait queue for this type of event 
> so that a proper char device may be created and polled, rather than reading 
> the /proc file system every N seconds?

 http://developer.berlios.de/projects/fsfn/ 

-- 
Garry Williams -- +1 (678) 656-4579

