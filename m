From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [PATCH][BUTTON] remove procfs-interface
Date: Thu, 12 Jul 2007 10:38:23 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB60365D429@hdsmsx411.amr.corp.intel.com>
References: <1184235969.2415.0.camel@work>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:21749 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762056AbXGLOi0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Jul 2007 10:38:26 -0400
Content-class: urn:content-classes:message
In-Reply-To: <1184235969.2415.0.camel@work>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Hughes <hughsient@gmail.com>, "Zhang, Rui" <rui.zhang@intel.com>
Cc: Henne <henne@nachtwindheim.de>, Arjan van de Ven <arjan@infradead.org>, linux-acpi@vger.kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org

The last time I tried to remove this code,
we discovered that people were using it to query
the lid (button) status.

-Len 

>-----Original Message-----
>From: Richard Hughes [mailto:hughsient@gmail.com] 
>Sent: Thursday, July 12, 2007 6:26 AM
>To: Zhang, Rui
>Cc: Henne; Arjan van de Ven; Brown, Len; 
>linux-acpi@vger.kernel.org; akpm@linux-foundation.org; 
>linux-kernel@vger.kernel.org
>Subject: RE: [PATCH][ACPI][BUTTON] remove procfs-interface
>
>On Thu, 2007-07-12 at 17:46 +0800, Zhang, Rui wrote:
>> 
>> I'm not sure if the button sysfs I/F is already finished.
>> We'd better make a double check. :)
>
>We need a button sysfs interface? What's wrong with just using input?
>
>Richard.
>
