From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: eeepc-laptop: bugreport
Date: Sun, 15 Nov 2009 18:15:02 +0000
Message-ID: <20091115181502.GA3013@srcf.ucam.org>
References: <71cd59b00911150139i5d7377cawda04a17e5e50d05e@mail.gmail.com> <cone.1258285991.924736.2588.1000@eeekiste> <4AFFF61E.6090707@tuffmail.co.uk> <cone.1258301205.852230.1663.1000@eeekiste> <4B002951.4080704@tuffmail.co.uk> <cone.1258304218.643429.1671.1000@eeekiste> <4B00354A.7000300@tuffmail.co.uk> <71cd59b00911150917k7d677fd0g509ab4edc1786fb1@mail.gmail.com> <20091115180630.GA2921@srcf.ucam.org> <cone.1258308685.306474.1656.1000@eeekiste>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:51231 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753388AbZKOSO7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Nov 2009 13:14:59 -0500
Content-Disposition: inline
In-Reply-To: <cone.1258308685.306474.1656.1000@eeekiste>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: andrej.gelenberg@udo.edu
Cc: Corentin Chary <corentin.chary@gmail.com>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, linux acpi <linux-acpi@vger.kernel.org>

On Sun, Nov 15, 2009 at 07:11:25PM +0100, andrej.gelenberg@udo.edu wrote:

> There was a patch for ACPI with new OSI (for Windows Vista and 7).
> EEE PC ACPI have no support for that, but linux (and older Windows).

Or, rather, it assumes a different programming model for Windows 7. 
Interesting. Maybe it'll be less painful. Do we have ACPI dumps for the 
new firmware?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
