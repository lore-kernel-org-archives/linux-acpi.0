From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: eeepc-laptop: bugreport
Date: Sun, 15 Nov 2009 15:52:02 +0000
Message-ID: <20091115155202.GA1019@srcf.ucam.org>
References: <cone.1258203372.445001.1633.1000@eeekiste> <71cd59b00911140641i1502e95bt81d87db848feaf0@mail.gmail.com> <cone.1258211472.464906.1633.1000@eeekiste> <71cd59b00911150139i5d7377cawda04a17e5e50d05e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:52441 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606AbZKOPwC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Nov 2009 10:52:02 -0500
Content-Disposition: inline
In-Reply-To: <71cd59b00911150139i5d7377cawda04a17e5e50d05e@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: andrej.gelenberg@udo.edu, linux acpi <linux-acpi@vger.kernel.org>, acpi4asus-user@lists.sourceforge.net, Alan Jenkins <alan-jenkins@tuffmail.co.uk>

On Sun, Nov 15, 2009 at 10:39:22AM +0100, Corentin Chary wrote:

> Matthew, you added hotplug in commit  5740294ca3a9b113fe146f2826effb69ca50008d,
> it was needed for 701/900/901. Do you know if it's still needed for 1005ha ?

If people are poking about to force rescans of the PCI bus, it's still 
needed.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
