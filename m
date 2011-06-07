From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH] acpi-cpufreq: remove unreliable get-frequency functions
Date: Tue, 7 Jun 2011 08:01:23 +0200
Message-ID: <20110607060123.GA5333@isilmar-3.linta.de>
References: <alpine.LFD.2.02.1106060144310.6779@x980> <20110606071209.GA20080@isilmar-3.linta.de> <alpine.LFD.2.02.1106062353030.4784@x980> <20110607054226.GA22398@isilmar-3.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from isilmar-3.linta.de ([188.40.101.200]:44576 "EHLO linta.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750882Ab1FGGB0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 7 Jun 2011 02:01:26 -0400
Content-Disposition: inline
In-Reply-To: <20110607054226.GA22398@isilmar-3.linta.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, cpufreq@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>

A correction:

On Tue, Jun 07, 2011 at 07:42:26AM +0200, Dominik Brodowski wrote:
> > > Finally:
> > > 
> > > > +	policy->cur = data->freq_table[data->acpi_data->state].frequency;
> > > 
> > > How do you know what state / frequency the CPU is running here?
> > 
> > really the correct fix is for the upper level of cpufreq to
> > simply no export this value at all, or to export the value
> > that was last written.  A driver should be free to decline
> > to supply any current value.
> 
> You didn't answer the question of how it is assured that policy->cur is
> correctly initialized here.

I just checked, and if it is initialized wrongly here, it doesn't matter
much due to patch 4b31e774 .

Best,
	Dominik
