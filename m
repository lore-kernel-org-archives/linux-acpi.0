From: Thomas Renninger <trenn@suse.de>
Subject: Re: Core i7 & C-States
Date: Mon, 22 Nov 2010 23:48:05 +0100
Message-ID: <201011222348.05689.trenn@suse.de>
References: <AANLkTik+zt0FC7chXJojaqtAMC5DsfLHKcU1FVAJEXAn@mail.gmail.com> <E92FAF79A8BBC642A36EEE3AA7F152D8852BAE3D01@GVW1089EXB.americas.hpqcorp.net> <4911F71203A09E4D9981D27F9D830858BC7B3326@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55404 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757557Ab0KVWsJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 22 Nov 2010 17:48:09 -0500
In-Reply-To: <4911F71203A09E4D9981D27F9D830858BC7B3326@orsmsx503.amr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Koornstra, Reinoud" <koornstra@hp.com>, Greg Oliver <oliver.greg2@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Monday 22 November 2010 11:36:49 pm Moore, Robert wrote:
> Sounds like we are back to the old question on this: What does Windows
> *really* do? 
Yep and for now it's only guessing, I should not have been
so verbose and just ask to open a bug. Greg, please attach there
(https://bugzilla.kernel.org):
- dmesg of the not freezing kernel
- acpidump output
- dmidecode output
- version of used kernel
- short description of the problem
- whatever else might be interesting

Possibly this is just resolved with a BIOS update?

Thanks,

     Thomas
