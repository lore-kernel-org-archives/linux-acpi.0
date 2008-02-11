From: "Dennis Jansen" <d.g.jansen@googlemail.com>
Subject: Re: If "acpi_osi=Linux" works better, pleas e notify linux-acpi@vger.kernel.org
Date: Mon, 11 Feb 2008 13:39:00 +0100
Message-ID: <e678b6ed0802110439r161ef4a2i28702047aa8eefb@mail.gmail.com>
References: <e678b6ed0802100637s5d8037kcdc1e0580b11b0d1@mail.gmail.com>
	 <200802102129.14622.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:31724 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154AbYBKMjE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Feb 2008 07:39:04 -0500
Received: by py-out-1112.google.com with SMTP id u52so6807542pyb.10
        for <linux-acpi@vger.kernel.org>; Mon, 11 Feb 2008 04:39:01 -0800 (PST)
In-Reply-To: <200802102129.14622.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Feb 11, 2008 3:29 AM, Len Brown <lenb@kernel.org> wrote:
> In both BIOS V1.21 and V1.31 it appears to be a no-op.
> The only way I could imagine it could have an effect is if
> somethign in SMM is looking at the LINX variable.
>
> Based on past lack of Linux awareness from this particular vendor,
> the chances of that happening seem quite small.
>
> thanks,
> -Len
>
It was the suspend/resume process and the subsequent use of the C2
state that made the difference.
And the wireless stability is also another issue.
Sorry, guess it was wishful thinking.
