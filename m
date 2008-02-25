From: "Michael S. Tsirkin" <m.s.tsirkin@gmail.com>
Subject: Re: new regression in 2.6.25-rc3: no keyboard/lid acpi events on thinkpad T61p
Date: Tue, 26 Feb 2008 01:18:30 +0200
Message-ID: <8f53421d0802251518p5959d820o7a1979cefb96210a@mail.gmail.com>
References: <8f53421d0802251119q470a79c1p31048ef136271f84@mail.gmail.com>
	 <47C31A1E.7080305@suse.de>
	 <8f53421d0802251239h6b872d94w677995789990e31b@mail.gmail.com>
	 <47C32A1D.8030604@suse.de>
	 <8f53421d0802251301g247506e9jb341b9012dac71d7@mail.gmail.com>
	 <47C34246.2020705@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:15224 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbYBYXSd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Feb 2008 18:18:33 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1017261ugc.16
        for <linux-acpi@vger.kernel.org>; Mon, 25 Feb 2008 15:18:31 -0800 (PST)
In-Reply-To: <47C34246.2020705@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org

On Tue, Feb 26, 2008 at 12:33 AM, Alexey Starikovskiy
<astarikovskiy@suse.de> wrote:
>  > Attached is the acpidump output run under 2.6.23-rc3 + with reverted
>  > 37f9b4c7c612fcbeb8fb6faddaef4ccdb5350145
>  > (IOW - this is a working configuration).
>  Thanks, you've got round 10100 bug number.
>
>  Please check if the following patch on top of Linus git tree helps.
>
>  Regards,
>  Alex

I did some light testing, but yes, this seems to help.
With this patch applied on top of 2.6.25-rc3, I get keyboard acpi events again,
so that I can suspend by clicking Fn+F4.

-- 
MST
