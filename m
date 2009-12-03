From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] wmi: Free the allocated acpi objects through
	wmi_get_event_data
Date: Thu, 3 Dec 2009 16:37:52 +0000
Message-ID: <20091203163752.GA24898@srcf.ucam.org>
References: <20091203172745.02f66489@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:50382 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753328AbZLCQh5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Dec 2009 11:37:57 -0500
Content-Disposition: inline
In-Reply-To: <20091203172745.02f66489@destiny.ordissimo>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Anisse Astier <anisse@astier.eu>
Cc: linux-acpi@vger.kernel.org, Carlos Corbacho <carlos@strangeworlds.co.uk>, Len Brown <lenb@kernel.org>, Frans Pop <elendil@planet.nl>

On Thu, Dec 03, 2009 at 05:27:45PM +0100, Anisse Astier wrote:
> 
> These function allocate an acpi object by calling wmi_get_event_data, which
> then calls acpi_evaluate_object, and it is not freed afterwards
> 
> Signed-off-by: Anisse Astier <anisse@astier.eu>
Acked-by: Matthew Garrett <mjg@redhat.com>

-- 
Matthew Garrett | mjg59@srcf.ucam.org
