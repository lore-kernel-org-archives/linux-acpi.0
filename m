From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH resend] wmi: Free the allocated acpi objects through wmi_get_event_data
Date: Wed, 16 Dec 2009 22:38:25 +0000
Message-ID: <200912162238.25724.carlos@strangeworlds.co.uk>
References: <20091215105024.3acad900@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:47685 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932581AbZLPWi2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 17:38:28 -0500
Received: by ey-out-2122.google.com with SMTP id d26so387520eyd.19
        for <linux-acpi@vger.kernel.org>; Wed, 16 Dec 2009 14:38:27 -0800 (PST)
In-Reply-To: <20091215105024.3acad900@destiny.ordissimo>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Anisse Astier <anisse@astier.eu>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg@redhat.com>, Randy Dunlap <randy.dunlap@oracle.com>, Frans Pop <elendil@planet.nl>

On Tuesday 15 December 2009 09:50:24 Anisse Astier wrote:
> These function allocate an acpi object by calling wmi_get_event_data, which
> then calls acpi_evaluate_object, and it is not freed afterwards.
> 
> And kernel doc is fixed for parameters of wmi_get_event_data.
> 
> Signed-off-by: Anisse Astier <anisse@astier.eu>
> Acked-by: Matthew Garrett <mjg@redhat.com>
> Acked-by: Randy Dunlap <randy.dunlap@oracle.com>

For the wmi.c changes:

Acked-by: Carlos Corbacho <carlos@strangeworlds.co.uk>

Len, can you just take this directly?

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
