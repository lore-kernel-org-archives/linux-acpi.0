From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH v2] acpi: Fix regression where _PPC is not read at boot even when ignore_ppc=0
Date: Mon, 20 Apr 2009 11:13:29 +0200
Message-ID: <200904201113.31371.trenn@suse.de>
References: <20090415225348.GW8311@plum> <20090416224507.GA31984@srcf.ucam.org> <alpine.LFD.2.00.0904200112290.10996@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:52433 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751347AbZDTJNd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Apr 2009 05:13:33 -0400
In-Reply-To: <alpine.LFD.2.00.0904200112290.10996@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, "Darrick J. Wong" <djwong@us.ibm.com>, linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, cpufreq@vger.kernel.org, linux-acpi@vger.kernel.org

On Monday 20 April 2009 07:13:51 Len Brown wrote:
> FYI,
> Thanks to Ebay, I now have a T60:-)
Hmm, Lenovo sold a lot different machines as T60.
I found an acpidump of a T60 here without any _PPC function
at all.

> and so i put the DSDT here:
> http://bugzilla.kernel.org/show_bug.cgi?id=13139
> 
> I'll poke at this in more detail soon...
Ingo, can you place yours somewhere too, please.
This one should be taken into account for _PPC code changes
as it seem to implement some corner case.

Thanks,

      Thomas
