From: "Jesper Juhl" <jesper.juhl@gmail.com>
Subject: Re: [PATCH]Let's not gamble that a possible double free will never happen in asus_hotk_get_info()
Date: Sat, 4 Aug 2007 18:14:05 +0200
Message-ID: <9a8748490708040914x2959fe0n20c542552120362a@mail.gmail.com>
References: <200707290045.59698.jesper.juhl@gmail.com>
	 <200708031614.09792.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.246]:55940 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755954AbXHDQOG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 4 Aug 2007 12:14:06 -0400
Received: by an-out-0708.google.com with SMTP id d31so206291and
        for <linux-acpi@vger.kernel.org>; Sat, 04 Aug 2007 09:14:05 -0700 (PDT)
In-Reply-To: <200708031614.09792.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Julien Lerouge <julien.lerouge@free.fr>, Karol Kozimor <sziwan@users.sourceforge.net>, linux-acpi@vger.kernel.org, corentincj@iksaif.net, acpi4asus-user@lists.sourceforge.net

On 03/08/07, Len Brown <lenb@kernel.org> wrote:
> On Saturday 28 July 2007 18:45, Jesper Juhl wrote:
> > Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> > ---
> >
> > drivers/acpi/asus_acpi.c | 1 +
> > 1 files changed, 1 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/acpi/asus_acpi.c b/drivers/acpi/asus_acpi.c
> > index 9c4bd22..86fd142 100644
> > --- a/drivers/acpi/asus_acpi.c
> > +++ b/drivers/acpi/asus_acpi.c
> > @@ -1192,6 +1192,7 @@ static int asus_hotk_get_info(void)
> > break;
> > default:
> > kfree(model);
> > +model = NULL;
> > break;
> > }
> > }
>
> applied.
>
> coverity didn't find the bug below this code however.
> we can also leak model in the path that returns  OK.
>
Whoops, I should have spotted that.  I assume you've now fixed that locally?

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
