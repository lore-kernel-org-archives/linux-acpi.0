From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Re: [patch 1/1] acpi: cleanup u32 flags in spin_lock calls
Date: Wed, 4 Jan 2006 15:15:13 -0800
Message-ID: <20060104151513.284a602e.akpm@osdl.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B300599CF4E@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B300599CF4E-N2PTB0HCzHKkrb+BlOpmy7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

"Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
>
>  
> >Updated..
> 
> Andrew, Steven,
> 
> (and I'm sorry I have to bother you by asking this...)
> 
> Please acknowldge that you license this patch back to Intel
> according either license appearing at the top of the acpi files changed.

So acknowledged.

> Doing so means that we can apply this patch or a derivative of it "upstream"
> in the ACPICA core, which Linux shares with FreeBSD etc.

Understood.

> Not doing so means that your path is licensed as GPL only, and if
> I check it into Linux, then I have created a permanent divergence between
> Linux and the shared ACPICA interpreter -- not a disaster, but
> a headache for me when I don't really need more headaches.

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
