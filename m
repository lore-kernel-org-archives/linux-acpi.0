From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] ACPICA: AcpiGetSleepTypeData: Failure to find \_Sx
 should not result in a loud warning
Date: Wed, 7 Oct 2015 15:52:44 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D362FF7@ORSMSX112.amr.corp.intel.com>
References: <1443720528-14499-1-git-send-email-prarit@redhat.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37D357F6E@ORSMSX112.amr.corp.intel.com>
 <560DB3A7.2010405@intel.com> <56153A35.4090705@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:58663 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753178AbbJGPwq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Oct 2015 11:52:46 -0400
In-Reply-To: <56153A35.4090705@redhat.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "devel@acpica.org" <devel@acpica.org>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Box, David E" <david.e.box@intel.com>

It would be easy to remove (or partially remove) the warning. Hopefully the calling code will handle AE_NOT_FOUND correctly. 

> -----Original Message-----
> From: Prarit Bhargava [mailto:prarit@redhat.com]
> Sent: Wednesday, October 07, 2015 8:29 AM
> To: Wysocki, Rafael J; Moore, Robert; devel@acpica.org
> Cc: Zheng, Lv; Len Brown; linux-acpi@vger.kernel.org; Box, David E
> Subject: Re: [PATCH] ACPICA: AcpiGetSleepTypeData: Failure to find \_Sx
> should not result in a loud warning
> 
> 
> 
> On 10/01/2015 06:28 PM, Rafael J. Wysocki wrote:
> > On 10/1/2015 7:57 PM, Moore, Robert wrote:
> >> I seem to remember that this came up a long time ago.
> >>
> >> Perhaps someone else will remember.
> >>
> >
> > I can't recall, sorry.
> 
> FWIW, a google search on these warnings yields tonnes of comments about
> them, but with no resolution AFAICT.
> 
> P.
