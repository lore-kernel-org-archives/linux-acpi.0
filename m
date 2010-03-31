From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [lm-sensors] [PATCH] hwmon: (asus_atk0110) Don't load if ACPI
	resources aren't enforced
Date: Wed, 31 Mar 2010 13:51:23 +0100
Message-ID: <20100331125122.GA16583@srcf.ucam.org>
References: <20100309135636.373a40a9@hyperion.delvare> <20100330120319.627e8f9a@hyperion.delvare> <20100330132132.GA16657@srcf.ucam.org> <20100330214732.42f488ba@hyperion.delvare> <20100330194835.GA32322@srcf.ucam.org> <20100330223251.76c6b000@hyperion.delvare> <20100330211049.GA1524@srcf.ucam.org> <68676e01003301445v1b3ee070nfc0f0b53716c4740@mail.gmail.com> <20100330215305.GA2220@srcf.ucam.org> <20100331093004.5143415f@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:50975 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381Ab0CaMv1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Mar 2010 08:51:27 -0400
Content-Disposition: inline
In-Reply-To: <20100331093004.5143415f@hyperion.delvare>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Luca Tettamanti <kronos.it@gmail.com>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

On Wed, Mar 31, 2010 at 09:30:04AM +0200, Jean Delvare wrote:

> It definitely does. At least on some of the affected boards, no access
> to the I/O area in question is done at all as long as the asus_atk0110
> driver is not loaded.

You've audited the system management code?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
